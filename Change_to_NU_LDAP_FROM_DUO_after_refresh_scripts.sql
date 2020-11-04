
--This updates the LDAP Server field on Directory Configurations Page to revert back to NU LDAP from DUO.
-- The Path is Enterprise Components, Directory Interface, Definitions, Directory Configurations.

------------------------------------------------------------------------------------
--This is old as of 8/13/16 implementation of WebSSO in HR91PROD
--update  PSDSSRVR
--     set DSSRVR = 'REGISTRY.NORTHWESTERN.EDU'
--     where DSDIRID = 'NWU';
------------------------------------------------------------------------------------
--New Version as of 8/13/16
update  PSDSSRVR
     set DSSRVR = 'LDAP5A.CI.NORTHWESTERN.EDU'
     where DSDIRID = 'NWU';

------------------------------------------------------------------------------------
-- This is old as of 8/13/16 implementation of WebSSO in HR91PROD
-- This updates the LDAP Server field on Authentication Page to revert back to NU LDAP from DUO.
-- The path to the page is Enterprise Components, Directory Interface, Mappings, Authentication 
-- update PSDSSECMAPSRVR
--    set DSSRVR = 'REGISTRY.NORTHWESTERN.EDU'
--    where DSSECMAPID = 'NWU';
-----------------------------------------------------------------------------------

--New Version as of 8/13/16
update PSDSSECMAPSRVR
    set DSSRVR = 'LDAP5A.CI.NORTHWESTERN.EDU'
    where DSSECMAPID = 'NWU';

     
     Commit;
