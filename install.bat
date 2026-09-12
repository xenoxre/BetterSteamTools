@echo off
setlocal EnableDelayedExpansion

cd /d "%~dp0"

echo ============================================
echo BetterSteamTools - Installation Build Tools
echo ============================================
echo.

REM ------------------------------------------------
REM Verification de winget
REM ------------------------------------------------
where winget >nul 2>nul
if errorlevel 1 (
echo [ERROR] winget est introuvable.
echo.
echo Installe "App Installer" depuis le Microsoft Store,
echo puis relance ce script.
pause
exit /b 1
)

echo [INFO] Verification des outils...
echo.

REM ------------------------------------------------
REM CMake
REM ------------------------------------------------
where cmake >nul 2>nul
if errorlevel 1 (
echo [INSTALL] CMake...
winget install --id Kitware.CMake --exact --accept-source-agreements --accept-package-agreements
) else (
echo [OK] CMake deja installe.
)

REM ------------------------------------------------
REM Git
REM ------------------------------------------------
where git >nul 2>nul
if errorlevel 1 (
echo [INSTALL] Git...
winget install --id Git.Git --exact --accept-source-agreements --accept-package-agreements
) else (
echo [OK] Git deja installe.
)

REM ------------------------------------------------
REM MinGW / GCC
REM ------------------------------------------------
where g++ >nul 2>nul
if errorlevel 1 (
echo.
echo [INSTALL] MinGW/GCC...
echo.
echo Installation de MinGW via winget...

winget search mingw

echo.
echo Si plusieurs resultats apparaissent, installe une distribution
echo MinGW compatible x86_64.
echo.

winget install --id BrechtSanders.winlibs --exact --accept-source-agreements --accept-package-agreements


) else (
echo [OK] g++ deja installe.
)

echo.
echo ============================================
echo Verification finale
echo ============================================
echo.

REM ------------------------------------------------
REM Rafraichissement PATH pour cette session
REM ------------------------------------------------
set "PATH=%PATH%;C:\Program Files\CMake\bin;C:\Program Files\Git\cmd;C:\mingw64\bin"

where cmake >nul 2>nul
if errorlevel 1 (
echo [WARNING] CMake introuvable dans le PATH actuel.
) else (
echo [OK] CMake:
cmake --version | findstr /C:"cmake version"
)

where git >nul 2>nul
if errorlevel 1 (
echo [WARNING] Git introuvable dans le PATH actuel.
) else (
echo [OK] Git:
git --version
)

where g++ >nul 2>nul
if errorlevel 1 (
echo [WARNING] g++ introuvable dans le PATH actuel.
) else (
echo [OK] g++:
g++ --version | findstr /C:"g++"
)

where mingw32-make >nul 2>nul
if errorlevel 1 (
echo [WARNING] mingw32-make introuvable dans le PATH actuel.
) else (
echo [OK] mingw32-make:
mingw32-make --version | findstr /C:"GNU Make"
)

echo.
echo ============================================
echo Installation terminee
echo ============================================
echo.
echo Ferme puis rouvre ton terminal si tu viens
echo d'installer de nouveaux outils.
echo.
pause
exit /b 0
