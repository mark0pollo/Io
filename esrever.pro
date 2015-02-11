;+
; NAME: ESREVER
;
; PURPOSE: flip indices into a 1-D array from the 0th element to the
; N-th minus 1 element.  Useful when working with an algorithm which
;
; CATEGORY:
;
; CALLING SEQUENCE:
;  IF KEYWORD_SET(Right) THEN BEGIN
;      data = REVERSE(data)
;      RETURN, ESREVER(MARKS_EDGE_FIND(data, Deviation=deviation, Value=value, Deriv1=deriv1, Deriv2=deriv2, Left=1, FirstDeriv = firstDeriv, SecondDeriv=secondDeriv), N_ELEMENTS(data))
;  ENDIF

;
; DESCRIPTION:
;
; INPUTS:
;    idx: array of indices into data
;     size_or_data: N_elements(data) or data itself, where data has
;               been reversed and fed into something like an
;               edge or peak-finding algorithm
;
; OPTIONAL INPUTS:
;	error: optional input to allow you to maintain data that you do not want reversed.
;		An example would be the error bar found on the measuerment.
;
; KEYWORD PARAMETERS:
;
; OUTPUTS:
;
; OPTIONAL OUTPUTS:
;
; COMMON BLOCKS: 
;  Common blocks are ugly.  Consider using package-specific system
;  variables.
;
; SIDE EFFECTS:
;
; RESTRICTIONS:
;
; PROCEDURE:
;
; EXAMPLE:
;
; MODIFICATION HISTORY:
;
; $Id:$
;
; $Log:$
;-
FUNCTION ESREVER, idx, size_or_data, error=Error

  ;; Make sure inputs are specified
  if N_elements(idx) + N_elements(size_or_data) eq 0 then $
    message, 'ERROR: usage: ESREVER, idx, size_or_data'

  ;; Figure out the size of our original data array.  Do it this way
  ;; so user can pass array (by reference) or N_elements(array)
  if N_elements(size_or_data) eq 1 then begin
    ;; assume this is the N_elements(data) case
    dataSize = size_or_data
  endif else begin
    dataSize = N_elements(size_or_data)
  endelse

  ;; Count the indices backward from the right-hand (last) index into
  ;; the array
  toReturn = dataSize-1 - idx

;Account for possible elements that the user does not want un-reversed
	if KEYWORD_SET(error) then begin
		staticNumber = N_ELEMENTS(error)
		for i=0, staticNumber-1 DO BEGIN
			toReturn[error[i]] = idx[error[i]]
		ENDFOR
	ENDIF
return, toReturn
END
