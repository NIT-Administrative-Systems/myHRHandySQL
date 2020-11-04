select count(*) from ps_nw_batch_step
where nw_os_cmd_line like 'rcapture%'

--Modify the last character of 'rcapture -dq'
-- to match the database you have refeshed
--  DEVA is a 1
--  DEVB is a 2
--  DEVC is a 3
--  DEVD is a 4
--  QA   is a Q
--  UPG  is a U

update ps_nw_batch_step
set nw_os_cmd_line = 'rcapture -dq' || substr(nw_os_cmd_line,12,99)
where nw_os_cmd_line like 'rcapture -d%'

select * from ps_nw_batch_step
where nw_os_cmd_line like 'rcapture -d%'

commit