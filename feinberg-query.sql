select * from ps_nw_fn_dept_tbl b
where nw_admin_unit = '5011000'
  and effdt = (select max(effdt) from ps_nw_fn_dept_tbl b1
                where b1.setid = b.setid
                  and b1.deptid = b.deptid
                  and b1.effdt <= sysdate)
                  
select * from ps_dept_tbl a
where nw_admin_unit = '5011000'
  and effdt = (select max(effdt) from ps_dept_tbl a1
                where a1.setid = a.setid
                  and a1.deptid = a.deptid
                  and a1.effdt <= sysdate)
                  
select h.* 
from ps_nw_gl_data_hist h
   , ps_dept_tbl a
where h.Check_dt > '31-Aug-2010'
  and h.nw_entry_type in ('ERN','JNL','BEN','JBN')
  and h.deptid = a.deptid
  and a.setid = 'NWUNV'
  and a.nw_admin_unit = '5011000'
  and a.effdt = (select max(effdt) from ps_dept_tbl a1
                where a1.setid = a.setid
                  and a1.deptid = a.deptid
                  and a1.effdt <= sysdate)    
union
select h.* 
from ps_nw_gl_data_hist h
   , ps_dept_tbl a
   , (select max(h1.check_dt) Check_dt from ps_nw_gl_data_hist h1
                     where h1.Check_dt <= sysdate) c
where h.Check_dt = c.check_dt
  and h.nw_entry_type in ('ENC','ECB')
  and h.deptid = a.deptid
  and a.setid = 'NWUNV'
  and a.nw_admin_unit = '5011000'
  and a.effdt = (select max(effdt) from ps_dept_tbl a1
                where a1.setid = a.setid
                  and a1.deptid = a.deptid
                  and a1.effdt <= sysdate)   
order by 3,4                  
                  
select distinct nw_entry_type from ps_nw_gl_data                    
                            

select h.* 
from ps_nw_gl_data_hist h
   , ps_dept_tbl a
where h.fiscal_year = 2010 -- Check_dt between '01-Sep-2009' and '31-Aug-2010'
  and h.nw_entry_type in ('ERN','JRL','BEN','JBN')
  and h.deptid = a.deptid
  and a.setid = 'NWUNV'
  and a.nw_admin_unit = '5011000'
  and a.effdt = (select max(effdt) from ps_dept_tbl a1
                where a1.setid = a.setid
                  and a1.deptid = a.deptid
                  and a1.effdt <= sysdate)
  and h.emplid in ('1000176'    
,'1000184'    
,'1000200'    
,'1000201'    
,'1000332'    
,'1000436'    
,'1000444'    
,'1000475'    
,'1000531'    
,'1000577'    
,'1000610'    
,'1000654'    
,'1000725'    
,'1000727'    
,'1000732'    
,'1000734'    
,'1000842'    
,'1000867'    
,'1000868'    
,'1000889'    
,'1000906'    
,'1000909'    
,'1001011'    
,'1001018'    
)             
order by 3,4                   

select * from ps_names
where name_type = 'PRI' 
  and emplid in ('1000176'    
,'1000184'    
,'1000200'    
,'1000201'    
,'1000332'    
,'1000436'    
,'1000444'    
,'1000475'    
,'1000531'    
,'1000577'    
,'1000610'    
,'1000654'    
,'1000725'    
,'1000727'    
,'1000732'    
,'1000734'    
,'1000842'    
,'1000867'    
,'1000868'    
,'1000889'    
,'1000906'    
,'1000909'    
,'1001011'    
,'1001018'    
)             
