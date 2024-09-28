@echo off
setlocal enabledelayedexpansion
REM Function to generate a random hex digit (0-F)
set hex=0123456789ABCDEF










REM Check for admin rights
openfiles >nul 2>&1
if %errorlevel% neq 0 (
echo ERROR 401: Not runned as admin
pause
exit /b 1
)






REM Prompt for destination drive
set /p destDrive="Enter the destination drive letter (e.g., C, D, E): "

REM Prompt for folder path
set /p folderPath="Enter the folder path within the destination drive (e.g., SG4): "

REM Prompt for folder name
set /p folderName="Enter a name for the folder: "

REM Construct the full directory path
set finalDir=%destDrive%:\%folderPath%\%folderName%






REM Generate random color for background and text
:_get_random_color
set /A rndBg=%random% %% 16
set /A rndText=%random% %% 16


REM Ensure the background and text colors are not the same
if %rndBg%==%rndText% goto _get_random_color







REM Convert random numbers to hex
set bgColor=!hex:~%rndBg%,1!
set textColor=!hex:~%rndText%,1!




REM Ensure black text on black background doesn't happen
if "!bgColor!!textColor!"=="00" goto _get_random_color

REM Set the color
color !bgColor!!textColor!



REM The header of the script
echo [ TXTFILE GENERATOR ]
echo.

REM Prompt for directory
set /p destDir="Enter the full destination directory path: "

REM Prompt to confirm the directory
echo DESTINATION DIRECTORY %destDir%
set /p confirmDir="IS THIS DIRECTORY OKAY? (Y/N): "

REM Check user confirmation
if /i not "%confirmDir%"=="Y" (
echo Installation cancelled by user.
pause
exit /b
)

REM Create the destination directory if it doesn't exist
if not exist "%destDir%" (
mkdir "%destDir%"
echo Folder %destDir% created.
) else (
echo Directory already exists.
)



REM Custom Watermark input
set /p customWaterMark="Enter a custom Watermark (e.g., Writted with SMDir): "




REM Prompt for the letter to include in the text file
set /p folderLetter="Enter a letter to include in the text file: "

REM Prompt for the text file name
set /p txtFileName="Enter the name of the text file (without extension): "

REM Create a text file in the destination directory
set textFilePath="%destDir%\%txtFileName%.txt"

REM Write the letter to the text file
echo %customWaterMark% > %textFilePath%
echo %folderLetter% > %textFilePath%
echo Text file created at %textFilePath%.
 powershell -c "[console]::beep(500,700)"
echo Installation completed!
pause