; Note this guide is specifically made with MUMPS fis-gtm implementation in mind,
; imformation may not work on another version
; --
; Mumps is designed for health systems like vista
; has a built in database that is persistantly stored on disk
; The database structure is a key-value pair that is organized nodes that have sub nodes
; basically like a tree
; --
; these can be created with globals with this syntax, globals need the "^"character for definition
	SET ^myGlobal("myperfectkey")="thebestvalue"
	SET myLocal("k")="v" ; this is not global as its missing the "^" characater
; globals will stay on disk unless they are removed with kill command
	KILL ^myGlobal
	;
Commands
	SET s 	; used to set variables to data
	NEW n 	; declares a variable
	FOR f 	; for loop used to loop through logic given specific perameters
	IF    	; allows you to do conditional statements with boolean logic
	DO 	d 	; do will do an action after a boolean logic, like an if statement
	READ r 	; read will read from a device such as user input from a terminal or a file
	WRITE w ; write will write to a device such as a terminal or file
	HALT  	; halt will shut down the program
	GOTO g 	; goto allows you to jump from blocks of code in mumps
	OPEN o 	; open allows you to open devices such as files
	USE  	; use allows you to use these devices you have previously opened
;   there are probably more but these are the ones ive leared so far
Operations
	; use operations to perform logic
	+ ; addition
	- ; subtraction
	/ ; division
	# ; modulus to find remainder
	_ ; combine two strings or numbers
	% ; not sure exactly yet :)
	: ; used for specific operations, with regards to the context. below has an example I know
	= ; used to set data to a variable, or comparison operations, like == in java
SyntaxRules
; before each command, you must either put a space or a tab like this, tab is easier i think
	write "HELLO WORLD"
;this would not run
write "Hello WORLD"
; spacing is super important in mumps, unlike most common languages
; in Java you would get away with writing code like this, and yes theres no "SET" command in java :D
	set var = 1
; but in mumps a space is not seen as just space
; cant even have spaces underneath code, my editor will autofill an ; in
	set var=1 
; this is legal
; for and if statements are very specific aswell beeing written like this
; note there is no While tag like in most langauge, use the 2nd for example to basically make one
	; with a condition
	for 1:1:10 do
	. ;
	for  quit:data=1  do 
	. ;
	for  do
	. ;
	if var=2 do
	. ;
; to do if not logic do
	if 'var=2 do
	. ;
Variables
; No type declarations
; There are strings, numbers, and arrays. Boolean can be numbers 1 or 0
	s var="David"
	s var=3124
	s var("David")="Blackstone"
	s var("123456789","07082000")="David Blackstone"
	s pretendBool=0
CodeFlow
; mumps code can be broken up into Blocks and the user can use GOTO to jump from block to block
; NOTE if this Main had logic, and no "GOTO MyBlock" then it will fall through to MyBetterBlock
; this is bad because then logic that we dont want to run will and could break the program,
; plus its just messy
Main
	GOTO MyBlock
MyBetterBlock
	; logic
	GOTO Main
MyBlock
; do some programming
	Read "Go back to main? (1,0): ",choice,!
	if choice=1 do
	. GOTO Main
; this would loop indefinitly :D
; Mumps has a lot of built in functions but the main ones i have used are
	$data(var) ; checks the variable being passed in to see if there is data present, returns false if not
	$test      ; retunrs true or false on weather the last expression was successful
	$CHAR(64)  ; returns the character of a given ascii number being passed in
	$random(upperBound)+lowerbound  ; returns a random number in the given bounds
; if you want to create a function that returns somethings after some logic you can do
Main
	SET randomNumber=$$GetANumber(100,1)
	WRITE "Random Number: ",randomNumber,!
GetANumber(upper,lower)
	quit $random(upper)+lower
	;
; not that with built in function you only need $ but with user created you ned $$
; also if you need a function that doesnt return anything just make a Block 
; that at the end GOTO somewhere
	;
OtherCoolStuff
; you can open files in mumps and create logic to do all sorts of things
; use this to open a file in the filesystem
		set file="/home/vboxuser/Desktop/mumpscode/textfile.txt"
	open file:(append:wrap:recordsize=512)
	use file
	write "New Line",!
	close file
; this works like this, file is the path to the file, the ":" is used here for specific file positioning
; so (append) means to append data to file, like write into it, wrap just means to allow the text to wrap
; in the file, and recordsize referes to how large a single record entry can be 512 bytes, in this example
	;
; --More advanced stuff--
; notice that write is also used to write text to the terminal. mumps allows these commands to 
; compute toward multiple contexts. in this case it will WRITE to a file, can also READ
; after we close the file, the WRITE and READ commands change back to the terminal device
; and allow you to continue to write, read to terminal
; these can be very powerful when dealing with more complex logic and filesystems
Colors
; not sure how important this is but you can use color when writing text to a terminal with some codes
Set
	s ^CC("BLACK")="[30m"
	s ^CC("RED")="[31m"
	s ^CC("GREEN")="[32m"
	s ^CC("YELLOW")="[33m"
	s ^CC("BLUE")="[34m"
	s ^CC("MAGENTA")="[35m"
	s ^CC("CYAN")="[36m"
	s ^CC("WHITE")="[37m"
	s ^CC("END")="[0m"
; what i did here was create a global that I can access from any mumps file and it stores the color code, and delimiter code
; I then use this function I created to return a string with color codes embedded
GCS(string,color)
	q $CHAR(27)_^CC(color)_string_$CHAR(27)_^CC("END")
	;
