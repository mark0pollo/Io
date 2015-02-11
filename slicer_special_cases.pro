FUNCTION SLICER_SPECIAL_CASES, data_in

d2x2 = 0
d2x=0

;this works throgh the data to find the first instance of the max
;the idea here being that the first peak might be a local max
;that is throwing off the data
WHILE d2Data(d2x) LT (MAX(d2Data)*.9) DO BEGIN
	d2x = d2x+1
ENDWHILE 

;This search is basically looking for the first overly drastic change.
;In the first derivative the initial turn on point should be a huge leap.
WHILE d2data(d2x2 + 1) LE d2data(d2x2)*2 DO BEGIN
	d2x2 = d2x2+1
ENDWHILE
toReturn = [d2x, d2x2]

RETURN, toReturn
END
