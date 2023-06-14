Main
	w $$GCS("File Reader","MAGENTA"),!
	w "1. Edit a file",!
	w "2. Create a file",!
	w "3. FilePath Menu",!
	w "4. Exit",!
	r "Choice: ",choice,!
	if choice=1 do
	. g EditFile
	if choice=2 do
	. g CreateFile
	if choice=3 do
	. g FolderPath
	if choice=5 do
	. g KillGlobals
	else  do
	. g Exit
FolderPath
	if '$data(^FolderPath) do
	. w "Folder Path has not been set.",!
	. g EnterFolderPath
	w $$GCS("Folder Path Menu","MAGENTA"),!
	w "1. View Folder Path",!
	w "2. Edit Folder Path",!
	w "3. Main Menu",!
	r "Choice: ",choice,!
	if choice=1 do
	. g ViewFolderPath
	if choice=2 do
	. g EnterFolderPath
	else  do
	. g Main
ViewFolderPath
	w "Folder Path: ",$$GCS(^FolderPath,"BLUE"),!
	w "Would you like to change path? (",$$GCS("y","GREEN"),",",$$GCS("n","GREEN"),"): "
	r choice,!
	if choice="y" do
	. g EnterFolderPath
	g FolderPath
EnterFolderPath
	w "Enter new folder path to be saved",", type (",$$GCS("~","RED"),") to stop: ",!
	r path,!
	if path="~" do
	. g Main
	if path'="" do
	. s ^FolderPath=path
	. w "Folder Path: ",$$GCS(^FolderPath,"BLUE"),", successfully saved!",!
	else  do
	. w $$GCS("Faled to save path, returning to Menu","RED"),!
;	. k ^FolderPath
	g Main
EditFile
	w $$GCS("Edit File Menu","MAGENTA"),!
	w "1. Add to file",!
	w "2. Create new file",!
	w "3. View File",!
	w "4. File Path Menu",!
	w "5. Main Menu",!
	r "Choice: ",choice,!
	if choice=1 do
	. g AddToFile
	if choice=2 do
	. g CreateFile
	if choice=3 do
	. g ViewFile
	if choice=4 do
	. g EnterFolderPath
	else  do
	. g Main
AddToFile
	if '$data(^FolderPath) do
	. w "No Folder path set",!
	. g EnterFolderPath
	w "Enter the file name in ",$$GCS(^FolderPath,"BLUE")," to add to: ",!
	r newFile,!
	s fileWPath=^FolderPath_newFile 
	s r=$$AddData(fileWPath,newFile)
	if r=1 do
	. w $$GCS("Write Successful","GREEN"),!
	g Main
CreateFile				
	if '$data(^FolderPath) do
	. w "No Folder path set",!
	. g EnterFolderPath
	w "Enter the new file in ",$$GCS(^FolderPath,"BLUE"),":",!
	r newFile,!
	s fileWPath=^FolderPath_newFile
	open fileWPath:(newversion:wrap:recordsize=512)
	s r=$$AddData(fileWPath,newFile)
	if r=1 do
	. w $$GCS("Write Successful","GREEN"),!
	g Main
ViewFile
	if '$data(^FolderPath) do
	. w "No Folder path set",!
	. g EnterFolderPath
	w "Enter the file to view in ",$$GCS(^FolderPath,"BLUE"),":",!
	r newFile,!
	n line
	s line="-"
	s fileWPath=^FolderPath_newFile
	open fileWPath:(read:wrap:recordsize=512)
	if $test do
	. w "Failed to open file",!
	. g EditFile
	use fileWPath
	for i=1:1 quit:($ZEOF)  do
	. read line
	. s ^lines(i)=line
	. quit:($ZEOF)
	close fileWPath
	write $$GCS("-----START-------","GREEN"),!
	n i
	s i=1
	for i=1:1 quit:'$data(^lines(i))  do
	. quit:'$data(^lines(i))
	. write i,": ",^lines(i),!
	write $$GCS("------END------","RED"),!
	w "Would you like to edit a line? (",$$GCS("y","GREEN"),",",$$GCS("n","GREEN"),"): "
	r choice,!
	if choice="y" do
	. g EditFileLines
	k ^lines
	g EditFile
EditFileLines
	w "Line # to edit ",", type (",$$GCS("~","RED"),") to cancel:"
	r lineNum,!
	if lineNum="~" do
	. k ^lines
	. g EditFile
	s lineToChange=^lines(lineNum)
	w "Line: ",lineToChange,!
	r "New Line: ",line,!
	w "Confirm change? (",$$GCS("y","GREEN"),",",$$GCS("n","GREEN"),"): "
	r choice,!
	if choice="y" do
	. s ^lines(lineNum)=line
	. g UpdateFileLines
	else  do
	. w "Change reverted.",!
	. g EditFile
UpdateFileLines
	w "File: ",fileWPath,!
	s fileWPathUpdate=fileWPath
	open fileWPathUpdate:(write:wrap:recordsize=512)
	use fileWPath
	for i=1:1 quit:'$data(^lines(i))  do
	. quit:'$data(^lines(i)) 
	. write ^lines(i),!
	close fileWPath
	write $$GCS("-----START-------","GREEN"),!
	n i
	s i=1
	for i=1:1 quit:'$data(^lines(i))  do
	. q:'$data(^lines(i))
	. write i,": ",^lines(i),!
	write $$GCS("------END------","RED"),!
	k ^lines
	g EditFile
AddData(fileWPath,newFile)
	n data
	s data=""
	w "Enter new data into: ",$$GCS(newFile,"BLUE"),", type (",$$GCS("~","RED"),") to stop.",!
	for  quit:data="~"  do 
	. open fileWPath:(append:wrap:recordsize=512)	
	. r data,!
	. if data="~" do
	. . w "Closing file, returning to Menu",!
	. else  do
	. . use fileWPath
	. . write data,!
	. . if $test do
	. . . w $$GCS("Data Added Successfully","GREEN"),!
	. close fileWPath
	q $test
GCS(string,color)
	q $CHAR(27)_^CC(color)_string_$CHAR(27)_^CC("END")
Exit
	w $$GCS("Closing Program","RED"),!
	H
	;	
KillGlobals
	k ^FolderPath
	k ^lines
	w "Globals have been deleted.",!
	H
	;
