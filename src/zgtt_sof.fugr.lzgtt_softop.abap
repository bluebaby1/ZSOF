FUNCTION-POOL zgtt_sof.                     "MESSAGE-ID ..

TYPE-POOLS:
  trxas,
  abap.

TYPES: BEGIN OF gtys_vtts_vtsp,
         tsrfo TYPE tsrfo.
         INCLUDE STRUCTURE vtspvb.
TYPES:  END OF gtys_vtts_vtsp.
TYPES:  gtyt_vtts_vtsp TYPE STANDARD TABLE OF gtys_vtts_vtsp.
TYPES: gtyt_message_log TYPE STANDARD TABLE OF bapiret2.


DATA:
  gv_evtcnt TYPE /saptrx/evtcnt.                            "#EC NEEDED


CONSTANTS:
* General
  gc_true                        TYPE boole_d               VALUE 'X',
  gc_false                       TYPE boole_d               VALUE ' ',
  gc_true_condition              TYPE char1                 VALUE 'T',
  gc_false_condition             TYPE char1                 VALUE 'F',
  gc_insert                      TYPE updkz_d               VALUE 'I',
  gc_update                      TYPE updkz_d               VALUE 'U',
  gc_delete                      TYPE updkz_d               VALUE 'D',
  gc_aot_yn_ote                  TYPE /saptrx/aotype        VALUE 'YN_OTE',
  gc_complete                    TYPE char1                 VALUE 'C',
  gc_partyp_cntl                 TYPE /saptrx/aspartyp      VALUE 'C',
  gc_partyp_evt                  TYPE /saptrx/aspartyp      VALUE ' ',
  gc_act_set                     TYPE /saptrx/action        VALUE 'S',
  gc_act_change                  TYPE /saptrx/action        VALUE 'C',
  gc_datacs_dlv                  TYPE /saptrx/data_code_set VALUE 'DLV',
  gc_datacs_bill                 TYPE /saptrx/data_code_set VALUE 'BILL',
  gc_msg_class                   TYPE symsgid               VALUE '/SAPTRX/ASC',
  gc_msg_type_e                  TYPE bapi_mtype            VALUE 'E',
  gc_msg_val_aot                 TYPE symsgv                VALUE 'AOT',
  gc_msg_val_et                  TYPE symsgv                VALUE 'ET',
  gc_msg_no_087                  TYPE symsgno               VALUE '087',
  gc_msg_no_088                  TYPE symsgno               VALUE '088',
* Business Process Type
  gc_bpt_sales_order_header_new  TYPE /saptrx/strucdataname VALUE 'SALES_ORDER_HEADER_NEW',
  gc_bpt_sales_order_header_old  TYPE /saptrx/strucdataname VALUE 'SALES_ORDER_HEADER_OLD',
  gc_bpt_sales_order_items_new   TYPE /saptrx/strucdataname VALUE 'SALES_ORDER_ITEMS_NEW',
  gc_bpt_sales_order_items_old   TYPE /saptrx/strucdataname VALUE 'SALES_ORDER_ITEMS_OLD',
  gc_bpt_schedule_line_item_new  TYPE /saptrx/strucdataname VALUE 'SCHEDULE_LINE_ITEMS_NEW',
  gc_bpt_schedule_line_item_old  TYPE /saptrx/strucdataname VALUE 'SCHEDULE_LINE_ITEMS_OLD',
  gc_bpt_business_data_new       TYPE /saptrx/strucdataname VALUE 'BUSINESS_DATA_NEW',
  gc_bpt_business_data_old       TYPE /saptrx/strucdataname VALUE 'BUSINESS_DATA_OLD',
  gc_bpt_partners_new            TYPE /saptrx/strucdataname VALUE 'PARTNERS_NEW',
  gc_bpt_partners_old            TYPE /saptrx/strucdataname VALUE 'PARTNERS_OLD',
  gc_bpt_header_status_new       TYPE /saptrx/strucdataname VALUE 'HEADER_STATUS_NEW',
  gc_bpt_header_status_old       TYPE /saptrx/strucdataname VALUE 'HEADER_STATUS_OLD',
  gc_bpt_item_status_new         TYPE /saptrx/strucdataname VALUE 'ITEM_STATUS_NEW',
  gc_bpt_item_status_old         TYPE /saptrx/strucdataname VALUE 'ITEM_STATUS_OLD',
  gc_bpt_document_flow_new       TYPE /saptrx/strucdataname VALUE 'DOCUMENT_FLOW_NEW',
  gc_bpt_document_flow_old       TYPE /saptrx/strucdataname VALUE 'DOCUMENT_FLOW_OLD',
  gc_bpt_delivery_item_new       TYPE /saptrx/strucdataname VALUE 'DELIVERY_ITEM_NEW',
  gc_bpt_delivery_item_old       TYPE /saptrx/strucdataname VALUE 'DELIVERY_ITEM_OLD',
  gc_bpt_delivery_item_stat_new  TYPE /saptrx/strucdataname VALUE 'DELIVERY_ITEM_STATUS_NEW',
  gc_bpt_delivery_item_stat_old  TYPE /saptrx/strucdataname VALUE 'DELIVERY_ITEM_STATUS_OLD',
  gc_bpt_invoice_item_new        TYPE /saptrx/strucdataname VALUE 'INVOICE_ITEM_NEW',
  gc_bpt_invoice_header_new      TYPE /saptrx/strucdataname VALUE 'INVOICE_HEADER_NEW',
  gc_bpt_invoice_header_old      TYPE /saptrx/strucdataname VALUE 'INVOICE_HEADER_OLD',
  gc_bpt_cleared_item            TYPE /saptrx/strucdataname VALUE 'CLEARED_ITEM',
  gc_bpt_purchase_item_new       TYPE /saptrx/strucdataname VALUE 'PURCHASE_ITEM_NEW',
  gc_bpt_purchase_header_new     TYPE /saptrx/strucdataname VALUE 'PURCHASE_ORDER_HEADER_NEW',
  gc_bpt_purchase_header_old     TYPE /saptrx/strucdataname VALUE 'PURCHASE_ORDER_HEADER_OLD',
  gc_bpt_po_account_assign_new   TYPE /saptrx/strucdataname VALUE 'PO_ACCOUNT_ASSIGNMENT_NEW',
  gc_bpt_po_sched_line_item_new  TYPE /saptrx/strucdataname VALUE 'PO_SCHED_LINE_ITEM_NEW',
  gc_bpt_po_sched_line_item_old  TYPE /saptrx/strucdataname VALUE 'PO_SCHED_LINE_ITEM_OLD',
  gc_bpt_shipment_header_new     TYPE /saptrx/strucdataname VALUE 'SHIPMENT_HEADER_NEW',
  gc_bpt_shipment_header_old     TYPE /saptrx/strucdataname VALUE 'SHIPMENT_HEADER_OLD',
  gc_bpt_shipment_item_new       TYPE /saptrx/strucdataname VALUE 'SHIPMENT_ITEM_NEW',
  gc_bpt_shipment_item_old       TYPE /saptrx/strucdataname VALUE 'SHIPMENT_ITEM_OLD',
  gc_bpt_delivery_item           TYPE /saptrx/strucdataname VALUE 'DELIVERY_ITEM',
  gc_bpt_shipment_leg_new        TYPE /saptrx/strucdataname VALUE 'SHIPMENT_LEG_NEW',
  gc_bpt_shipment_leg_old        TYPE /saptrx/strucdataname VALUE 'SHIPMENT_LEG_OLD',
  gc_bpt_shipment_item_leg_new   TYPE /saptrx/strucdataname VALUE 'SHIPMENT_ITEM_LEG_NEW',
  gc_bpt_shipment_item_leg_old   TYPE /saptrx/strucdataname VALUE 'SHIPMENT_ITEM_LEG_OLD',
  gc_bpt_material_segment        TYPE /saptrx/strucdataname VALUE 'MATERIAL_SEGMENT',
  gc_bpt_material_header         TYPE /saptrx/strucdataname VALUE 'MATERIAL_HEADER',
  gc_bpt_wo_header_new           TYPE /saptrx/strucdataname VALUE 'WO_HEADER_NEW',
  gc_bpt_wo_header_old           TYPE /saptrx/strucdataname VALUE 'WO_HEADER_OLD',
  gc_bpt_wo_status_new           TYPE /saptrx/strucdataname VALUE 'WO_STATUS_NEW',
  gc_bpt_wo_status_old           TYPE /saptrx/strucdataname VALUE 'WO_STATUS_OLD',
  gc_bpt_clearing_doc_header     TYPE /saptrx/strucdataname VALUE 'CLEARING_DOC_HEADER',
* Event ID
  gc_evtid_yn_so_bill_blk        TYPE /saptrx/ev_evtid      VALUE 'YN_SO_BILL_BLK',
  gc_evtid_yn_so_dlv_blk         TYPE /saptrx/ev_evtid      VALUE 'YN_SO_DLV_BLK',
  gc_evtid_yn_so_reject          TYPE /saptrx/ev_evtid      VALUE 'YN_SO_REJECT',
  gc_evtid_yn_dlv_gi             TYPE /saptrx/ev_evtid      VALUE 'YN_DLV_GI',
  gc_evtid_yn_shpmt_plan         TYPE /saptrx/ev_evtid      VALUE 'YN_SHPMT_PLAN',
  gc_evtid_yn_shpmt_start        TYPE /saptrx/ev_evtid      VALUE 'YN_SHPMT_START',
  gc_evtid_yn_shpmt_end          TYPE /saptrx/ev_evtid      VALUE 'YN_SHPMT_END',
  gc_evtid_yn_fi_payment         TYPE /saptrx/ev_evtid      VALUE 'YN_FI_PAYMENT',
* Additional constants D2O
  gc_trxcod_yn_so_header         TYPE /saptrx/trxcod        VALUE 'YN_SO_HEADER',
  gc_evtid_yn_so_ready           TYPE /saptrx/ev_evtid      VALUE 'YN_SO_READY',
  gc_evtid_yn_so_create          TYPE /saptrx/ev_evtid      VALUE 'YN_SO_CREATE',
  gc_evtid_yn_so_bill_unblk      TYPE /saptrx/ev_evtid      VALUE 'YN_SO_BILL_UNBLK',
  gc_evtid_yn_so_dlv_unblk       TYPE /saptrx/ev_evtid      VALUE 'YN_SO_DLV_UNBLK',
  gc_evtid_yn_dlv_create         TYPE /saptrx/ev_evtid      VALUE 'YN_SO_DLV_CREATE',
  gc_bpt_delivery_header_new     TYPE /saptrx/strucdataname VALUE 'DELIVERY_HEADER_NEW',
  gc_bpt_delivery_header_old     TYPE /saptrx/strucdataname VALUE 'DELIVERY_HEADER_OLD',
  gc_bpt_delivery_hdrstatus_new  TYPE /saptrx/strucdataname VALUE 'DELIVERY_HDR_STATUS_NEW',
  gc_bpt_delivery_hdrstatus_old  TYPE /saptrx/strucdataname VALUE 'DELIVERY_HDR_STATUS_OLD',
  gc_aot_zn_ote                  TYPE /saptrx/aotype        VALUE 'ZN_OTE',
  gc_partial_dlv                 TYPE char1                 VALUE 'B',

* Tracking Code set
  gc_trxcod_yn_so_item           TYPE /saptrx/trxcod        VALUE 'YN_SO_ITEM',
  gc_trxcod_yn_dlv_no            TYPE /saptrx/trxcod        VALUE 'YN_DLV_NO',
  gc_trxcod_yn_bill_no           TYPE /saptrx/trxcod       VALUE 'YN_BILL_NO',
  gc_trxcod_yn_shpmt_no          TYPE /saptrx/trxcod        VALUE 'YN_SHPMT_NO',
* Control Parameter Name
  gc_cp_yn_so_bl_blk_ind         TYPE /saptrx/paramname     VALUE 'YN_SO_BL_BLK_IND',
  gc_cp_yn_so_dl_blk_ind         TYPE /saptrx/paramname     VALUE 'YN_SO_DL_BLK_IND',
  gc_cp_yn_so_dl_blk_full        TYPE /saptrx/paramname     VALUE 'YN_SO_FULL_DL_BLK_IND',
  gc_cp_yn_so_dl_compl           TYPE /saptrx/paramname     VALUE 'YN_SO_DL_COMPL',
  gc_cp_yn_so_incoterm1          TYPE /saptrx/paramname     VALUE 'YN_SO_INCOTERM1',
  gc_cp_yn_so_incotermloc1       TYPE /saptrx/paramname     VALUE 'YN_SO_INCOTERM_LOCATION',
  gc_cp_yn_so_incotermversion    TYPE /saptrx/paramname     VALUE 'YN_SO_INCOTERM_VERSION',
  gc_cp_yn_so_incoterm2          TYPE /saptrx/paramname     VALUE 'YN_SO_INCOTERM2',
  gc_cp_yn_so_po_no              TYPE /saptrx/paramname     VALUE 'YN_SO_PO_NO',
  gc_cp_yn_so_po_date            TYPE /saptrx/paramname     VALUE 'YN_SO_PO_DATE',
  gc_cp_yn_so_bill_date          TYPE /saptrx/paramname     VALUE 'YN_SO_BILL_DATE',
  gc_cp_yn_so_cust_grp           TYPE /saptrx/paramname     VALUE 'YN_SO_CUST_GRP',
  gc_cp_yn_so_ship_to            TYPE /saptrx/paramname     VALUE 'YN_SO_SHIPTO',
  gc_cp_yn_so_ship_to_txt        TYPE /saptrx/paramname     VALUE 'YN_SO_SHIPTO_TXT',
  gc_cp_yn_so_sold_to            TYPE /saptrx/paramname     VALUE 'YN_SO_SOLDTO',
  gc_cp_yn_so_sold_to_txt        TYPE /saptrx/paramname     VALUE 'YN_SO_SOLDTO_TXT',
  gc_cp_yn_so_sold_to_mail       TYPE /saptrx/paramname     VALUE 'YN_SO_SOLDTO_MAIL',
  gc_cp_yn_so_bill_to            TYPE /saptrx/paramname     VALUE 'YN_SO_BILLTO',
  gc_cp_yn_so_bill_to_txt        TYPE /saptrx/paramname     VALUE 'YN_SO_BILLTO_TXT',
  gc_cp_yn_so_payer              TYPE /saptrx/paramname     VALUE 'YN_SO_PAYER',
  gc_cp_yn_so_payer_txt          TYPE /saptrx/paramname     VALUE 'YN_SO_PAYER_TXT',
  gc_cp_yn_so_fwd                TYPE /saptrx/paramname     VALUE 'YN_SO_FWD',
  gc_cp_yn_so_fwd_txt            TYPE /saptrx/paramname     VALUE 'YN_SO_FWD_TXT',
  gc_cp_yn_so_full_dlv           TYPE /saptrx/paramname     VALUE 'YN_SO_FULL_DLV_IND',
  gc_cp_yn_so_subseq_doc_ind     TYPE /saptrx/paramname     VALUE 'YN_SO_SUBSEQ_DOC_IND',
  gc_cp_yn_shpmt_no              TYPE /saptrx/paramname     VALUE 'YN_SHPMT_NO',
  gc_cp_yn_shpmt_cont_id         TYPE /saptrx/paramname     VALUE 'YN_SHPMT_CONT_ID',
  gc_cp_yn_account_no            TYPE /saptrx/paramname     VALUE 'YN_ACCOUNT_NO',
  gc_cp_yn_so_no                 TYPE /saptrx/paramname     VALUE 'YN_SO_NO',
  gc_cp_yn_so_item_no            TYPE /saptrx/paramname     VALUE 'YN_SO_ITEM_NO',
  gc_cp_yn_material_no           TYPE /saptrx/paramname     VALUE 'YN_MATERIAL_NO',
  gc_cp_yn_material_txt          TYPE /saptrx/paramname     VALUE 'YN_MATERIAL_TXT',
  gc_cp_yn_plant                 TYPE /saptrx/paramname     VALUE 'YN_PLANT',
  gc_cp_yn_quantity              TYPE /saptrx/paramname     VALUE 'YN_QUANTITY',
  gc_cp_yn_pick_quantity         TYPE /saptrx/paramname     VALUE 'YN_PICK_QUANTITY',
  gc_cp_yn_pack_quantity         TYPE /saptrx/paramname     VALUE 'YN_PACK_QUANTITY',
  gc_cp_yn_pod_quantity          TYPE /saptrx/paramname     VALUE 'YN_POD_QUANTITY',
  gc_cp_yn_qty_unit              TYPE /saptrx/paramname     VALUE 'YN_QTY_UNIT',
  gc_cp_yn_ean_upc               TYPE /saptrx/paramname     VALUE 'YN_EAN_UPC',
  gc_cp_yn_net_value             TYPE /saptrx/paramname     VALUE 'YN_NET_VALUE',
  gc_cp_yn_reject_status         TYPE /saptrx/paramname     VALUE 'YN_REJECTION_STATUS',
  gc_cp_yn_net_value_curr        TYPE /saptrx/paramname     VALUE 'YN_NET_VALUE_CURRENCY',
  gc_cp_yn_doc_date              TYPE /saptrx/paramname     VALUE 'YN_DOCUMENT_DATE',
  gc_cp_yn_act_datetime          TYPE /saptrx/paramname     VALUE 'ACTUAL_BUSINESS_DATETIME',
  gc_cp_yn_act_timezone          TYPE /saptrx/paramname     VALUE 'ACTUAL_BUSINESS_TIMEZONE',
  gc_cp_yn_acttec_datetime       TYPE /saptrx/paramname     VALUE 'ACTUAL_TECHNICAL_DATETIME',
  gc_cp_yn_acttec_timezone       TYPE /saptrx/paramname     VALUE 'ACTUAL_TECHNICAL_TIMEZONE',
  gc_cp_yn_de_no                 TYPE /saptrx/paramname     VALUE 'YN_DLV_NO',
  gc_cp_yn_de_item_no            TYPE /saptrx/paramname     VALUE 'YN_DLV_ITEM_NO',
  gc_cp_yn_de_ship_to            TYPE /saptrx/paramname     VALUE 'YN_DLV_SHIPTO',
  gc_cp_yn_de_plndelivery_date   TYPE /saptrx/paramname     VALUE 'YN_DLV_PLAN_DELIVERY_DATE',
  gc_cp_yn_de_tot_weight         TYPE /saptrx/paramname     VALUE 'YN_DLV_TOTAL_WEIGHT',
  gc_cp_yn_de_gross_weight       TYPE /saptrx/paramname     VALUE 'YN_DLV_GROSS_WEIGHT',
  gc_cp_yn_de_net_weight         TYPE /saptrx/paramname     VALUE 'YN_DLV_NET_WEIGHT',
  gc_cp_yn_de_tot_weight_uom     TYPE /saptrx/paramname     VALUE 'YN_DLV_TOTAL_WEIGHT_UOM',
  gc_cp_yn_de_gross_weight_uom   TYPE /saptrx/paramname     VALUE 'YN_DLV_GROSS_WEIGHT_UOM',
  gc_cp_yn_de_vol                TYPE /saptrx/paramname     VALUE 'YN_DLV_VOLUME',
  gc_cp_yn_de_vol_uom            TYPE /saptrx/paramname     VALUE 'YN_DLV_VOLUME_UOM',
  gc_cp_yn_dgoods                TYPE /saptrx/paramname     VALUE 'YN_DLV_DANGEROUS_GOODS',
  gc_cp_yn_de_pick_status        TYPE /saptrx/paramname     VALUE 'YN_DLV_PICK_STATUS',
  gc_cp_yn_de_pack_status        TYPE /saptrx/paramname     VALUE 'YN_DLV_PACK_STATUS',
  gc_cp_yn_de_trans_status       TYPE /saptrx/paramname     VALUE 'YN_DLV_TRANSPORTATION_STATUS',
  gc_cp_yn_de_gi_status          TYPE /saptrx/paramname     VALUE 'YN_DLV_GOODS_ISSUE_STATUS',
  gc_cp_yn_de_pod_status         TYPE /saptrx/paramname     VALUE 'YN_DLV_POD_STATUS',
  gc_cp_yn_de_asso_soitem_no     TYPE /saptrx/paramname     VALUE 'YN_DLV_ASSO_SOITEM_NO',
  gc_cp_yn_de_warehouse_no       TYPE /saptrx/paramname     VALUE 'YN_DLV_WAREHOUSE_NO',
  gc_cp_yn_de_door_no            TYPE /saptrx/paramname     VALUE 'YN_DLV_DOOR_NO',
  gc_cp_yn_de_door_txt           TYPE /saptrx/paramname     VALUE 'YN_DLV_DOOR_TEXT',
  gc_cp_yn_de_shp_pnt            TYPE /saptrx/paramname     VALUE 'YN_DLV_SHIPPING_POINT',
  gc_cp_yn_de_shp_pnt_loctype    TYPE /saptrx/paramname     VALUE 'YN_DLV_DEPARTURE_LOCATION_TYPE',
  gc_cp_yn_de_shp_addr           TYPE /saptrx/paramname     VALUE 'YN_DLV_DEPARTURE_ADDRESS',
  gc_cp_yn_de_shp_countryiso     TYPE /saptrx/paramname     VALUE 'YN_DLV_DEPARTURE_COUNTRY',
  gc_cp_yn_de_dest               TYPE /saptrx/paramname     VALUE 'YN_DLV_DESTINATION',
  gc_cp_yn_de_dest_loctype       TYPE /saptrx/paramname     VALUE 'YN_DLV_DESTINATION_LOCATION_TYPE',
  gc_cp_yn_de_dest_addr          TYPE /saptrx/paramname     VALUE 'YN_DLV_DESTINATION_ADDRESS',
  gc_cp_yn_de_dest_countryiso    TYPE /saptrx/paramname     VALUE 'YN_DLV_DESTINATION_COUNTRY',
  gc_cp_yn_de_dest_email         TYPE /saptrx/paramname     VALUE 'YN_DLV_DESTINATION_EMAIL',
  gc_cp_yn_de_dest_tele          TYPE /saptrx/paramname     VALUE 'YN_DLV_DESTINATION_TELEPHONE',
  gc_cp_yn_de_bol_no             TYPE /saptrx/paramname     VALUE 'YN_DLV_BILL_OF_LADING',
  gc_cp_yn_de_inco1              TYPE /saptrx/paramname     VALUE 'YN_DLV_INCOTERMS',
  gc_cp_yn_de_inco2_l            TYPE /saptrx/paramname     VALUE 'YN_DLV_INCO_LOCATION',
  gc_cp_yn_de_incov              TYPE /saptrx/paramname     VALUE 'YN_DLV_INCO_VERSION',
  gc_cp_yn_dlv_line_cnt          TYPE /saptrx/paramname     VALUE 'YN_DLV_LINE_CNT',
  gc_cp_yn_dlv_fu_number         TYPE /saptrx/paramname     VALUE 'YN_DLV_FU_NUMBER',
  gc_cp_yn_shp_no                TYPE /saptrx/paramname     VALUE 'YN_SHP_NO',
  gc_cp_yn_shp_shipment_type     TYPE /saptrx/paramname     VALUE 'YN_SHP_SHIPMENT_TYPE',
  gc_cp_yn_shp_sa_erp_id         TYPE /saptrx/paramname     VALUE 'YN_SHP_SA_ERP_ID',
  gc_cp_yn_shp_sa_lbn_id         TYPE /saptrx/paramname     VALUE 'YN_SHP_SA_LBN_ID',
  gc_cp_yn_shp_contain_dg        TYPE /saptrx/paramname     VALUE 'YN_SHP_CONTAIN_DGOODS',
  gc_cp_yn_shp_inco1             TYPE /saptrx/paramname     VALUE 'YN_SHP_INCOTERMS',
  gc_cp_yn_shp_fa_track_id       TYPE /saptrx/paramname     VALUE 'YN_SHP_FA_TRACKING_ID',
  gc_cp_yn_shp_shipping_type     TYPE /saptrx/paramname     VALUE 'YN_SHP_SHIPPING_TYPE',
  gc_cp_yn_shp_trans_mode        TYPE /saptrx/paramname     VALUE 'YN_SHP_TRANSPORTATION_MODE',
  gc_cp_yn_shp_container_id      TYPE /saptrx/paramname     VALUE 'YN_SHP_CONTAINER_ID',
  gc_cp_yn_shp_truck_id          TYPE /saptrx/paramname     VALUE 'YN_SHP_TRUCK_ID',
  gc_cp_yn_shp_res_value         TYPE /saptrx/paramname     VALUE 'YN_SHP_TRACKED_RESOURCE_VALUE',
  gc_cp_yn_shp_res_id            TYPE /saptrx/paramname     VALUE 'YN_SHP_TRACKED_RESOURCE_ID',
  gc_cp_yn_shp_res_tp_id         TYPE /saptrx/paramname     VALUE 'YN_SHP_RESOURCE_TP_ID',
  gc_cp_yn_shp_res_tp_cnt        TYPE /saptrx/paramname     VALUE 'YN_SHP_RESOURCE_TP_LINE_COUNT',


  gc_cp_yn_shp_stops_line_cnt    TYPE /saptrx/paramname     VALUE 'YN_SHP_LINE_COUNT',
  gc_cp_yn_shp_stops_stop_id     TYPE /saptrx/paramname     VALUE 'YN_SHP_STOP_ID',
  gc_cp_yn_shp_stops_ordinal_no  TYPE /saptrx/paramname     VALUE 'YN_SHP_ORDINAL_NO',
  gc_cp_yn_shp_stops_loc_cat     TYPE /saptrx/paramname     VALUE 'YN_SHP_LOC_CATEGORY',
  gc_cp_yn_shp_stops_loc_id      TYPE /saptrx/paramname     VALUE 'YN_SHP_LOC_ID',
  gc_cp_yn_shp_stops_loc_type    TYPE /saptrx/paramname     VALUE 'YN_SHP_LOC_TYPE',
  gc_cp_yn_shp_stops_load_pnt    TYPE /saptrx/paramname     VALUE 'YN_SHP_LOADING_POINT',
  gc_cp_yn_shp_stops_unload_pnt  TYPE /saptrx/paramname     VALUE 'YN_SHP_UNLOADING_POINT',
  gc_cp_yn_shp_stops_lgort       TYPE /saptrx/paramname     VALUE 'YN_SHP_STORAGE_LOCATION',
  gc_cp_yn_shp_warehouse_no      TYPE /saptrx/paramname     VALUE 'YN_SHP_WAREHOUSE_NO',
  gc_cp_yn_shp_gate_no           TYPE /saptrx/paramname     VALUE 'YN_SHP_GATE_NO',
  gc_cp_yn_shp_gate_txt          TYPE /saptrx/paramname     VALUE 'YN_SHP_GATE_TEXT',
  gc_cp_yn_shp_stage_seq         TYPE /saptrx/paramname     VALUE 'YN_SHP_STAGE_SEQUENCE',
  gc_cp_yn_shp_stops_pln_evt_dt  TYPE /saptrx/paramname     VALUE 'YN_SHP_STOP_PLAN_DATETIME',
  gc_cp_yn_shp_stops_pln_evt_tz  TYPE /saptrx/paramname     VALUE 'YN_SHP_STOP_PLAN_TIMEZONE',
  gc_cp_yn_shp_stop_id           TYPE /saptrx/paramname     VALUE 'YN_SHP_VP_STOP_ID',
  gc_cp_yn_shp_stop_id_ord_no    TYPE /saptrx/paramname     VALUE 'YN_SHP_VP_STOP_ORD_NO',
  gc_cp_yn_shp_stop_id_loc_id    TYPE /saptrx/paramname     VALUE 'YN_SHP_VP_STOP_LOC_ID',
  gc_cp_yn_shp_stop_id_loc_type  TYPE /saptrx/paramname     VALUE 'YN_SHP_VP_STOP_LOC_TYPE',
  gc_cp_yn_shp_departure_dt      TYPE /saptrx/paramname     VALUE 'YN_SHP_PLN_DEP_BUS_DATETIME',
  gc_cp_yn_shp_departure_tz      TYPE /saptrx/paramname     VALUE 'YN_SHP_PLN_DEP_BUS_TIMEZONE',
  gc_cp_yn_shp_departure_locid   TYPE /saptrx/paramname     VALUE 'YN_SHP_PLN_DEP_LOC_ID',
  gc_cp_yn_shp_departure_loctype TYPE /saptrx/paramname     VALUE 'YN_SHP_PLN_DEP_LOC_TYPE',
  gc_cp_yn_shp_arrival_dt        TYPE /saptrx/paramname     VALUE 'YN_SHP_PLN_AR_BUS_DATETIME',
  gc_cp_yn_shp_arrival_tz        TYPE /saptrx/paramname     VALUE 'YN_SHP_PLN_AR_BUS_TIMEZONE',
  gc_cp_yn_shp_arrival_locid     TYPE /saptrx/paramname     VALUE 'YN_SHP_PLN_AR_LOC_ID',
  gc_cp_yn_shp_arrival_loctype   TYPE /saptrx/paramname     VALUE 'YN_SHP_PLN_AR_LOC_TYPE',

  gc_cp_yn_so_header_item_no     TYPE /saptrx/paramname     VALUE 'YN_SO_HDR_ITM_NO',
  gc_cp_yn_so_header_item_cnt    TYPE /saptrx/paramname     VALUE 'YN_SO_HDR_ITM_LINE_COUNT',
  gc_cp_yn_so_schedule_item_cnt  TYPE /saptrx/paramname     VALUE 'YN_SO_SCH_ITM_LINE_COUNT',
  gc_cp_yn_so_schedule_dlv_date  TYPE /saptrx/paramname     VALUE 'YN_SO_SCH_ITM_DLV_DATE',
  gc_cp_yn_so_schedule_conf_qty  TYPE /saptrx/paramname     VALUE 'YN_SO_SCH_ITM_CONF_QTY',
  gc_cp_yn_so_schedule_ordr_uom  TYPE /saptrx/paramname     VALUE 'YN_SO_SCH_ITM_ORDER_UOM',

  gc_cp_yn_de_header_item_no     TYPE /saptrx/paramname     VALUE 'YN_DLV_HDR_ITM_NO',
  gc_cp_yn_de_header_item_cnt    TYPE /saptrx/paramname     VALUE 'YN_DLV_HDR_ITM_LINE_COUNT',
  gc_cp_yn_shp_dlv_no            TYPE /saptrx/paramname     VALUE 'YN_SHP_HDR_DLV_NO',
  gc_cp_yn_shp_dlv_cnt           TYPE /saptrx/paramname     VALUE 'YN_SHP_HDR_DLV_LINE_COUNT',
  gc_cp_yn_shp_carrier_ref_type  TYPE /saptrx/paramname     VALUE 'YN_SHP_CARRIER_REF_TYPE',
  gc_cp_yn_shp_carrier_ref_value TYPE /saptrx/paramname     VALUE 'YN_SHP_CARRIER_REF_VALUE',

* Event Message Parameters
  gc_ev_yn_document              TYPE /saptrx/paramname     VALUE 'YN_DOCUMENT',

* Sales Order
  gc_parvw_ag                    TYPE parvw                 VALUE 'AG', " Sold-to Party
  gc_parvw_we                    TYPE parvw                 VALUE 'WE', " Ship-to Party
  gc_parvw_re                    TYPE parvw                 VALUE 'RE', " Bill-to Party
  gc_parvw_rg                    TYPE parvw                 VALUE 'RG', " Payer
  gc_parvw_sp                    TYPE parvw                 VALUE 'SP', " Forwarding Agent
  gc_cmgst_a                     TYPE cmgst                 VALUE 'A',
  gc_cmgst_b                     TYPE cmgst                 VALUE 'B',
  gc_cmgst_c                     TYPE cmgst                 VALUE 'C',
  gc_cmgst_d                     TYPE cmgst                 VALUE 'D',
* Shipment
  gc_leg_ind_1                   TYPE laufk                 VALUE '1',  " Preliminary Leg
  gc_leg_ind_2                   TYPE laufk                 VALUE '2',  " Main leg
  gc_leg_ind_3                   TYPE laufk                 VALUE '3',  " Subsequent leg
  gc_leg_ind_4                   TYPE laufk                 VALUE '4',  " Direct Leg
  gc_tstyp_3                     TYPE tstyp                 VALUE '3',  " Stage Category: Border
* Production Order
  gc_aufty_pp                    TYPE auftyp                VALUE '10',
  gc_stat_rel                    TYPE j_status              VALUE 'I0002',
* Purchase Order
  gc_vgart_we                    TYPE vgart                 VALUE 'WE',
  gc_del_loekz                   TYPE eloek                 VALUE 'L',
  gc_shkzg_s                     TYPE shkzg                 VALUE 'S',
* Billing
  gc_rfbsk_c                     TYPE rfbsk                 VALUE 'C',
  gc_vbtyp_cancel                TYPE vbtyp                 VALUE 'N',
* Payment
  gc_koart_d                     TYPE koart                 VALUE 'D',
  gc_awtyp_vbrk                  TYPE awtyp                 VALUE 'VBRK'.
