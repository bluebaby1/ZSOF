class ZCL_GTT_TOOLKIT definition
  public
  final
  create public .

public section.

  types:
    BEGIN OF ts_stop_points,
        stop_id   TYPE string,
        log_locid TYPE /scmtms/location_id,
        seq_num   TYPE /scmtms/seq_num,
      END OF ts_stop_points .
  types:
    BEGIN OF ts_tor_data,
        delivery_number       TYPE vbeln_vl,
        delivery_item_number  TYPE posnr_vl,
        freight_unit_number   TYPE /scmtms/tor_id,
        freight_unit_root_key TYPE /bobf/s_frw_key-key,
      END OF ts_tor_data .
  types:
    tt_stop_points TYPE STANDARD TABLE OF ts_stop_points .
  types:
    tt_expeventdata TYPE STANDARD TABLE OF /saptrx/exp_events .
  types:
    tt_tor_data TYPE STANDARD TABLE OF ts_tor_data .
  types:
    BEGIN OF ty_delivery_item,
        delivery_number      TYPE vbeln_vl,
        delivery_item_number TYPE posnr_vl,
        freight_unit_number  TYPE /scmtms/tor_id,
        change_mode          TYPE /bobf/conf_change_mode,
        stop_id_dst          TYPE /scmtms/stop_id,
        log_locid_dst        TYPE /scmtms/location_id,
        country_code_dst     TYPE land1,
        city_name_dst	       TYPE	ad_city1,
        evt_exp_datetime     TYPE /saptrx/event_exp_datetime,
        evt_exp_tzone        TYPE /saptrx/timezone,
      END OF ty_delivery_item .
  types:
    tt_delivery_item TYPE TABLE OF ty_delivery_item .

  constants:
    BEGIN OF cs_milestone,
        fo_load_start    TYPE /saptrx/appl_event_tag VALUE 'LOAD_BEGIN',
        fo_load_end      TYPE /saptrx/appl_event_tag VALUE 'LOAD_END',
        fo_coupling      TYPE /saptrx/appl_event_tag VALUE 'COUPLING',
        fo_decoupling    TYPE /saptrx/appl_event_tag VALUE 'DECOUPLING',
        fo_shp_departure TYPE /saptrx/appl_event_tag VALUE 'DEPARTURE',
        fo_shp_arrival   TYPE /saptrx/appl_event_tag VALUE 'ARRIV_DEST',
        fo_shp_pod       TYPE /saptrx/appl_event_tag VALUE 'POD',
        fo_unload_start  TYPE /saptrx/appl_event_tag VALUE 'UNLOAD_BEGIN',
        fo_unload_end    TYPE /saptrx/appl_event_tag VALUE 'UNLOAD_END',
      END OF cs_milestone .
  constants:
    BEGIN OF cs_location_type,
        logistic TYPE string VALUE 'LogisticLocation',
      END OF cs_location_type .
  class-data GT_DELIVERY_ITEM type TT_DELIVERY_ITEM .

  methods SHP_ARRIVAL
    importing
      !IV_ROOT_KEY type /BOBF/S_FRW_KEY-KEY
      !IS_EXPEVENTDATA type /SAPTRX/EXP_EVENTS
      !IT_STOP type /SCMTMS/T_TOR_STOP_K
      !IT_LOC_ADDR type /BOFU/T_ADDR_POSTAL_ADDRESSK
      !IT_CAPA_STOP type /SCMTMS/T_TOR_STOP_K
      !IT_CAPA_ROOT type /SCMTMS/T_TOR_ROOT_K
      !IT_LOC_ROOT type /SCMTMS/T_BO_LOC_ROOT_K
    exporting
      !ET_EXPEVENTDATA type TT_EXPEVENTDATA .
  methods SHP_DEPARTURE
    importing
      !IV_ROOT_KEY type /BOBF/S_FRW_KEY-KEY
      !IS_EXPEVENTDATA type /SAPTRX/EXP_EVENTS
      !IT_STOP type /SCMTMS/T_TOR_STOP_K
      !IT_LOC_ADDR type /BOFU/T_ADDR_POSTAL_ADDRESSK
      !IT_CAPA_STOP type /SCMTMS/T_TOR_STOP_K
      !IT_CAPA_ROOT type /SCMTMS/T_TOR_ROOT_K
      !IT_LOC_ROOT type /SCMTMS/T_BO_LOC_ROOT_K
    exporting
      !ET_EXPEVENTDATA type TT_EXPEVENTDATA .
  methods POD
    importing
      !IV_ROOT_KEY type /BOBF/S_FRW_KEY-KEY
      !IS_EXPEVENTDATA type /SAPTRX/EXP_EVENTS
      !IT_STOP type /SCMTMS/T_TOR_STOP_K
      !IT_STOP_LAST type /SCMTMS/T_TOR_STOP_K
      !IT_LOC_ADDR type /BOFU/T_ADDR_POSTAL_ADDRESSK
      !IT_ROOT type /SCMTMS/T_TOR_ROOT_K optional
      !IT_LOC_ROOT type /SCMTMS/T_BO_LOC_ROOT_K
    exporting
      !ET_EXPEVENTDATA type TT_EXPEVENTDATA .
  class-methods GET_INSTANCE
    returning
      value(RO_INSTANCE) type ref to ZCL_GTT_TOOLKIT .
  methods CONVERSION_ALPHA_INPUT
    importing
      !IV_INPUT type CLIKE
    exporting
      !EV_OUTPUT type CLIKE .
  methods GET_RELATION
    importing
      !IV_VBELN type VBELN_VL
      !IV_POSNR type POSNR_VL optional
    exporting
      !ET_RELATION type TT_TOR_DATA
      !ET_ROOT_KEY type /BOBF/T_FRW_KEY .
  methods CHECK_INTEGRATION_MODE
    importing
      !IV_VSTEL type VSTEL
      !IV_LFART type LFART
      !IV_VSBED type VSBED
    exporting
      !EV_INTERNAL_INT type BOOLE_D .
  methods GET_STOP_INFO
    importing
      !IT_ROOT_KEY type /BOBF/T_FRW_KEY
    exporting
      !ET_STOP_LAST type /SCMTMS/T_TOR_STOP_K
      !ET_STOP type /SCMTMS/T_TOR_STOP_K
      !ET_LOC_ADDR type /BOFU/T_ADDR_POSTAL_ADDRESSK
      !ET_ROOT type /SCMTMS/T_TOR_ROOT_K
      !ET_CAPA_STOP type /SCMTMS/T_TOR_STOP_K
      !ET_CAPA_ROOT type /SCMTMS/T_TOR_ROOT_K
      !ET_LOC_ROOT type /SCMTMS/T_BO_LOC_ROOT_K .
  methods GET_CAPA_MATCHKEY
    importing
      !IV_ASSGN_STOP_KEY type /SCMTMS/TOR_STOP_KEY
      !IT_CAPA_STOP type /SCMTMS/T_TOR_STOP_K
      !IT_CAPA_ROOT type /SCMTMS/T_TOR_ROOT_K
    exporting
      value(EV_CAPA_MATCHKEY) type STRING .
  methods GET_STOP_POINTS
    importing
      !IV_ROOT_ID type /SCMTMS/TOR_ID
      !IT_STOP type /SCMTMS/T_EM_BO_TOR_STOP
    exporting
      !ET_STOP_POINTS type TT_STOP_POINTS .
  methods IS_ODD
    importing
      !IV_VALUE type N
    returning
      value(RV_IS_ODD) type ABAP_BOOL .
  methods CONVERT_UTC_TIMESTAMP
    importing
      !IV_TIMEZONE type TTZZ-TZONE
      !IV_TIMESTAMP type TZNTSTMPSL
    returning
      value(RV_TIMESTAMP) type TZNTSTMPSL .
protected section.

  class-data GO_ME type ref to ZCL_GTT_TOOLKIT .
private section.

  types:
    BEGIN OF ts_likp,
      vbeln TYPE likp-vbeln,
      vstel TYPE likp-vstel,
      lfart TYPE likp-lfart,
      vsbed TYPE likp-vsbed,
    END OF ts_likp .
  types:
    BEGIN OF ts_vbak,
      vbeln TYPE vbak-vbeln,
      vkorg TYPE vbak-vkorg,
      vtweg TYPE vbak-vtweg,
      spart TYPE vbak-spart,
      auart TYPE vbak-auart,
      vsbed TYPE vbak-vsbed,
    END OF ts_vbak .
  types:
    BEGIN OF ts_vbfa,
      vbelv   TYPE vbfa-vbelv,
      posnv   TYPE vbfa-posnv,
      vbeln   TYPE vbfa-vbeln,
      posnn   TYPE vbfa-posnn,
      vbtyp_n TYPE vbfa-vbtyp_n,
    END OF ts_vbfa .
  types:
    BEGIN OF ts_tms_c_shp,
      vstel       TYPE tms_c_shp-vstel,
      lfart       TYPE tms_c_shp-lfart,
      vsbed       TYPE tms_c_shp-vsbed,
      tm_ctrl_key TYPE tms_c_shp-tm_ctrl_key,
    END OF ts_tms_c_shp .
  types:
    BEGIN OF ts_tms_c_sls,
      vkorg       TYPE tms_c_sls-vkorg,
      vtweg       TYPE tms_c_sls-vtweg,
      spart       TYPE tms_c_sls-spart,
      auart       TYPE tms_c_sls-auart,
      vsbed       TYPE tms_c_sls-vsbed,
      tm_ctrl_key TYPE tms_c_sls-tm_ctrl_key,
    END OF ts_tms_c_sls .
  types:
    BEGIN OF ts_tms_c_control,
      tm_ctrl_key   TYPE tms_c_control-tm_ctrl_key,
      sls_to_tm_ind TYPE tms_c_control-sls_to_tm_ind,
      od_to_tm_ind  TYPE tms_c_control-od_to_tm_ind,
    END OF ts_tms_c_control .
ENDCLASS.



CLASS ZCL_GTT_TOOLKIT IMPLEMENTATION.


  METHOD CHECK_INTEGRATION_MODE.

    DATA:
      ls_tms_c_shp     TYPE tms_s_shp,
      ls_tms_c_control TYPE tms_s_control.

    CLEAR:
      ev_internal_int.

*   Get Integration Relevance SHP
    cl_tms_int_cust=>get_tms_c_shp(
       EXPORTING
         iv_vstel     = iv_vstel
         iv_lfart     = iv_lfart
         iv_vsbed     = iv_vsbed
       IMPORTING
         es_tms_c_shp = ls_tms_c_shp ).

*   Get control from control key
    cl_tms_int_cust=>read_tms_c_control(
      EXPORTING
        iv_tm_ctrl_key   = ls_tms_c_shp-tm_ctrl_key
      IMPORTING
        es_tms_c_control = ls_tms_c_control ).

    IF ls_tms_c_control-sls_to_tm_ind = abap_true OR ls_tms_c_control-od_to_tm_ind  = abap_true .
      ev_internal_int = abap_true.
    ENDIF..

  ENDMETHOD.


  METHOD CONVERSION_ALPHA_INPUT.

    CLEAR:ev_output.

    CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
      EXPORTING
        input  = iv_input
      IMPORTING
        output = ev_output.

  ENDMETHOD.


  METHOD convert_utc_timestamp.

**********************************************************
* Local data declaration                                 *
**********************************************************
    DATA:
      lv_timestamp TYPE timestamp,
      lv_date      TYPE d,
      lv_time      TYPE t,
      lv_tz_utc    TYPE ttzz-tzone VALUE 'UTC',
      lv_dst       TYPE c LENGTH 1.


**********************************************************
* First convert: timestamp -> date & time                *
**********************************************************
    lv_timestamp = iv_timestamp.
    CONVERT TIME STAMP lv_timestamp TIME ZONE iv_timezone
            INTO DATE lv_date TIME lv_time DAYLIGHT SAVING TIME lv_dst.

**********************************************************
* Convert back: date & time -> timestamp                 *
**********************************************************
    CONVERT DATE lv_date TIME lv_time DAYLIGHT SAVING TIME lv_dst
            INTO TIME STAMP lv_timestamp TIME ZONE lv_tz_utc.
    rv_timestamp = lv_timestamp.

  ENDMETHOD.


  METHOD GET_CAPA_MATCHKEY.

    DATA:
      ls_capa_stop TYPE /scmtms/s_tor_stop_k,
      ls_capa_root TYPE /scmtms/s_tor_root_k,
      lt_root_key  TYPE /bobf/t_frw_key,
      ls_root_key  TYPE /bobf/s_frw_key,
      lt_stop_seq  TYPE /scmtms/t_pln_stop_seq_d,
      lt_stop      TYPE /scmtms/t_em_bo_tor_stop,
      lv_tor_id    TYPE /scmtms/s_tor_root_k-tor_id,
      lv_seq_num   TYPE sytabix.

    CLEAR:ev_capa_matchkey.

    CLEAR ls_capa_stop.
    READ TABLE it_capa_stop INTO ls_capa_stop WITH KEY key = iv_assgn_stop_key.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    CLEAR ls_capa_root.
    READ TABLE it_capa_root INTO ls_capa_root WITH KEY key = ls_capa_stop-parent_key.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.
    lv_tor_id = ls_capa_root-tor_id.

    ls_root_key-key = ls_capa_stop-parent_key.
    APPEND ls_root_key TO lt_root_key.

    /scmtms/cl_tor_helper_stop=>get_stop_sequence(
      EXPORTING
        it_root_key     = lt_root_key
        iv_before_image = abap_false
      IMPORTING
        et_stop_seq_d   = lt_stop_seq ).

    READ TABLE lt_stop_seq INTO DATA(ls_stop_seq)
      WITH KEY root_key = ls_capa_stop-parent_key.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    lt_stop = CORRESPONDING /scmtms/t_em_bo_tor_stop( ls_stop_seq-stop_seq ).

    READ TABLE ls_stop_seq-stop_map INTO DATA(ls_stop_map)
      WITH KEY stop_key = ls_capa_stop-key.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.
    lv_seq_num = ls_stop_map-tabix.

    me->get_stop_points(
      EXPORTING
        iv_root_id     = lv_tor_id               " Document
        it_stop        = lt_stop                 " Table Type for BO Transportation Order Stop (EM Integration)
      IMPORTING
        et_stop_points = DATA(lt_stop_points) ).

    READ TABLE lt_stop_points INTO DATA(ls_stop_points)
      WITH KEY seq_num   = lv_seq_num
               log_locid = ls_capa_stop-log_locid.
    IF sy-subrc = 0.
      ev_capa_matchkey = ls_stop_points-stop_id.
      SHIFT ev_capa_matchkey LEFT DELETING LEADING '0'.
    ENDIF.

  ENDMETHOD.


  METHOD GET_INSTANCE.

    IF go_me IS INITIAL.
      CREATE OBJECT go_me.
    ENDIF.
    ro_instance = go_me.

  ENDMETHOD.


  METHOD get_relation.

    DATA:
      lo_srvmgr_tor  TYPE REF TO /bobf/if_tra_service_manager,
      lt_item_tr_key TYPE /bobf/t_frw_key,
      ls_item_tr_key TYPE /bobf/s_frw_key,
      lt_base_doc    TYPE /scmtms/t_base_document_w_item,
      ls_base_doc    TYPE /scmtms/s_base_document_w_item,
      lt_result      TYPE /bobf/t_frw_keyindex,
      ls_result      TYPE /bobf/s_frw_keyindex,
      lv_sys         TYPE tbdls-logsys,
      lt_fu          TYPE /scmtms/t_tor_root_k,
      ls_relation    TYPE ts_tor_data,
      ls_root_key    TYPE /bobf/s_frw_key.

    CLEAR:
      et_relation,
      et_root_key.

    CALL FUNCTION 'OWN_LOGICAL_SYSTEM_GET'
      IMPORTING
        own_logical_system             = lv_sys
      EXCEPTIONS
        own_logical_system_not_defined = 1
        OTHERS                         = 2.

    ls_base_doc-base_btd_logsys = lv_sys.
    ls_base_doc-base_btd_tco = /scmtms/if_common_c=>c_btd_tco-outbounddelivery.

    me->conversion_alpha_input(
      EXPORTING
        iv_input  = iv_vbeln
      IMPORTING
        ev_output = ls_base_doc-base_btd_id ).

    IF iv_posnr IS NOT INITIAL.
      me->conversion_alpha_input(
        EXPORTING
          iv_input  = iv_posnr
        IMPORTING
          ev_output = ls_base_doc-base_btditem_id ).
    ENDIF.

    APPEND ls_base_doc TO lt_base_doc.

***********************************************************************
** get instance service manager for BO /SCMTMS/TOR                    *
***********************************************************************
*   instance servicemanger for BO
    lo_srvmgr_tor = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( iv_bo_key = /scmtms/if_tor_c=>sc_bo_key ).

***********************************************************************
**  Converts an alternative key to the technical key                  *
***********************************************************************
    lo_srvmgr_tor->convert_altern_key(
      EXPORTING
        iv_node_key          = /scmtms/if_tor_c=>sc_node-item_tr
        iv_altkey_key        = /scmtms/if_tor_c=>sc_alternative_key-item_tr-base_document
        it_key               = lt_base_doc
      IMPORTING
        et_result            = lt_result ).  " Key table with explicit index

***********************************************************************
**  FU Root Assocation                                                *
***********************************************************************
    LOOP AT lt_result INTO ls_result.
      ls_item_tr_key-key = ls_result-key.
      APPEND ls_item_tr_key TO lt_item_tr_key.
      CLEAR ls_item_tr_key.
    ENDLOOP.

    lo_srvmgr_tor->retrieve_by_association(
      EXPORTING
        iv_node_key    = /scmtms/if_tor_c=>sc_node-item_tr
        it_key         = lt_item_tr_key
        iv_association = /scmtms/if_tor_c=>sc_association-item_tr-fu_root
        iv_fill_data   = abap_true
      IMPORTING
        et_data        = lt_fu ).

    LOOP AT lt_fu INTO DATA(ls_fu) WHERE tor_cat = 'FU'.
      ls_relation-delivery_number = iv_vbeln.
      ls_relation-delivery_item_number = iv_posnr.
      ls_relation-freight_unit_number = ls_fu-tor_id.
      ls_relation-freight_unit_root_key = ls_fu-root_key.
      APPEND ls_relation TO et_relation.
      CLEAR ls_relation.

      ls_root_key-key = ls_fu-root_key.
      APPEND ls_root_key TO et_root_key.
      CLEAR ls_root_key.
    ENDLOOP.

  ENDMETHOD.


  METHOD get_stop_info.

    FIELD-SYMBOLS:
      <fs_stop> TYPE /scmtms/s_tor_stop_k.

    DATA:
      lt_root_key                TYPE /bobf/t_frw_key,
      lo_srvmgr_loc              TYPE REF TO /bobf/if_tra_service_manager,
      lo_srvmgr_tor              TYPE REF TO /bobf/if_tra_service_manager,
      lt_root                    TYPE /scmtms/t_tor_root_k,
      lt_stop                    TYPE /scmtms/t_tor_stop_k,
      lt_stop_last               TYPE /scmtms/t_tor_stop_k,
      lt_stop_key                TYPE /bobf/t_frw_key,
      lt_location_key            TYPE /bobf/t_frw_key,
      lt_adr_location_key        TYPE /bobf/t_frw_key,
      lt_address_root            TYPE /bofu/t_addr_addressi_k,
      lt_target_key              TYPE /bobf/t_frw_key,
      lv_do_root_addr_key        TYPE /bobf/obm_node_key,
      lv_do_root_postal_addr_asc TYPE /bobf/obm_assoc_key,
      lt_postal_address          TYPE /bofu/t_addr_postal_addressk,
      lt_capa_stop               TYPE /scmtms/t_tor_stop_k,
      lt_capa_root               TYPE /scmtms/t_tor_root_k,
      lt_loc_descr               TYPE /scmtms/t_bo_loc_description_k,
      lt_loc_root                TYPE /scmtms/t_bo_loc_root_k.

    CLEAR:
      et_stop_last,
      et_stop,
      et_loc_addr,
      et_root,
      et_capa_stop,
      et_capa_root,
      et_loc_root.

    lt_root_key = it_root_key.
***********************************************************************
** get instance service manager for BO /SCMTMS/TOR                    *
***********************************************************************
* instance servicemanger for BO
    lo_srvmgr_tor = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( iv_bo_key = /scmtms/if_tor_c=>sc_bo_key ).

* instance servicemanger for BO Location
    lo_srvmgr_loc = /bobf/cl_tra_serv_mgr_factory=>get_service_manager( iv_bo_key = /scmtms/if_location_c=>sc_bo_key ).

**********************************************************************
*     retrieve transportation order root node details                *
**********************************************************************
    lo_srvmgr_tor->retrieve(
      EXPORTING
        iv_node_key  = /scmtms/if_tor_c=>sc_node-root
        it_key       = lt_root_key
        iv_edit_mode = /bobf/if_conf_c=>sc_edit_read_only
        iv_fill_data = abap_true
      IMPORTING
        et_data      = lt_root ).

**********************************************************************
*     Stop Last Assocation                                           *
**********************************************************************
    lo_srvmgr_tor->retrieve_by_association(
      EXPORTING
        iv_node_key    = /scmtms/if_tor_c=>sc_node-root
        it_key         = lt_root_key
        iv_association = /scmtms/if_tor_c=>sc_association-root-stop_last
        iv_fill_data   = abap_true
      IMPORTING
        et_data        = lt_stop_last ).

**********************************************************************
*     Stop Assocation in the right sequence                          *
**********************************************************************
    lo_srvmgr_tor->retrieve_by_association(
      EXPORTING
        iv_node_key    = /scmtms/if_tor_c=>sc_node-root
        it_key         = lt_root_key
        iv_association = /scmtms/if_tor_c=>sc_association-root-stop
        iv_fill_data   = abap_true
      IMPORTING
        et_data        = lt_stop
        et_target_key  = lt_stop_key ).

**********************************************************************
*     Logistical Location Assocation & STOP Adress                   *
**********************************************************************
    LOOP AT lt_stop ASSIGNING <fs_stop>.
      /scmtms/cl_common_helper=>check_insert_key( EXPORTING iv_key = <fs_stop>-log_loc_uuid CHANGING ct_key = lt_location_key ).
      IF <fs_stop>-adr_loc_uuid IS NOT INITIAL.
        /scmtms/cl_common_helper=>check_insert_key( EXPORTING iv_key = <fs_stop>-adr_loc_uuid CHANGING ct_key = lt_adr_location_key ).
      ENDIF.
    ENDLOOP.

    " Retrieve postal address data (via DO /BOFU/ADDRESS)
    lo_srvmgr_loc->retrieve_by_association(
      EXPORTING
        iv_node_key    = /scmtms/if_location_c=>sc_node-root
        it_key         = lt_location_key
        iv_association = /scmtms/if_location_c=>sc_association-root-address
        iv_fill_data   = abap_true
      IMPORTING
        et_data        = lt_address_root
        et_target_key  = lt_target_key ).

    /scmtms/cl_common_helper=>get_do_entity_key(
      EXPORTING
        iv_host_bo_key      = /scmtms/if_location_c=>sc_bo_key
        iv_host_do_node_key = /scmtms/if_location_c=>sc_node-/bofu/address
        iv_do_entity_key    = /bofu/if_addr_constants=>sc_node-root
      RECEIVING
        rv_entity_key       = lv_do_root_addr_key ).

    /scmtms/cl_common_helper=>get_do_keys_4_rba(
      EXPORTING
        iv_host_bo_key      = /scmtms/if_location_c=>sc_bo_key
        iv_host_do_node_key = /scmtms/if_location_c=>sc_node-/bofu/address
        iv_do_node_key      = /bofu/if_addr_constants=>sc_node-postal_address
        iv_do_assoc_key     = /bofu/if_addr_constants=>sc_association-root-postal_address
      IMPORTING
        ev_assoc_key        = lv_do_root_postal_addr_asc ).

    lo_srvmgr_loc->retrieve_by_association(
      EXPORTING
        iv_node_key    = lv_do_root_addr_key
        it_key         = lt_target_key
        iv_association = lv_do_root_postal_addr_asc
        iv_fill_data   = abap_true
      IMPORTING
        et_data        = lt_postal_address ).

*   Get Location descriptions & root information
    IF lt_location_key IS NOT INITIAL.
      CALL METHOD /scmtms/cl_pln_bo_data=>get_loc_data
        EXPORTING
          it_key       = lt_location_key
        CHANGING
          ct_loc_descr = lt_loc_descr
          ct_loc_root  = lt_loc_root.
    ENDIF.

**********************************************************************
*   Assigned Capacity TOR Stop                                     *
**********************************************************************
    lo_srvmgr_tor->retrieve_by_association(
      EXPORTING
        iv_node_key    = /scmtms/if_tor_c=>sc_node-stop
        it_key         = lt_stop_key
        iv_association = /scmtms/if_tor_c=>sc_association-stop-assigned_capa_stop
        iv_fill_data   = abap_true
      IMPORTING
        et_data        = lt_capa_stop ).

**********************************************************************
*   Direct Link to the assigned TOR ROOT                           *
**********************************************************************
    lo_srvmgr_tor->retrieve_by_association(
      EXPORTING
        iv_node_key    = /scmtms/if_tor_c=>sc_node-stop
        it_key         = lt_stop_key
        iv_association = /scmtms/if_tor_c=>sc_association-stop-assigned_capa_tor_root
        iv_fill_data   = abap_true
      IMPORTING
        et_data        = lt_capa_root ).

**********************************************************************
*     Output the values                                              *
**********************************************************************
    et_stop_last = lt_stop_last.
    et_stop = lt_stop.
    et_loc_addr = lt_postal_address.
    et_root = lt_root.
    et_capa_stop = lt_capa_stop.
    et_capa_root = lt_capa_root.
    et_loc_root = lt_loc_root.

  ENDMETHOD.


  METHOD GET_STOP_POINTS.

    DATA:
      lv_order(4) TYPE n VALUE '0001'.

    CLEAR et_stop_points.

    LOOP AT it_stop USING KEY parent_seqnum ASSIGNING FIELD-SYMBOL(<ls_stop>).
      IF NOT is_odd( <ls_stop>-seq_num ).
        lv_order += 1.
      ENDIF.
      APPEND VALUE #( stop_id   = |{ iv_root_id }{ lv_order }|
                      log_locid = <ls_stop>-log_locid
                      seq_num   = <ls_stop>-seq_num ) TO et_stop_points.
    ENDLOOP.

  ENDMETHOD.


  METHOD IS_ODD.

    DATA lv_reminder TYPE n.

    lv_reminder = iv_value MOD 2.
    IF lv_reminder <> 0.
      rv_is_odd = abap_true.
    ELSE.
      rv_is_odd = abap_false.
    ENDIF.

  ENDMETHOD.


  METHOD pod.

    DATA:
      ls_loc_addr  TYPE REF TO /bofu/s_addr_postal_addressk,
      lv_assgn_end TYPE /saptrx/event_exp_datetime.

    CLEAR:et_expeventdata.

    LOOP AT it_stop_last INTO DATA(ls_stop_last)
      WHERE parent_key = iv_root_key
        AND assgn_end IS NOT INITIAL.

      CLEAR:
        ls_loc_addr,
        lv_assgn_end.
      READ TABLE it_loc_addr REFERENCE INTO ls_loc_addr WITH KEY root_key = ls_stop_last-log_loc_uuid.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

*     Read location root information(for time zone) for Stop
      READ TABLE it_loc_root INTO DATA(ls_loc_root) WITH KEY key = ls_stop_last-log_loc_uuid.

      IF ls_loc_root-time_zone_code IS NOT INITIAL.
        DATA(lv_tz) = ls_loc_root-time_zone_code.
      ELSE.
        lv_tz = sy-zonlo.
      ENDIF.
      lv_assgn_end = ls_stop_last-assgn_end.
      me->convert_utc_timestamp(
        EXPORTING
          iv_timezone  = lv_tz                    " Time Zone
          iv_timestamp = lv_assgn_end             " Time Stamp - Short Format
        RECEIVING
          rv_timestamp = DATA(lv_exp_datetime) ). " Time Stamp - Short Format

      READ TABLE it_root INTO DATA(ls_root)
        WITH KEY root_key = ls_stop_last-parent_key.
      IF sy-subrc = 0.
        DATA(lv_locid2) = ls_root-tor_id.
      ENDIF.

      APPEND VALUE #( appsys           = is_expeventdata-appsys
                      appobjtype       = is_expeventdata-appobjtype
                      language         = sy-langu
                      appobjid         = is_expeventdata-appobjid
                      milestone        = cs_milestone-fo_shp_pod
                      evt_exp_datetime = |0{ lv_exp_datetime }|
                      evt_exp_tzone    = lv_tz
                      locid1           = ls_stop_last-log_locid
                      locid2           = lv_locid2
                      loctype          = cs_location_type-logistic
                      country          = ls_loc_addr->country_code
                      city             = ls_loc_addr->city_name ) TO et_expeventdata.

    ENDLOOP.

  ENDMETHOD.


  METHOD shp_arrival.

    DATA:
      lv_plan_trans_time TYPE /saptrx/event_exp_datetime.

    CLEAR:et_expeventdata.

    LOOP AT it_stop INTO DATA(ls_stop)
      WHERE parent_key = iv_root_key
        AND stop_cat   = /scmtms/if_common_c=>c_stop_category-inbound.

      CLEAR lv_plan_trans_time.

      READ TABLE it_capa_stop ASSIGNING FIELD-SYMBOL(<ls_capa_stop>)
         WITH KEY key = ls_stop-assgn_stop_key.
      CHECK sy-subrc = 0.

      CHECK <ls_capa_stop>-plan_trans_time IS NOT INITIAL.

      READ TABLE it_loc_addr REFERENCE INTO DATA(ls_loc_addr) WITH KEY root_key = ls_stop-log_loc_uuid.
      CHECK sy-subrc = 0.

*     Read location root information(for time zone) for Stop
      READ TABLE it_loc_root INTO DATA(ls_loc_root) WITH KEY key = ls_stop-log_loc_uuid.

      IF ls_loc_root-time_zone_code IS NOT INITIAL.
        DATA(lv_tz) = ls_loc_root-time_zone_code.
      ELSE.
        lv_tz = sy-zonlo.
      ENDIF.
      lv_plan_trans_time = <ls_capa_stop>-plan_trans_time.
      me->convert_utc_timestamp(
        EXPORTING
          iv_timezone  = lv_tz                    " Time Zone
          iv_timestamp = lv_plan_trans_time       " Time Stamp - Short Format
        RECEIVING
          rv_timestamp = DATA(lv_exp_datetime) ). " Time Stamp - Short Format

      me->get_capa_matchkey(
        EXPORTING
          iv_assgn_stop_key = ls_stop-assgn_stop_key       " Key of a Stop of a Transportation Order
          it_capa_stop      = it_capa_stop                 " Stop
          it_capa_root      = it_capa_root                 " Root Node
        IMPORTING
          ev_capa_matchkey  = DATA(lv_locid2) ).

      APPEND VALUE #( appsys            = is_expeventdata-appsys
                      appobjtype        = is_expeventdata-appobjtype
                      language          = sy-langu
                      appobjid          = is_expeventdata-appobjid
                      milestone         = cs_milestone-fo_shp_arrival
                      evt_exp_datetime  = |0{ lv_exp_datetime }|
                      evt_exp_tzone     = lv_tz
                      locid1            = ls_stop-log_locid
                      locid2            = lv_locid2
                      loctype           = cs_location_type-logistic
                      country           = ls_loc_addr->country_code
                      city              = ls_loc_addr->city_name ) TO et_expeventdata.

    ENDLOOP.

  ENDMETHOD.


  METHOD shp_departure.

    DATA:
      lv_plan_trans_time TYPE /saptrx/event_exp_datetime.

    CLEAR:et_expeventdata.

    LOOP AT it_stop INTO DATA(ls_stop)
      WHERE parent_key = iv_root_key
        AND stop_cat   = /scmtms/if_common_c=>c_stop_category-outbound.

      CLEAR lv_plan_trans_time.

      READ TABLE it_capa_stop ASSIGNING FIELD-SYMBOL(<ls_capa_stop>)
         WITH KEY key = ls_stop-assgn_stop_key.
      CHECK sy-subrc = 0.

      CHECK <ls_capa_stop>-plan_trans_time IS NOT INITIAL.

      READ TABLE it_loc_addr REFERENCE INTO DATA(ls_loc_addr) WITH KEY root_key = ls_stop-log_loc_uuid.
      CHECK sy-subrc = 0.

*     Read location root information(for time zone) for Stop
      READ TABLE it_loc_root INTO DATA(ls_loc_root) WITH KEY key = ls_stop-log_loc_uuid.

      IF ls_loc_root-time_zone_code IS NOT INITIAL.
        DATA(lv_tz) = ls_loc_root-time_zone_code.
      ELSE.
        lv_tz = sy-zonlo.
      ENDIF.
      lv_plan_trans_time = <ls_capa_stop>-plan_trans_time.
      me->convert_utc_timestamp(
        EXPORTING
          iv_timezone  = lv_tz                    " Time Zone
          iv_timestamp = lv_plan_trans_time       " Time Stamp - Short Format
        RECEIVING
          rv_timestamp = DATA(lv_exp_datetime) ). " Time Stamp - Short Format

      me->get_capa_matchkey(
        EXPORTING
          iv_assgn_stop_key = ls_stop-assgn_stop_key       " Key of a Stop of a Transportation Order
          it_capa_stop      = it_capa_stop                 " Stop
          it_capa_root      = it_capa_root                 " Root Node
        IMPORTING
          ev_capa_matchkey  = DATA(lv_locid2) ).

      APPEND VALUE #( appsys           = is_expeventdata-appsys
                      appobjtype       = is_expeventdata-appobjtype
                      language         = sy-langu
                      appobjid         = is_expeventdata-appobjid
                      milestone        = cs_milestone-fo_shp_departure
                      evt_exp_datetime = |0{ lv_exp_datetime }|
                      evt_exp_tzone    = lv_tz
                      locid1           = ls_stop-log_locid
                      locid2           = lv_locid2
                      loctype          = cs_location_type-logistic
                      country          = ls_loc_addr->country_code
                      city             = ls_loc_addr->city_name ) TO et_expeventdata.

    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
