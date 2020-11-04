update PSoprdefn
set emailid = 'hrisdevelopment@northwestern.edu';

update PS_email_addresses
set email_addr = 'hrisdevelopment@northwestern.edu'
where  e_addr_type <>'NTID';

update  PSuseremail
set emailid = 'hrisdevelopment@northwestern.edu';

update  PS_ROLEXLATOPR
set emailid = 'hrisdevelopment@northwestern.edu'
where emailid <> ' ';

update ps_nw_employees
set nw_email_address = 'hrisdevelopment@northwestern.edu'
   ,nw_netid_sup_email = 'hrisdevelopment@northwestern.edu'
   ,nw_sup_email_addr = 'hrisdevelopment@northwestern.edu';

update ps_hrs_app_email
set email_addr = 'hrisdevelopment@northwestern.edu';

update ps_nw_tmp_employee
set nw_email_address = 'hrisdevelopment@northwestern.edu';

commit;

-- testing6 password
UPDATE PSOPRDEFN
   SET OPERPSWD       = 'D9fm6acWvRzTfftkVWso1YhQtgo='
      ,PTOPERPSWDV2   = 'D9fm6acWvRzTfftkVWso1YhQtgo='
      ,OPERPSWDSALT   = ' '
      ,ENCRYPTED      = 1
      ,FAILEDLOGINS   = 0
      ,LASTUPDOPRID   = 'PSWDRESET'
 WHERE OPRID NOT IN ('APPACCESS'             -- APPACCESS - clone of HRATJ0
                    ,'EXT_APPLICANT'         -- External Applicant: DO NOT DEL
                    ,'GUEST'                 -- Used by WEBSSO
                    ,'IBUSER'                -- NU Integration Broker USER
                    ,'NWSCRMGR'              -- Batch ID for AE programs
                    ,'NWPRCSSCHED'           -- Start/Stop Process Scheduler
                    ,'NWAPPSERVER'           -- Start/Stop Application Server
                    ,'NWLDAP'                -- Sign-On PeopleCode
                    ,'PHIUSER'               -- Phire User
                    ,'PS'                    -- PeopleSoft Delivered Super ID
                    ,'PTWEBSERVER'           -- Portal Servlet Access ID
                    ,'QRECRUI'               -- QRECRUI-queries for eRecruit
                    ,'SES'                   -- SES Search
                    ,'IDS-SAILPOINT-SOA'     -- Web Service
                    ,'MYHR-SOA-ADMIN'        -- Web Service
                    ,'MYHR-SOA-ADMIN-APIGEE' -- Web Service
                    ,'FASIS_PUB_SOA'         -- Web Service
                    ,'LEARN_NU_SOA'          -- Web Service
                    ,'RJB918');              -- Ronald Blitz
commit;


-- Change IBUSER password to match password in Message Nodes
UPDATE PSOPRDEFN A
   SET A.OPERPSWD      = 'Ty2MTSmQs2wgsPWKbhVqj5OtETA='
      ,A.PTOPERPSWDV2  = 'Ty2MTSmQs2wgsPWKbhVqj5OtETA='
      ,A.OPERPSWDSALT  = ' '
      ,A.ENCRYPTED     = 1
      ,A.ACCTLOCK      = 0
      ,A.FAILEDLOGINS  = 0
      ,LASTPSWDCHANGE  = '31-DEC-2099'
      ,LASTUPDOPRID    = 'PSWDRESET'
where OPRID = 'IBUSER';

commit;

-- Add PeopleSoft Administrator Role to ITMS staff  (Except for UAT)
INSERT INTO PSROLEUSER(ROLEUSER,ROLENAME,DYNAMIC_SW)
SELECT A.OPRID,'PeopleSoft Administrator','N'
  from PSOPRDEFN A
 where A.OPRID in  ('SRC1909'            -- Sarah Cross
                  ,'CEE606'             -- Ceyda Eldek-Batirbek
                  ,'NAG169'             -- Noel Gaceta
                  ,'LAJ243'             -- Leslie Johnson
                  ,'EJL9900'            -- Eric Lat
                  ,'SLK592'             -- Sherry Lynn Majkszak
                  ,'AMA837'             -- Ann Anderson
                  ,'VGK0182'            -- Vanessa Gaeta
                  ,'AAH2700'            -- Ankita Agarwal
                  ,'BIRD'               -- Bridget Mullan
                  ,'ENM134'             -- Edward Mwangi
                  ,'PBN918'             -- Praveena Narisetty
                  ,'SWP302'             -- Swee Phua
                  ,'RMP040'             -- Richard Plodzien
                  ,'RJB918'             -- Ronald Blitz
                  ,'BARRYC'             -- Barry Chiu
                  ,'JJN613'             -- James Neal
                  ,'WTB451'             --  Wilfred U Tumbaga
                  ,'TMC042'             -- Terrence Michael Collins
                  ,'SDH5969'            -- Harrison,Saundra Denise
                  ,'EMN5251'            -- Marban,Evett
                  ,'AMX8198'            -- Xu,Ashley Michelle
                  ,'MVK'                -- Maureen Veronica Knight-Burrell
                  ,'AQZ466'             -- April Zhang
                  ,'GRR602')            -- Gail Renfrow       
   and NOT EXISTS (SELECT 'X' FROM PSROLEUSER WHERE ROLEUSER=A.OPRID AND ROLENAME='PeopleSoft Administrator')
   and EXISTS (SELECT 'X' FROM PSDBOWNER WHERE DBNAME NOT IN ('HR857PRD','HR857RPT'));

commit;


-- update shell script to get the script from the correct directory

update PS_PRCSTYPEDEFN
set cmdline = replace(cmdline,'hr857prd', (select lower(dbname) from ps.psdbowner))
where PRCSTYPE = 'Shell Script';

update PS_PRCSDEFN
set  parmlist = replace(parmlist,'hr857prd', (select lower(dbname) from ps.psdbowner))
where PRCSTYPE = 'Shell Script';

commit;

update ps_hr_sstext_text
set hr_SSTEXT_TEXT = 'hrisdevelopment@northwestern.edu'
where hr_SSTEXT_TEXT like 'benefits@northwestern.edu';

commit;

-- repoint URLs to correct Test web address;
select * from psurldefn
where lower(URL) like '%https://myhr.northwestern.edu/psp/hr857prd%';

update psurldefn  
set url = replace(url,'https://myhr.northwestern.edu/psp/hr857prd',
                         case (select upper(dbname) from ps.psdbowner)
                           when 'HR857DVA' then 'https://evhr857dvaweba.ci.northwestern.edu:8443/psp/hr857dva'
                           when 'HR857DVB' then 'https://evhr857dvbweba.ci.northwestern.edu:8443/psp/hr857dvb'
                           when 'HR857DVC' then 'https://evhr857dvcweba.ci.northwestern.edu:8443/psp/hr857dvc'
                           when 'HR857UPG' then 'https://evhr857upgweba.ci.northwestern.edu:8443/psp/hr857upg'
                           when 'HR857TRN' then 'https://evhr857trnweba.ci.northwestern.edu:8443/psp/hr857trn'
                           when 'HR857UAT' then 'https://evhr857uatweba.ci.northwestern.edu:8443/psp/hr857uat'
                           when 'HR857PAT' then 'https://myhr-pat.northwestern.edu/psp/hr857pat'
                           else 'Undefined-FASIS-db'
                         end)
where lower(URL) like '%https://myhr.northwestern.edu/psp/hr857prd%';

commit;

select * from psurldefn
where lower(URL) like '%http://myhr.northwestern.edu/psp/hr857prd%';

update psurldefn 
set url = replace(url,'http://myhr.northwestern.edu/psp/hr857prd',
                         case (select upper(dbname) from ps.psdbowner)
                           when 'HR857DVA' then 'http://evhr857dvaweba.ci.northwestern.edu:8000/psp/hr857dva'
                           when 'HR857DVB' then 'http://evhr857dvbweba.ci.northwestern.edu:8000/psp/hr857dvb'
                           when 'HR857DVC' then 'http://evhr857dvcweba.ci.northwestern.edu:8000/psp/hr857dvc'
                           when 'HR857UPG' then 'http://evhr857upgweba.ci.northwestern.edu:8000/psp/hr857upg'
                           when 'HR857TRN' then 'http://evhr857trnweba.ci.northwestern.edu:8000/psp/hr857trn'
                           when 'HR857UAT' then 'http://evhr857uatweba.ci.northwestern.edu:8000/psp/hr857uat'
                           when 'HR857PAT' then 'http:///myhr-pat.northwestern.edu/psp/hr857pat'
                           else 'Undefined-FASIS-db'
                         end)
where lower(URL) like '%http://myhr.northwestern.edu/psp/hr857prd%';

select * from psurldefn where url like 'https://careers.northwestern.edu/psp/hr857prd_er%';

update psurldefn 
set url = replace(url,'https://careers.northwestern.edu/psp/hr857prd_er',
                         case (select upper(dbname) from ps.psdbowner)
                           when 'HR857DVA' then 'https://evhr857dvaweba.ci.northwestern.edu:8443/psp/hr857dva_er'
                           when 'HR857DVB' then 'https://evhr857dvbweba.ci.northwestern.edu:8443/psp/hr857dvb_er'
                           when 'HR857DVC' then 'https://evhr857dvcweba.ci.northwestern.edu:8443/psp/hr857dvc_er'
                           when 'HR857UPG' then 'https://evhr857upgweba.ci.northwestern.edu:8443/psp/hr857upg_er'
                           when 'HR857TRN' then 'https://evhr857trnweba.ci.northwestern.edu:8443/psp/hr857trn_er'
                           when 'HR857UAT' then 'https://evhr857uatweba.ci.northwestern.edu:8443/psp/hr857uat_er'
                           when 'HR857PAT' then 'https://careers-pat.northwestern.edu/psp/hr857pat_er'
                           else 'Undefined-FASIS-db'
                         end)
where lower(URL) like '%https://careers.northwestern.edu/psp/hr857prd_er%';

commit;


-- SOA-Change URL, Inactivate Routing
update PSIBRTNGDEFN set eff_status = 'I'
where routingdefnname = 'NW_LDAP_MSG_HR_TO_NUSOA'
and EXISTS (SELECT 'X' FROM PSDBOWNER WHERE DBNAME NOT IN ('HR857PRD','HR857RPT'));

update PSIBRTNGDEFN set eff_status = 'I' 
where routingdefnname = 'NW_FASIS_EMPL_RO' 
and EXISTS (SELECT 'X' FROM PSDBOWNER WHERE DBNAME NOT IN ('HR857PRD','HR857RPT','HR857UAT'));

update PSMSGNODEDEFN set ACTIVE_NODE = 0 where MSGNODENAME = 'PSFT_EP'
and EXISTS (SELECT 'X' FROM PSDBOWNER WHERE DBNAME NOT IN ('HR857PRD','HR857RPT','HR857UAT'));

update PSMSGNODEDEFN set ACTIVE_NODE = 0 where MSGNODENAME = 'NW_NUSOA'
and EXISTS (SELECT 'X' FROM PSDBOWNER WHERE DBNAME NOT IN ('HR857PRD','HR857RPT','HR857UAT'));

Commit;

update PSNODECONPROP set PROPVALUE='https://northwestern-test.apigee.net/' where msgnodename='NW_NUSOA' and Propid='PRIMARYURL';

update PSRTNGDFNCONPRP set PROPVALUE = 'mTG3Sx1kgLumnjove1GMr60mUsTvnUtv' where PROPNAME = 'apikey';

update PSNODECONPROP set PROPVALUE='mTG3Sx1kgLumnjove1GMr60mUsTvnUtv' where msgnodename='NW_NUSOA' and PROPNAME = 'apikey';

commit;

-- Change BenefitFocus Link
select * from psprsmdefn where portal_objname ='NW_EXTLINK_BENEFITFOCUS';

update psprsmdefn 
set portal_urltext = 'https://testsp.benefitfocus.com/sp/startSSO.ping?PartnerIdpId=urn:mace:incommon:northwestern.eduAmpersandTargetResource=https%3A%2F%2Fappbuilderjct.benefitfocus.com%2Fappbuilder%2FssoInbound.aspx%3FApplicationID%3DHRInTouch' where portal_objname ='NW_EXTLINK_BENEFITFOCUS';

update psprsmdefn SET portal_urltext  = REPLACE(portal_urltext , 'Ampersand', '&') where portal_objname ='NW_EXTLINK_BENEFITFOCUS';

commit;

select * from psprsmdefn where portal_objname ='NW_EXTLINK_BENEFITFOCUS';

-- Change Fidelity Link
select * from psprsmdefn where portal_objname ='NW_EXTLINK_FIDELITY';

update psprsmdefn set portal_urltext = 'https://fed.it.northwestern.edu/idp/profile/SAML2/Unsolicited/SSO?providerId=urn:sp:fidelity:geninbndnbparts20:uat:xq1Ampersandtarget=https://xqa-nbacpt.fidelity.com/SSOTransfer?option=ngIAHome' where portal_objname ='NW_EXTLINK_FIDELITY';

update psprsmdefn SET portal_urltext  = REPLACE(portal_urltext , 'Ampersand', '&') where portal_objname ='NW_EXTLINK_FIDELITY';

commit;

select * from ps_HR_SSTEXT_TEXT where text_id='NWGLPARMS';
update ps_HR_SSTEXT_TEXT set HR_SSTEXT_TEXT ='"hrisdevelopment@northwestern.edu"'  where text_id='NWGLPARMS';

select * from PSMSGCATDEFN where MESSAGE_SET_NBR = '32000' and MESSAGE_NBR ='42';
update PSMSGCATDEFN set MESSAGE_TEXT = replace(MESSAGE_TEXT,'HR857PRD', (select upper(dbname) from ps.psdbowner)) where MESSAGE_SET_NBR = '32000' and MESSAGE_NBR ='42';

select * from psprsmdefn where portal_objname in ('NW_HR_CLASSIC_HOME','ADMN_S201903191102552668233283','NW_HR_REPORTS_DASHBOARD', 'ADMN_S201903191118066131168553');
update psprsmdefn SET portal_urltext  = REPLACE(portal_urltext , 'hr857prd', (select lower(dbname) from ps.psdbowner)) where portal_objname in ('NW_HR_CLASSIC_HOME','ADMN_S201903191102552668233283','NW_HR_REPORTS_DASHBOARD', 'ADMN_S201903191118066131168553');
update psprsmdefn set portal_urltext = replace(portal_urltext, 'myhr.northwestern.edu',
                         case (select upper(dbname) from ps.psdbowner)
                           when 'HR857DVA' then 'evhr857dvaweba.ci.northwestern.edu:8443'
                           when 'HR857DVB' then 'evhr857dvbweba.ci.northwestern.edu:8443'
                           when 'HR857DVC' then 'evhr857dvcweba.ci.northwestern.edu:8443'
                           when 'HR857UPG' then 'evhr857upgweba.ci.northwestern.edu:8443'
                           when 'HR857TRN' then 'evhr857trnweba.ci.northwestern.edu:8443'
                           when 'HR857UAT' then 'evhr857uatweba.ci.northwestern.edu:8443'
                           when 'HR857PAT' then 'myhr-pat.northwestern.edu'
                         end)
where portal_objname in ('NW_HR_CLASSIC_HOME','ADMN_S201903191102552668233283','NW_HR_REPORTS_DASHBOARD', 'ADMN_S201903191118066131168553');

Commit;

select * from ps_NW_DB_REFRESH;