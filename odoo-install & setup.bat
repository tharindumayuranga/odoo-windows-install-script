@ECHO OFF
echo ************************************************
echo ************ odoo 15.0 development *************
echo ************************************************
echo.
echo.
echo ************************************************
echo ***** Script created by Tharindu Mayuranga *****
echo ************************************************


echo.

pause

git clone https://github.com/odoo/odoo.git --depth=1 -b 15.0

pip install virtualenv

virtualenv venv


call venv\Scripts\activate.bat 

pip install -r odoo\requirements.txt

pip install pyopenssl==22.0.0

pip install wkhtmltopdf

mkdir conf,custom\addons,.vscode
@echo off

echo.
echo.
echo.
echo.

echo ***************************************
echo ********** configurerations ***********
echo ***************************************

echo.
echo.

Set /p m_pw=Master password:
Set /p db=Database:
Set /p db_user=Database user:
Set /p db_pw=Database user password:
Set /p port=http port:

Set "out=conf"
(

Echo;[options]
Echo;addons_path = odoo\odoo\addons,odoo\addons,custom\addons
Echo;admin_passwd = %m_pw%
Echo;db_host = localhost
Echo;db_maxconn = 64
Echo;db_name = %db%
Echo;db_password = %db_pw%
Echo;db_port = 5432
Echo;db_user = %db_user%
Echo;http_port = %port%
) > "%out%\odoo.conf"


mkdir conf,custom\addons,.vscode


(
Echo;{
Echo;    "version": "0.2.0",
Echo;    "configurations": [
Echo;        {
Echo;            "name": "Python: Odoo15",
Echo;            "type": "python",
Echo;            "request": "launch",
Echo;            "stopOnEntry": false,
Echo;            "python": "${workspaceRoot}\\venv\\Scripts\\python.exe",
Echo;            "console": "integratedTerminal",
Echo;            "program": "${workspaceRoot}\\odoo\\odoo-bin",
Echo;            "args": [
Echo;                "--config=${workspaceRoot}\\conf\\odoo.conf",
Echo;            ],
Echo;            "cwd": "${workspaceRoot}",
Echo;            "env": {},
Echo;            "envFile": "${workspaceRoot}/.env",
Echo;            "redirectOutput": true,
Echo;        }
Echo;    ]
Echo;}
) > ".vscode\launch.json"

echo.
echo.

echo **************************************************
echo ***** To start server double click odoo.bat  *****
echo **************************************************
echo ***** vscode -^> Run -^> Run without debugging *****
echo **************************************************

echo.
echo.

echo *************************************************
echo *************************************************
echo *              Login Details                    *
echo *************************************************
echo *************************************************
echo *     Email      *      admin                   *
echo *************************************************
echo *     Password   *      admin                   *
echo *************************************************

echo.
echo.
echo.
echo.

pause

(
Echo;@echo off
Echo;start "" http://localhost:%port%
Echo;venv\Scripts\python.exe odoo/odoo-bin -c conf\odoo.conf
Echo;pause
)>odoo.bat

call deactivate.bat

start odoo.bat
