# The Long Dark - autosave (Powershell)

#################################################
####                                       ######
####   Select and Run Appropriate Block    ######
####                                       ###### 
#################################################

#Every time when the source file changed the script run action block with copy file plus additional timstamp to user's backup directory  


##0. Run Once - prerequisites

install-Module -Name FSWatcherEngineEvent



##1. Before Start Game edit appropriate path to steam directory and backup files directory

# Custom Variables 
    $sourcedir = 'C:\Users\Admin\AppData\Local\Hinterland\TheLongDark\Survival\'
    $sourecfilename = 'sandbox1'    
    $destpath   = 'D:\1\autosave\'

    $sourcepath = $sourcedir + $sourecfilename

    $sb = {Copy-Item -Path $sourcepath -Destination ($destpath + $sourecfilename + '_'+ (Get-Date -f dd.MM_HH-mm-ss))}

    Register-EngineEvent -SourceIdentifier "MyEvent" -Action $sb
    New-FileSystemWatcher -SourceIdentifier "MyEvent" -Path $sourcedir -NotifyFilter LastWrite -Filter $sourecfilename


##2. After End Game
 
    Remove-FileSystemWatcher -SourceIdentifier MyEvent
    Get-EventSubscriber| Unregister-Event
 


##3. Restore (run appropriate string or copy file to source directory manually)

# Custom Variables run before restore
    $sourcedir = 'C:\Users\Admin\AppData\Local\Hinterland\TheLongDark\Survival\'
    $sourecfilename = 'sandbox1'    
    $destpath   = 'D:\1\autosave\'
    $sourcepath = $sourcedir + $sourecfilename

#List Backup Directory files (check modified timestamp)
Get-ChildItem -Path $destpath
Get-ChildItem -Path $sourcedir    

#Restore Last Backup
Get-ChildItem -Path $destpath|sort -Descending lastaccesstime|select -First 1|Copy-Item -Destination $sourcepath

#Restore Previous Backup 
Get-ChildItem -Path $destpath|sort -Descending lastaccesstime|select -Skip 1|select -First 1|Copy-Item -Destination $sourcepath

#Restore file with number from the end
$num = 6
Get-ChildItem -Path $destpath|sort -Descending lastaccesstime|select -Skip $num|select -First 1|Copy-Item -Destination $sourcepath


