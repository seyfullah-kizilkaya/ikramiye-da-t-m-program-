*&---------------------------------------------------------------------*
*& Include          ZBK_JACKPOOD_DSC_TOP
*&---------------------------------------------------------------------*
CLASS lcl_main DEFINITION DEFERRED.

DATA: go_main      TYPE REF TO lcl_main,
      go_grid      TYPE REF TO cl_gui_alv_grid,
      go_container TYPE REF TO cl_gui_custom_container,

      gt_fcat      TYPE lvc_t_fcat,
      gs_layout    TYPE lvc_s_layo,

      gt_alvtable  TYPE TABLE OF zbk_pers_ikm,
      gs_alvtable  TYPE zbk_pers_ikm,

      gv_ttlyr     TYPE int4.
PARAMETERS: p_butce TYPE int4.
