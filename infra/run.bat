::: ���������� Configuration Manager 
wget -O cm.exe --no-check-certificate https://github.com/aerokube/cm/releases/download/1.7.2/cm_windows_amd64.exe

::: ���������� � ������ selenoid
cm.exe selenoid start �-vnc
::: ���������� � ������ selenoid-ui
cm.exe selenoid-ui start

::: ����������/���������� ���������
docker pull selenoid/vnc_chrome:86.0
docker pull selenoid/vnc_firefox:81.0

::: �������� ��������� �������
docker ps

::: ������ ������ (path/to/mvn/project/apiHelperExample ���� � ������� �� �����)
cd path/to/mvn/project/apiHelperExample & mvn clean test

::: ���������� selenoid � selenoid-ui
cm.exe selenoid-ui stop
cm.exe selenoid stop
