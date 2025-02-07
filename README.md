# The Long Dark - autosave (Powershell)
                                    
![Screenshot](/main.jpg)  
 
Every time when the source file changed, the script runs action block with copying savefile with additional timestamp in the filename to user defined backup directory  

You have two option for running script:
1. Run code at Powershell ISE.
   
   Select and Run Appropriate Block with F8 
2. Create autosave task 

   Save block #1 to .ps1 file or get autosave.ps1 from repo. 
 
   Create autosave Task in "Task Scheduler Library" with properties below:
   
    Program/script: powershell.exe
   
    Add arguments (optional): -ExecutionPolicy Bypass -NonInteractive -WindowStyle Hidden -Noexit -Nologo -File "C:\youpath\autosave.ps1"
   
    P.S. If you have an issue with -Noexit key try to uncomment the last string with - while ($true) {sleep 1}

Source filename can be different "sandbox" or "challenge" with number. You can check it from your steam save directory C:\Users\*username*\AppData\Local\Hinterland\TheLongDark\Survival\



## 0. Run Once - prerequisites
Install "FSWatcherEngineEvent" powershell module first
```
install-Module -Name FSWatcherEngineEvent
```

## 1. Before Starting Game edit appropriate paths to steam directory and backup files directory
```
# Custom Variables 
    $sourcedir = 'C:\Users\*username*\AppData\Local\Hinterland\TheLongDark\Survival\'
    $sourcefilename = 'sandbox1'    
    $destpath   = 'C:\Backup\autosave\'
    $sourcepath = $sourcedir + $sourcefilename

    $sb = {Copy-Item -Path $sourcepath -Destination ($destpath + $sourcefilename + '_'+ (Get-Date -f dd.MM_HH-mm-ss))}

    Register-EngineEvent -SourceIdentifier "MyEvent" -Action $sb
    New-FileSystemWatcher -SourceIdentifier "MyEvent" -Path $sourcedir -NotifyFilter LastWrite -Filter $sourcefilename
```

## 2. After End Game (optional)
If you want to clear Event Watcher immediately
``` 
    Remove-FileSystemWatcher -SourceIdentifier MyEvent
    Get-EventSubscriber| Unregister-Event
``` 


## 3. Restore (run appropriate string or copy file to source directory manually)
```
# Custom Variables run before restore
    $sourcedir = 'C:\Users\*username*\AppData\Local\Hinterland\TheLongDark\Survival\'
    $sourcefilename = 'sandbox1'    
    $destpath   = 'C:\Backup\autosave\'
    $sourcepath = $sourcedir + $sourcefilename
```
#List Source and Backup Directory files (check modified timestamp)
```
Get-ChildItem -Path $destpath
Get-ChildItem -Path $sourcedir    
```
#Restore Last Backup
```
Get-ChildItem -Path $destpath|sort -Descending lastaccesstime|select -First 1|Copy-Item -Destination $sourcepath
```
#Restore Previous Backup 
```
Get-ChildItem -Path $destpath|sort -Descending lastaccesstime|select -Skip 1|select -First 1|Copy-Item -Destination $sourcepath
```
#Restore file with number from the end
```
$num = 6
Get-ChildItem -Path $destpath|sort -Descending lastaccesstime|select -Skip $num|select -First 1|Copy-Item -Destination $sourcepath
```

