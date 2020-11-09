::: Скачивание Configuration Manager 
wget -O cm.exe --no-check-certificate https://github.com/aerokube/cm/releases/download/1.7.2/cm_windows_amd64.exe

::: Скачивание и запуск selenoid
cm.exe selenoid start –-vnc
::: Скачивание и запуск selenoid-ui
cm.exe selenoid-ui start

::: Обновление/скачивание браузеров
docker pull selenoid/vnc_chrome:86.0
docker pull selenoid/vnc_firefox:81.0

::: Проверка запущеных образов
docker ps

::: Запуск тестов (path/to/mvn/project/apiHelperExample путь к проекту на винде)
cd path/to/mvn/project/apiHelperExample & mvn clean test

::: Остановить selenoid и selenoid-ui
cm.exe selenoid-ui stop
cm.exe selenoid stop
