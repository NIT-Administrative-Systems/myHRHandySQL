select PORTAL_URLTEXT, PORTAL_LABEL, PORTAL_PRNTOBJNAME,PORTAL_URI_SEG1 as menuname,PORTAL_URI_SEG2 as componentname
from PSPRSMDEFN  
where PORTAL_URI_SEG2 LIKE 'NW%';