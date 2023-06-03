; count even/odd numbers in a given arraey randomly
	s even=0
	s odd=0
	;	
	s arrayLength=1000000
	;	
	w "Array Size: ",arrayLength,!
	f i=1:1:arrayLength d
	. s a(i)=$random(100)
	. if a(i)#2=0 d
	. . s even=even+1
	. else  d
	. . s odd=odd+1
	;	
	s evenPercentage=even/arrayLength*100
	s oddPercentage=odd/arrayLength*100
	w "----------------",!
	w "# of Even numbers: ",even," - %",evenPercentage,!
	w "# of Odd numbers: ",odd," - %",oddPercentage,!
	;	
	;	
