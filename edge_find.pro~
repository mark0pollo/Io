FUNCTION EDGE_FIND, data_in, Deviation=deviation, Value=vaule, Deriv1=deriv1, Deriv2=deriv2, /left, /right, Firstderiv=firstderiv, SecondDeriv=secondDeriv, _EXTRA=ex

IF KEYWORD_SET(left)=0 AND KEYWORD_SET(Right)=0 THEN BEGIN
	PRINT, 'Please specify left or right'
	RETURN, 'Please specify left or right'
ENDIF

data=data_in

IF KEYWORD_SET(Right) THEN BEGIN
	REVERSE(data)
	RETURN, ESREVER(EDGE_FIND(data, Deviation=deviation, Value=value, Deriv1=deriv1, Deriv2=deriv2, Left=1, FirstDeriv = firstDeriv, SecondDeriv=secondDeriv))
ENDIF


IF KEYWORD_SET(ex) THEN BEGIN
	IF KEYWORD_SET(Deriv1) and KEYWORD_SET(Deriv2) THEN BEGIN
		PRINT, ''extra keywords ambiguous, please recall methods with proper input'
		RETURN, 'extra keywords ambiguous, please recall methods with proper input'
	ENDIF
	IF KEYWORD_SET(Deviation) THEN BEGIN
		PRINT, ''extra keywords ambiguous, please recall methods with proper input'
		RETURN, 'extra keywords ambiguous, please recall methods with proper input'
	ENDIF
ENDIF


IF KEYWROD_SET(deviation) THEN BEGIN
	toReturn = EDGE_FIND(data, Value=1, Left=1)
	IF KEYWORD_SET(deriv1) THEN BEGIN
		toReturn = [toReturn[0], toReturn[1], deriv1]
	ENDIF ELSE
		toReturn = [toReturn[0], toReturn[1], edge_find(data, left=1, deriv1=1, firstDeriv=firstderiv]
	ENDELSE
	IF KEYWORD_SET(deriv2) THEN BEGIN
			toReturn = [toReturn[0], toReturn[1], toReturn[2], deriv2]
		ENDIF ELSE
			toReturn = [toReturn[0], toReturn[1], toReturn[2], edge_find(data, left=1, deriv2=1, secondDeriv=secondderiv]
		ENDELSE
	
	deviation = toReturn[1] - toReturn[0]
	bounds = toReturn[1]
	
	IF toReturn[2] LE toReturn[1] and toReturn[2] GE toReturn[0] THEN BEGIN
		bounds=toReturn[2]
		precision=precision+(toReturn[2]-toReturn[0])
		sum=sum+1
	ENDIF	
	IF toReturn[3] LE toReturn[1] and toReturn[3] GE toReturn[0] THEN BEGIN
		bounds=toReturn[3]
		precision = precision+(toReturn[3]-toReturn[0])
		sum=sum+1
	ENDIF
toReturn = [bounds, (precision/sum)]
ENDIF

IF KEYWORD_SET(value) THEN BEGIN
	RETURN, BOUNDRY_FIND(data, _EXTRA=ex)
ENDIF

IF KEYWORD_SET(deriv1) THEN BEGIN
	IF KEYWORD_SET(firstDeriv) EQ 0 THEN BEGIN
		firstDeriv=DERIV(data)
	ENDIF
	RETURN, FIRST_PEAK_FIND(firstDeriv, 'left', _EXTRA=ex)
ENDIF

IF KEYWORD_SET(deriv2) THEN BEGIN
	IF KEYWORD_SET(secondDeriv) EQ 0 THEN BEGIN
		secondDeriv=DERIV(DERIV(data))
	ENDIF
	RETURN, FIRST_PEAK_FIND(secondDeriv, 'left', _EXTRA=ex)
ENDIF

PRINT, 'please specify a keyword to perform data operations.'
RETURN, 'please specify a keyword to perform data operations.'
END


