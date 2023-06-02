Main
	w "File Reader",!
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
	else  do
	. g Exit
FolderPath
	if '$data(^FolderPath) do
	. w "Folder Path has not been set.",!
	. g EnterFolderPath
	w "FolderPath Menu",!
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
	w "Folder Path: ",^FolderPath,!
	r "Would you like to change path? (y,n): ",choice,!
	if choice="y" do
	. g EnterFolderPath
	g FolderPath
EnterFolderPath
	r "Enter new folder path to be saved: ",^FolderPath,!
	if $test do
	. w "Folder Path: ",^FolderPath,", successfully saved!",!
	else  do
	. w "Faled to save path, returning to Menu"
	g Main
EditFile
	w "Edit File Menu",!
	w "1. Add to file",!
	w "2. Create new file",!
	w "3. Analyze file",!
	w "4. File Path Menu",!
	w "5. Main Menu",!
	r "Choice: ",choice,!
	if choice=1 do
	. g AddToFile
	if choice=2 do
	. g CreateFile
	if choice=3 do
	. g AnalyzeFile
	if choice=4 do
	. g EnterFolderPath
	else  do
	. g Main
AddToFile
	s data=""
	w "Enter new data into: ",file,", type (~) to stop.",!
	for  quit:data="~"  do 
	. open fileWPath:(append:wrap:recordsize=512)	
	. r data,!
	. if data="~" do
	. . w "Closing file, returning to Menu",!
	. else  do
	. . use fileWPath
	. . write data,!
	. . if $test do
	. . . w "Data added.",!
	. close fileWPath
	g Main
CreateFile
	s file="/home/vboxuser/Desktop/mumpscode/newText.txt"
	open file:(newversion:fixed:recordsize=512)
	use file
	write "Hello",!
	close file
	write "Done creating",!
	g Main
Exit
	w "Closing Program",!
	HALT
	;	
