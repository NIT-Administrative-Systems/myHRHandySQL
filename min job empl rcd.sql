select * 
FROM PS_JOB A 
where A.EMPL_RCD =
        (SELECT MIN(A2.EMPL_RCD)
           FROM PS_JOB A2
          WHERE A2.EMPLID = A.EMPLID)
and A.EFFDT = ( SELECT MAX (C.EFFDT) 
        FROM PS_JOB C 
                WHERE C.EMPLID = A.EMPLID 
                    AND C.EMPL_RCD = A.EMPL_RCD 
                AND ((C.EFFDT <= sysdate) 
                      OR (A.EFFDT >sysdate
                         AND sysdate < ( SELECT MIN(J2.EFFDT) 
                             FROM PS_JOB J2 
                                WHERE J2.EMPLID = A.EMPLID 
                                AND J2.EMPL_RCD = A.EMPL_RCD) ) )) 
   AND A.EFFSEQ = ( SELECT MAX(D.EFFSEQ) 
                     FROM PS_JOB D 
                         WHERE D.EMPLID = A.EMPLID 
                         AND D.EMPL_RCD = A.EMPL_RCD 
                        AND D.EFFDT = A.EFFDT) 
 and a.emplid = '1000867'