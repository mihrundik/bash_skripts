#!/bin/bash

# количество введенных аргументовв
if [ $# -ne 3 ]; then
    echo "Некорректный запрос"
    exit 1
fi

# переменные
STAND_URL=$1
BROWSER=$2
BROWSER_VERSION=$3
SELENOID_URL="http://localhost:4444/wd/hub"

# файл для результатов от даты запуска
RESULT_FILE="test_results_$(date '+%Y%m%d_%H%M%S').log"

# запуск на maven
echo "Начало тестирования"
echo "Стенд тестирования: $STAND_URL, Браузер: $BROWSER:$BROWSER_VERSION"

mvn clean test \
    -Dselenoid.url=$SELENOID_URL \
    -Dstand.url=$STAND_URL \
    -Dbrowser=$BROWSER \
    -Dbrowser.version=$BROWSER_VERSION \
    > $RESULT_FILE 2>&1

# результат
if [ $? -eq 0 ]; then
    echo "Пройдено успешно" | tee -a $RESULT_FILE
else
    echo "СБОЙ" | tee -a $RESULT_FILE
fi

# результаты тестов
echo "Результат прогона теста"
grep -E "Tests run|FAILURE|SUCCESS" $RESULT_FILE | tail -5

echo "Отчет сохранен в: $RESULT_FILE"