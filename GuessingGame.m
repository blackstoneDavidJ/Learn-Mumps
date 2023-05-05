;DJB learning blocks,fnc,loops,IO
	;
NewGame
	R "Upper bound: ",upperBound,! R "Lower bound: ",lowerBound,!
	s computerChoice=$$GetRandomNumber(upperBound,lowerBound)
;	w "Random choice: ",computerChoice,!
	g GameLoop	
	;	
GetRandomNumber(upperBound,lowerBound)
	Q $random(upperBound)+lowerBound	
	;	
GameLoop
	s userGuess=-1 s guessNumber=1
	for  quit:userGuess=computerChoice  do
	.	w "Guess # ",guessNumber," : Range ( ",lowerBound," , ",upperBound," ) Guess: "
	.	r userGuess,!
	.	if userGuess>computerChoice do
	.	. w "Guess was too high!",!
	.	. s upperBound=userGuess-1a
	.   if userGuess<computerChoice do
	.	. w "Guess was too low!",!
	.	. s lowerBound=userGuess+1
	.   s guessNumber=guessNumber+1
	g Exit
Exit
	w "You guessed it! - Game Over!",!
	q
