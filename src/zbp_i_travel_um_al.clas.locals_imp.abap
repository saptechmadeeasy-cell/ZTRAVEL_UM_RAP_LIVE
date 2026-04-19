class cl_buffer defiNITION.

pubLIC SECTION.
 class-data: gt_create_travel type table of ztravel_um_al.

endCLASS.


CLASS lhc_ZI_TRAVEL_UM_AL DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_travel_um_al RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zi_travel_um_al RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE zi_travel_um_al.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zi_travel_um_al.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zi_travel_um_al.

    METHODS read FOR READ
      IMPORTING keys FOR READ zi_travel_um_al RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK zi_travel_um_al.

    METHODS rba_Booking FOR READ
      IMPORTING keys_rba FOR READ zi_travel_um_al\_Booking FULL result_requested RESULT result LINK association_links.

    METHODS cba_Booking FOR MODIFY
      IMPORTING entities_cba FOR CREATE zi_travel_um_al\_Booking.

ENDCLASS.

CLASS lhc_ZI_TRAVEL_UM_AL IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  if requested_authorizations-%create is not inITIAL.

   result-%create = if_abap_behv=>auth-allowed.
  endif.



  ENDMETHOD.

  METHOD create.
*
*    TYPES: tt_travel_um  TYPE TABLE FOR MAPPED EARLY zi_travel_um_al.
*    DATA: lt_travel_um TYPE tt_travel_um.
*    DATA: ls_travel_um LIKE LINE OF lt_travel_um.
get time STAMP FIELD data(lv_ts).


*    data: lt_create_travel type table of ztravel_um_al.
    data: ls_create_travel type ztravel_um_al.


    loop at entities into data(ls_entity).

*    ls_create_travel-client = sy-mandt.
*    ls_create_travel-description = ls_entity-description.
*    ls_create_travel-travel_id = ls_entity-travel_id.


    ls_create_travel = correspONDING #( ls_entity  ).


    ls_create_travel-last_changed_at = lv_ts.

*    append ls_create_travel to lt_create_travel.
    append ls_create_travel to cl_buffer=>gt_create_travel.


*    insert ztravel_um_al from table @lt_create_travel. "





    endloop.



*    ls_travel_um-%cid = 'Create_Travel1'.
*    ls_travel_um-%is_draft = if_abap_behv=>mk-on.
*
*    TRY.
*        ls_travel_um-travel_uuid = cl_system_uuid=>create_uuid_x16_static( ).
*      CATCH   cx_uuid_error .
*    ENDTRY.
*
*    APPEND ls_travel_um TO lt_travel_um.
*
*
*    mapped-zi_travel_um_al = lt_travel_um.

  ENDMETHOD.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.

  data: lt_result type  table for read result zi_travel_um_al.
  data: ls_result like line of lt_result.



  "select the data from the draft table when you click on edit button
  select * from ztravel_um_al for all eNTRIES IN @keys where travel_uuid = @keys-travel_uuid
  into table @data(lt_draft_data).


  loop at lt_draft_data into data(ls_draft_data).

  ls_result = corrESPONDING #( ls_draft_data  ).
  ls_result-%is_draft = if_abap_behv=>mk-on.


  append ls_result to lt_result.
  endLOOP.

  result = lt_result.


  .
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD rba_Booking.
  ENDMETHOD.

  METHOD cba_Booking.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZI_BOOKING_UM_AL DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE zi_booking_um_al.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE zi_booking_um_al.

    METHODS read FOR READ
      IMPORTING keys FOR READ zi_booking_um_al RESULT result.

    METHODS rba_Travel FOR READ
      IMPORTING keys_rba FOR READ zi_booking_um_al\_Travel FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_ZI_BOOKING_UM_AL IMPLEMENTATION.

  METHOD update.
  ENDMETHOD.

  METHOD delete.
  ENDMETHOD.

  METHOD read.
  ENDMETHOD.

  METHOD rba_Travel.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_TRAVEL_UM_AL DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_TRAVEL_UM_AL IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  if cl_buffer=>gt_create_travel is not initial.
   insert ztravel_um_al from table @cl_buffer=>gt_create_travel..
   endif.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
