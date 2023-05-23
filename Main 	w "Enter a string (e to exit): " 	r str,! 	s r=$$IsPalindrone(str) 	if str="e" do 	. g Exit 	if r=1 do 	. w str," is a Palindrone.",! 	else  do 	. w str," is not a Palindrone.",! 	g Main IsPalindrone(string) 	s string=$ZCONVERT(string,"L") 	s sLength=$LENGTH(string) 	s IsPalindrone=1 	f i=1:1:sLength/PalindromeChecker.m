Main
	w "Enter a string (e to exit): "
	r str,!
	s r=$$IsPalindrone(str)
	if str="e" do
	. g Exit
	if r=1 do
	. w str," is a Palindrone.",!
	else  do
	. w str," is not a Palindrone.",!
	g Main
IsPalindrone(string)
	s string=$ZCONVERT(string,"L")
	s sLength=$LENGTH(string)
	s IsPalindrone=1
	f i=1:1:sLength/2  do
	.	if $E(string,i)'=$E(string,sLength-i+1) do
	.	. s IsPalindrone=0
	.	. Q
	q IsPalindrone
Exit
	w "Closing Program",!
	HALT
