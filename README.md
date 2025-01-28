# thelongdark autosave

#################################################
####                                       ######
####  Select and Run Appropriate Block     ######
####                                       ###### 
#################################################



#0. Run Once - prerequisites

install-Module -Name FSWatcherEngineEvent



#1. Before Start Game edit appropriate path to steam directory and backup files directory

## Custom Variables 
    $sourcedir = 'C:\Users\Admin\AppData\Local\Hinterland\TheLongDark\Survival\'
    $sourecfilename = 'sandbox1'    
    $destpath   = 'D:\1\autosave\'
##
    $sourcepath = $sourcedir + $sourecfilename

    $sb = {Copy-Item -Path $sourcepath -Destination ($destpath + $sourecfilename + '_'+ (Get-Date -f dd.MM_HH-mm-ss))}

    Register-EngineEvent -SourceIdentifier "MyEvent" -Action $sb
    New-FileSystemWatcher -SourceIdentifier "MyEvent" -Path $sourcedir -NotifyFilter LastWrite -Filter $sourecfilename


#2. After End Game
 
    Remove-FileSystemWatcher -SourceIdentifier MyEvent
    Get-EventSubscriber| Unregister-Event
 


#3. Restore Last Save

#Get-ChildItem -Path $destpath|sort -Descending lastaccesstime|select -First 1|Copy-Item -Destination $sourcepath
#Get-ChildItem -Path $destpath|sort -Descending lastaccesstime|select -Skip 1|Copy-Item -Destination $sourcepath
#Get-ChildItem -Path $sourcedir
