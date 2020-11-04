select * from ps_nw_posn_dist
	where position_nbr = '99999999'
	
update ps_nw_posn_dist
	set appr_status = 'A'
	where position_nbr = '99999999'  
	and appr_status = 'P'
	
select * from ps_nw_jrnl_dt_tbl
	where emplid = '9999999'  
	
update ps_nw_jrnl_dt_tbl
	set appr_status = 'A'
	where emplid = '9999999'  

