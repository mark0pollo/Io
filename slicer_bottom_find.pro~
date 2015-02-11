FUNCTION SLICER_BOTTOM_FIND, data_in, Xdata_in=xdata_in, LowEnd=lowEnd, HighEnd=highEnd, Narrow=narrow, All=all, Error=error, Right=right, Deviation=deviation, Value = value, Deriv1=deriv1, Deriv2=deriv2 _Extra=_extra

;This script will take an array of data points and return the points
;that are closest to the acceptable deviation. The default is 1 and 10% of max.
;it will return an array of (1%, 10%)

IF KEYWORD_SET(_extra) THEN BEGIN
	PRINT, 'extra keywords ambiguous, please recall methods with proper input'
	RETURN, 'extra keywords ambiguous, please recall methods with proper input'
ENDIF

data=data_in
IF KEYWORD_SET(xdata_in) THEN xdata=xdata_in
IF KEYWORD_SET(right) THEN data=REVERSE(data)

If KEYWORD_SET(lowEnd) EQ 0 THEN lowEnd = .01
If KEYWORD_SET(highEnd) EQ 0 THEN highEnd = .1
size = N_ELEMENTS(data)

;if xdata isn't given then create a set of integers assuming it is in order
IF N_ELEMENTS(xdata) EQ 0 THEN BEGIN
	xdata=FINDGEN(size)
ENDIF

;make sure the data is ordered by x coordinate, probably time 
;set a boolean if not in order
dataElements = size
notInOrder=0
FOR i=0, dataElements-2 Do Begin
	if xdata(i) GT xdata(i+1) then notInOrder=1 
EndFOR

IF notInOrder EQ 1 THEN BEGIN
	Print, 'Sort data first'
	return, 'sort data first'
ENDIF

;adjust the data down so that it will always return a useable result.
;effectively acts as a smoother.
IF MIN(data) NE 0 THEN data=data-MIN(data)

boundries = boundry_find(data, highEnd, lowEnd)
xOne=boundries[0]
xTen = boundries[1]

;Establish first and second ordere derivatives of the data
dData = DERIV(data)
d2Data = DERIV(dData)

;Finds the first peak of the first and second derivatives which is the
;simplest and most accurate case in most instances
dfirstpeak = FIRST_PEAK_FIND(dData, 'left')
d2firstPeak = FIRST_PEAK_FIND(d2Data, 'left')
d2special = SLICER_SPECIAL_CASE(d2Data)

;FIlters out the data and only returns the desired data.
;also calculate precision
precision = 0.0
sum = 2.0

IF KEYWORD_SET(Narrow) THEN BEGIN
	IF dfirstpeak LE xTen and dfirstpeak GE xOne THEN Begin
		bounds=dfirstpeak
		precision = (xTen+dfrirstpeak)
		sum=sum+1
	ENDIF
ENDIF ELSE BEGIN
	bounds=xTen
	precision = (xTen-xOne)
	IF d2special[1] LE xTen and d2special[1] GE xOne THEN BEGIN
		bounds=d2special[1]
		precision = precision+(d2special[1]-xOne)
		sum=sum+1
	ENDIF
	IF d2special[0] LE xTen and d2special[0] GE xOne THEN BEGIN
		bounds=d2special[0]
		precision = precision+(d2special[0]-xOne)
		sum=sum+1
	ENDIF
	IF dfirstpeak LE xTen and dfirstpeak GE xOne THEN BEGIN
		bounds=dfirstpeak
		precision=precision+(dfirstpeak-xOne)
		sum=sum+1
	ENDIF	
	IF d2firstpeak LE xTen and d2firstpeak GE xOne THEN BEGIN
		bounds=d2firstpeak
		precision = precision+(d2firstpeak-xOne)
		sum=sum+1
	ENDIF
ENDELSE

deviation=(precision/sum)
IF KEYWORD_SET(error) THEN bound = [bounds, deviation] ELSE bound = bounds
IF KEYWORD_SET(All) THEN bound = [xOne, d2special[0], dfirstpeak, d2firstPeak, d2special[1], xTen, deviation]
IF KEWORD_SET(right) THEN bound = ESREVER(bound, size)

RETURN, bound
END
