#Powershell script for Task Scheduler 

# Edit Custom Variables for source and destination directories before start 
    $sourcedir = 'C:\Users\*username*\AppData\Local\Hinterland\TheLongDark\Survival\'
    $sourcefilename = 'sandbox1'    
    $destpath   = 'C:\Backup\autosave\'
#    
    $sourcepath = $sourcedir + $sourecfilename

    $sb = {Copy-Item -Path $sourcepath -Destination ($destpath + $sourcefilename + '_'+ (Get-Date -f dd.MM_HH-mm-ss))}

    Register-EngineEvent -SourceIdentifier "MyEvent" -Action $sb
    New-FileSystemWatcher -SourceIdentifier "MyEvent" -Path $sourcedir -NotifyFilter LastWrite -Filter $sourecfilename

#while ($true) {sleep 1}
