MAIN
	S EXIT=0
	F  Q:EXIT  D
	. R "A or B?: ",CHOICE,!
	. I CHOICE="A" D A Q:EXIT
	. I CHOICE="B" D B Q:EXIT
	. E  D C Q:EXIT
	Q
A
	W "We're at A",!
	S EXIT=1
	Q
B
	W "We're at B",!
	Q
C
	W "We're at C",!
	Q
