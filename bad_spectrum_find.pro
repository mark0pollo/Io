PRO BAD_SPECTRUM_FIND, nday_start, nday_end

  dbclose ;; Just in case
  dbname = 'ssg_reduce'
  dbopen, dbname, 0



	
    for inday=nday_start, nday_end do begin
     ndayl = string(format='("nday>", i5)', inday)
     ndayh = string(format='("nday<", i5)', inday+1)
Print, ndayl, ndayh
     entries = dbfind(ndayl, $
                   dbfind(ndayh, $
                      dbfind("bad<2047", $
                         dbfind("typecode=2"))), $
                    count=data_count)

     if data_count eq 0 then $
        CONTINUE

  dbext, entries, "fname, nday, date, bad, m_dispers", $
         files, ndays, dates, badarray, disp_arrays
		
		FOR ifile=0, data_count-1 DO BEGIN
		    disp = disp_arrays[*,ifile]
		    IF N_elements(c0) EQ 0 then BEGIN
		       c0 = disp[0] 
			c1 = disp[1] 
			c2 = disp[2] 
		ENDIF ELSE BEGIN
		       c0 = [c0, disp[0]] 
			c1 = [c1, disp[1]] 
			c2 = [c2, disp[2]] 
		ENDELSE
		ENDFOR ;; each dispersion
   ENDFOR
IF N_ELEMENTS(c0) GT 0 THEN BEGIN
	tags = ['nday', 'c0', 'c1', 'c2']
	toReturn = CREATE_STRUCT(tags, ndays, c0, c1, c2)
ENDIF ELSE BEGIN
	print, 'No Data'
ENDELSE
dbclose
this = data_display(toReturn)
END
