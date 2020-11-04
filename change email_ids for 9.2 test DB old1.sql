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

-- Obsolete
-- testing6 password
--UPDATE PSOPRDEFN A
--   SET A.OPERPSWD       = 'D9fm6acWvRzTfftkVWso1YhQtgo='
--      ,A.PTOPERPSWDV2   = 'D9fm6acWvRzTfftkVWso1YhQtgo='
--      ,A.OPERPSWDSALT   = ' '
--      ,A.ENCRYPTED      = 1
--      ,A.ACCTLOCK       = 0
--      ,A.FAILEDLOGINS   = 0
--      ,A.LASTUPDOPRID   = 'PSWDRESET'
--where EXISTS (SELECT 'X'
--                FROM PSROLEUSER
--               WHERE ROLEUSER = A.OPRID
--                 AND ROLENAME LIKE 'NW_SS%');
--
--commit;

-- testing6 password
UPDATE PSOPRDEFN
   SET OPERPSWD       = 'D9fm6acWvRzTfftkVWso1YhQtgo='
      ,PTOPERPSWDV2   = 'D9fm6acWvRzTfftkVWso1YhQtgo='
      ,OPERPSWDSALT   = ' '
      ,ENCRYPTED      = 1
      ,FAILEDLOGINS   = 0
      ,LASTUPDOPRID   = 'PSWDRESET'
 WHERE OPRID NOT IN ('APPACCESS'            -- APPACCESS - clone of HRATJ0
                    ,'EXT_APPLICANT'        -- External Applicant: DO NOT DEL
                    ,'GUEST'                -- Used by WEBSSO
                    ,'IBUSER'               -- NU Integration Broker USER
                    ,'NWSCRMGR'             -- Batch ID for AE programs
                    ,'NWPRCSSCHED'          -- Start/Stop Process Scheduler
                    ,'NWAPPSERVER'          -- Start/Stop Application Server
                    ,'NWLDAP'               -- Sign-On PeopleCode
                    ,'PHIUSER'              -- Phire User
                    ,'PS'                   -- PeopleSoft Delivered Super ID
                    ,'PTWEBSERVER'          -- Portal Servlet Access ID
                    ,'QRECRUI'              -- QRECRUI-queries for eRecruit
                    ,'SES'                  -- SES Search
                    ,'IDS-SAILPOINT-SOA'    -- Web Service
                    ,'MYHR-SOA-ADMIN'       -- Web Service
                    ,'MYHR-SOA-ADMIN-APIGEE' -- Web Service
                    ,'FASIS_PUB_SOA'        -- Web Service
                    ,'LEARN_NU_SOA');       -- Web Service
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

-- Add PeopleSoft Administrator Role to ITMS staff  (Except for QA)
INSERT INTO PSROLEUSER(ROLEUSER,ROLENAME,DYNAMIC_SW)
SELECT A.OPRID,'PeopleSoft Administrator','N'
  from PSOPRDEFN A
 where A.OPRID in ('AAL544'             -- Armando Alaniz
                  --,'JHB219'             -- James Bowie
                  ,'SRC1909'            -- Sarah Cross
                  --,'EAE746'             -- Elizabeth Earl
                  ,'CEE606'             -- Ceyda Eldek-Batirbek
                  --,'LAF270'             -- Lawrence Friedmann
                  ,'NAG169'             -- Noel Gaceta
                  ,'LAJ243'             -- Leslie Johnson
                  ,'EKI805'             -- Eduard Khutornyy
                  ,'EJL9900'            -- Eric Lat
                  --,'HRL1853'            -- Heather Lunders-Kotar
                  ,'SLK592'             -- Sherry Lynn Majkszak
                  ,'AAH2700'            -- Ankita Agarwal
                  ,'BIRD'               -- Bridget Mullan
                  ,'ENM134'             -- Edward Mwangi
                  ,'PBN918'             -- Praveena Narisetty
                  --,'VPE657'             -- Veronica Paredes
                  ,'SWP302'             -- Swee Phua
                  ,'RMP040'             -- Richard Plodzien
                  --,'PRS223'             -- Petrina Stephenson
                  --,'TDW152'             -- Tramaine Wells
                  ,'RJB918'             -- Ronald Blitz
                  ,'BARRYC'             -- Barry Chiu
                  --,'SAM669'             -- Scot Milford
                  ,'JJN613'             -- James Neal
                  ,'VGK0182'						-- Vanessa Gaeta
                  --,'VVQ5442' 						-- Val Vaysberg 
                  ,'KAH734')             -- Kim Amesquita                  
   and NOT EXISTS (SELECT 'X' FROM PSROLEUSER WHERE ROLEUSER=A.OPRID AND ROLENAME='PeopleSoft Administrator')
   and EXISTS (SELECT 'X' FROM PSDBOWNER WHERE DBNAME NOT IN ('HR92PROD','HR92REPT','HR92QA'));

commit;


-- update shell script to get the script from the correct directory

update PS_PRCSTYPEDEFN
set cmdline = replace(cmdline,'hr92prod', (select lower(dbname) from ps.psdbowner))
where PRCSTYPE = 'Shell Script';

update PS_PRCSDEFN
set  parmlist = replace(parmlist,'hr92prod', (select lower(dbname) from ps.psdbowner))
where PRCSTYPE = 'Shell Script';

commit;

update ps_hr_sstext_text
set hr_SSTEXT_TEXT = 'hrisdevelopment@northwestern.edu'
where hr_SSTEXT_TEXT like 'benefits@northwestern.edu';

commit;

-- repoint URLs to correct Test web address;
select * from psurldefn
where lower(URL) like '%https://myhr.northwestern.edu/psp/hr92prod%';

update psurldefn
set url = replace(url,'https://myhr.northwestern.edu/psp/hr92prod',
                         case (select upper(dbname) from ps.psdbowner)
                           when 'HR92DEVA' then 'http://hr92devaweb.ci.northwestern.edu/psp/hr92deva'
                           when 'HR92DEVB' then 'http://hr92devbweb.ci.northwestern.edu/psp/hr92devb'
                           when 'HR92DEVC' then 'http://hr92devcweb.ci.northwestern.edu/psp/hr92devc'
                           when 'HR92DEVD' then 'http://hr92devdweb.ci.northwestern.edu/psp/hr92devd'
                           when 'HR92TRN'  then 'http://hr92trnweb.ci.northwestern.edu/psp/hr92trn'
                           when 'HR92UPG'  then 'http://hr92upgweb.ci.northwestern.edu/psp/hr92upg'
                           when 'HR92QA'   then 'https://nuhr92qa.northwestern.edu/psp/hr92qa'
                           else 'Undefined-FASIS-db'
                         end)
where lower(URL) like '%https://myhr.northwestern.edu/psp/hr92prod%';

commit;

select * from psurldefn
where lower(URL) like '%http://myhr.northwestern.edu/psp/hr92prod%';

update psurldefn
set url = replace(url,'http://myhr.northwestern.edu/psp/hr92prod',
                         case (select upper(dbname) from ps.psdbowner)
                           when 'HR92DEVA' then 'http://hr92devaweb.ci.northwestern.edu/psp/hr92deva'
                           when 'HR92DEVB' then 'http://hr92devbweb.ci.northwestern.edu/psp/hr92devb'
                           when 'HR92DEVC' then 'http://hr92devcweb.ci.northwestern.edu/psp/hr92devc'
                           when 'HR92DEVD' then 'http://hr92devdweb.ci.northwestern.edu/psp/hr92devd'
                           when 'HR92TRN'  then 'http://hr92trnweb.ci.northwestern.edu/psp/hr92trn'
                           when 'HR92UPG'  then 'http://hr92upgweb.ci.northwestern.edu/psp/hr92upg'
                           when 'HR92QA'   then 'http://nuhr92qa.northwestern.edu/psp/hr92qa'
                           else 'Undefined-FASIS-db'
                         end)
where lower(URL) like '%http://myhr.northwestern.edu/psp/hr92prod%';

commit;


-- SOA-Change URL, Inactivate Routing
update PSIBRTNGDEFN set eff_status = 'I'
where routingdefnname = 'NW_LDAP_MSG_HR_TO_NUSOA'
and EXISTS (SELECT 'X' FROM PSDBOWNER WHERE DBNAME NOT IN ('HR92PROD','HR92REPT'));

update PSIBRTNGDEFN set eff_status = 'I' 
where routingdefnname = 'NW_FASIS_EMPL_RO' 
and EXISTS (SELECT 'X' FROM PSDBOWNER WHERE DBNAME NOT IN ('HR92PROD','HR92REPT','HR92QA'));

update PSMSGNODEDEFN set ACTIVE_NODE = 0 where MSGNODENAME = 'PSFT_EP'
and EXISTS (SELECT 'X' FROM PSDBOWNER WHERE DBNAME NOT IN ('HR92PROD','HR92REPT','HR92QA'));

update PSMSGNODEDEFN set ACTIVE_NODE = 0 where MSGNODENAME = 'NW_NUSOA'
and EXISTS (SELECT 'X' FROM PSDBOWNER WHERE DBNAME NOT IN ('HR92PROD','HR92REPT','HR92QA'));

Commit;

update PSNODECONPROP
set PROPVALUE='https://northwestern-test.apigee.net/'
where msgnodename='NW_NUSOA' and Propid='PRIMARYURL';

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

select * from psprsmdefn where portal_objname ='NW_EXTLINK_FIDELITY';

select * from ps_HR_SSTEXT_TEXT where text_id='NWGLPARMS';
update ps_HR_SSTEXT_TEXT set HR_SSTEXT_TEXT ='"hrisdevelopment@northwestern.edu"'  where text_id='NWGLPARMS';
Commit;

select * from ps_NW_DB_REFRESH;