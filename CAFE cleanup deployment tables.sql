delete from ps_appr_inst_log where busprocname = 'NW_ALTER_FUNDING' or busprocname = 'NW_PAYROLL_REVIEW';
delete from ps_appr_inst_tbl;
delete from psworklist where busprocname = 'NW_ALTER_FUNDING' or busprocname = 'NW_PAYROLL_REVIEW';
delete from pswlinstmax where busprocname = 'NW_ALTER_FUNDING' or busprocname = 'NW_PAYROLL_REVIEW';
delete from ps_nw_pos_data_wl;
delete from ps_nw_posn_dist_wl;
delete from ps_nw_jrnl_wl;

update ps_nw_posn_dist set appr_status = ' ' where appr_status <> ' ';
update ps_nw_posn_dist set appr_instance = 0 where appr_instance > 0;
update ps_nw_posn_dist set appr_action = ' ' where appr_action <> ' ';
update ps_nw_posn_dist set originatorid = ' ' where originatorid <> ' ';
update ps_nw_posn_dist set ROLEUSER = ' ' where ROLEUSER <> ' ';
update ps_nw_posn_dist set NW_ORIG_EMAILID = ' ' where NW_ORIG_EMAILID <> ' ';
update ps_nw_posn_dist set NW_FN_APPR_DPT1 = ' ' where NW_FN_APPR_DPT1 <> ' ';
update ps_nw_posn_dist set NW_FN_APPR_DPT2 = ' ' where NW_FN_APPR_DPT2 <> ' ';
update ps_nw_posn_dist set NW_FN_APPR_DPT3 = ' ' where NW_FN_APPR_DPT3 <> ' ';
update ps_nw_posn_dist set NW_FIN_APPR_DONE = ' ' where NW_FIN_APPR_DONE <> ' ';
update ps_nw_posn_dist set NW_SCH_APPR_DONE = ' ' where NW_SCH_APPR_DONE <> ' ';
update ps_nw_posn_dist set NW_FN_FUNDING_MGR = ' ' where NW_FN_FUNDING_MGR  <> ' ';
delete from ps_AUDIT_POSN_DIST;

delete from ps_nw_journal_tbl;
delete from ps_nw_jrnl_dt_tbl;
delete from ps_audit_nw_jrnl;
commit; 


