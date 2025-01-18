*&---------------------------------------------------------------------*
*& Include          ZBK_JACKPOOD_DSC_CLS
*&---------------------------------------------------------------------*
CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    METHODS:
      start_screen,
      pbo_0100,
      pai_0100 IMPORTING iv_ucomm TYPE sy-ucomm,
      get_data,
      set_fcat,
      set_layout,
      display_alv.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.
  METHOD start_screen.
    CALL SCREEN 0100.
  ENDMETHOD.

  METHOD pbo_0100.
    SET PF-STATUS '0100'.
    go_main->get_data( ).
    go_main->set_fcat( ).
    go_main->set_layout( ).
    go_main->display_alv( ).
  ENDMETHOD.

  METHOD pai_0100.
    CASE iv_ucomm.
      WHEN '&BACK'.
        SET SCREEN 0.
    ENDCASE.
  ENDMETHOD.


  METHOD get_data.
    DATA: lt_perstab TYPE TABLE OF zbk_pers_ikm,
          ls_pers2   TYPE zbk_pers_ikm,  "Loop için structure
          ls_pers    TYPE zbk_pers_ikm.  "İkinci loop için structure

    SELECT * FROM zbk_pers_ikm INTO TABLE lt_perstab.

    LOOP AT lt_perstab INTO  ls_pers2 .
      gv_ttlyr = gv_ttlyr + ls_pers2-pers_yil.
    ENDLOOP.

    LOOP AT lt_perstab INTO  ls_pers .
      gs_alvtable-pers_id = ls_pers-pers_id.
      gs_alvtable-pers_ad = ls_pers-pers_ad.
      gs_alvtable-pers_soyad = ls_pers-pers_soyad.
      gs_alvtable-pers_yil = ls_pers-pers_yil.
      gs_alvtable-ikm_mkt = ls_pers-pers_yil * ( p_butce / gv_ttlyr ).

      APPEND gs_alvtable TO gt_alvtable.
      CLEAR gs_alvtable.
    ENDLOOP.
  ENDMETHOD.

  METHOD set_fcat.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'zbk_pers_ikm'
      CHANGING
        ct_fieldcat      = gt_fcat.
  ENDMETHOD.

  METHOD set_layout.
    gs_layout-zebra = 'X'.
    gs_layout-cwidth_opt = 'X'.
    gs_layout-col_opt = 'X'.
  ENDMETHOD.
  METHOD display_alv.
    IF go_grid IS INITIAL.
      CREATE OBJECT go_container
        EXPORTING
          container_name = 'CC_ALV'.

      CREATE OBJECT go_grid
        EXPORTING
          i_parent = go_container.

      go_grid->set_table_for_first_display(
        EXPORTING
          is_layout = gs_layout  " Layout
        CHANGING
          it_outtab     = gt_alvtable  " Output Table
          it_fieldcatalog = gt_fcat    " Field Catalog
      ).
    ELSE.
      CALL METHOD go_grid->refresh_table_display.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
