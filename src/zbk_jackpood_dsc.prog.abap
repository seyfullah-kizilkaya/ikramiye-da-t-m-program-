*&---------------------------------------------------------------------*
*& Report ZBK_JACKPOOD_DSC
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbk_jackpood_dsc.

INCLUDE : zbk_jackpood_dsc_top,
          zbk_jackpood_dsc_cls,
          zbk_jackpood_dsc_mdl.

START-OF-SELECTION.
  CREATE OBJECT go_main.
  go_main->start_screen( ).
