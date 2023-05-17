PIS
MenuSelection
	w "**Menu Selection**",!
	w "1. Add new patient",!
	w "2. Edit Patient",!
	w "3. View Patient",!
	w "4. Exit Program",!
	w "Option: "
	R optionSelected,!
	if optionSelected=1 do
	. g AddNewPatient
	if optionSelected=2 do
	. g EditPatient
	if optionSelected=3 do 
	. g ViewPatient 
	if optionSelected=4 do
	. g Exit
	if optionSelected=5 do
	. g KillGlobals
AddNewPatient
	w "**Add New Patient**",!
	w "Enter First Name: "
	R pF,!
	w "Enter Last Name: "
	R pL,!
	w "Enter Birthday (xxxxxxxx): "
	R pB,!
	w "Enter SSn (xxxxxxxxx): "	
	R pSSN,!
	s inserted=0
	for i=1:1 quit:inserted=1  do
	.   if $data(^s(i))=0 do
	.   . s ^s(i)=pSSN
	.   . s inserted=1
	s ^p(pSSN)=pF_" "_pL
	s ^b(^p(pSSN))=pB	
	g MenuSelection
EditPatient
	w "**Edit Patient**",!
	w "Enter Patient SSN (c to cancel): "
	r pSSN,!
	if pSSN="c" do
	. w "Operation canceled returning to main menu."
	. g MenuSelection
	if $data(^p(pSSN))=0 do
	. w "Error, Patient SSN is not found.",!
	. g SearchPatient
	s p=^p(pSSN)
	s *pF=$$SPLIT^%MPIECE(^p(pSSN))
	w "--Patient:",p,"--",!
	w "**Choose what to edit**",!
	w "1. First Name",!
	w "2. Last Name",!
	w "3. Birtday",!
	w "4. SSN",!
	w "Choice: "
	R choice,!
	if choice=1 do
	. w "Enter new First Name: "
	. R nF
	. s ^p(pSSN)=nF_pF(2)
	if choice=2 do
	. w "Enter new Last Name: "
	. R nL
	. s ^p(pSSN)=pF(1)_nL
	if choice=3 do
	. w "Enter new Birthday (xxxxxxxx): "
	. R nB
	. s ^b(^p(pSSN))=nB
	if choice=4 do
	. w "Enter new SSN (xxxxxxxxx): "
	. R nSSN
	. s ^p(nSSN)=^p(pSSN)
	. k ^p(pSSN)
	. s replaced=0
	. for i=1:1 quit:replaced=1  do
	. . if ^s(i)=pSSN do
	. . . s ^s(i)=nSSN
	. . . s replaced=1
	g MenuSelection
ViewPatient
	w "**View Patient**",!
	w "1. View All Patients",!
	w "2. Search for a Patient",!
	w "3. Main Menu",!
	w "Option: "
	R choice,!
	if choice=2 do
	. g SearchPatient
	if choice=3 do
	. g MenuSelection
	w "**--Patients--**",!
	for i=1:1 quit:'$data(^s(i))  do
	. 	w "Name: ",^p(^s(i)),!	
	w "**--Patients--**",!
	g ViewPatient
SearchPatient
	w "Enter Patient SSN (c to cancel): "
	r pSSN,!
	if pSSN="c" do
	. w "Operation canceled returning to main menu."
	. g MenuSelection
	if $data(^p(pSSN))=0 do
	. w "Error, Patient SSN is not found.",!
	. g SearchPatient
	s *pF=$$SPLIT^%MPIECE(^p(pSSN))
	w "**-----------**",!
	w "First Name: ",!,"  "_pF(1),!
	w "Last Name: ",!,"  "_pF(2),!
	w "Birthday: ",!,"  "_^b(^p(pSSN)),!
	w "SSN: ",!,"  "_pSSN,!
	w "**-----------**",!
	w "View another patient? (y or n): "
	r choice,!
	if choice="y" do
	. g SearchPatient
	else  do
	. g MenuSelection
Exit 
	w "Closing Program.",!
	HALT
KillGlobals
	KILL ^p
	KILL ^s
	w "Globals have been wiped.",!
	g Exit
