update ps_pay_check
set name = 'Ludlum,Robert'
where emplid = '1053610';

update ps_pay_check
set paycheck_name = 'Ludlum,Robert'
where emplid = '1053610';

update ps_pay_check
set address2  = '5555 Hinman Ave.'
where emplid = '1053610';

update PS_nw_tmp_employee
set name = 'Ludlum,Robert'
where emplid = '1053610';

update PS_email_addresses
set email_addr = 'r-ludl@northwestern.edu'
where emplid = '1053610'
and  e_addr_type ='CAMP';

update PS_email_addresses
set email_addr = 'bob555'
where  e_addr_type ='NTID'
AND emplid = '1053610';

update ps_addresses
set address1  = '5555 Hinman Ave.'
where emplid = '1053610'
and address_type = 'HOME';

commit


