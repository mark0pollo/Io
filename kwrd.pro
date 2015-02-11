FUNCTION KWRD, Kwrd=kwrd

;This is just a simple function to test both my understanding of functions and 
;my understanding of KeyWords.

;Check if element is defined, if not return 0
;if 0 elements then set boolean to 0
if N_Elements(kwrd) EQ 0 THEN BEGIN
	isDefined = 0

;if nonzero elements set boolean to 1
ENDIF ELSE BEGIN
	isDefined = 1
ENDELSE

;Returns boolean value of defined
RETURN, isDefined

END


