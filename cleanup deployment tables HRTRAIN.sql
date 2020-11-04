delete from ps_appr_inst_log where busprocname like 'NW%';
--delete from ps_appr_inst_tbl;
delete from psworklist where busprocname like 'NW%';
delete from pswlinstmax where ACTIVITYNAME like 'NW%';
delete from ps_nw_pos_data_wl;


update ps_nw_posn_dist set appr_status = ' ' where appr_status <> ' ';
update ps_nw_posn_dist set appr_instance = 0 where appr_instance > 0;
update ps_nw_posn_dist set nw_changed_by = ' ' where nw_changed_by <> ' ';
update ps_nw_posn_dist set appr_action = ' ' where appr_action <> ' ';
update ps_nw_posn_dist set nw_area_approved = ' ' where nw_area_approved <> ' ';
update ps_nw_posn_dist set nw_area = ' ' where nw_area <> ' ';
update ps_nw_posn_dist set originatorid = ' ' where originatorid <> ' ';
update ps_nw_posn_dist set ROLEUSER = ' ' where ROLEUSER <> ' ';
update ps_nw_posn_dist set NW_ORIG_EMAILID = ' ' where NW_ORIG_EMAILID <> ' ';
delete from ps_nw_posn_dist_wl;


delete from ps_nw_jrnl_wl;
delete from ps_nw_journal_tbl;
delete from ps_nw_jrnl_dt_tbl;
commit; 


