-- **Основные конструкции и синтаксис**
-- Упражнение 4.1. Запустите клиент psql и настройте работу с демонстрационной базой данных

-- Упражнение 4.2. Выберите все модели самолетов и соответствующие им диапазоны дальности полетов.
SELECT model ->> 'en' en_model, range
  FROM aircrafts_data;

-- Упражнение 4.3. Найдите все самолеты c максимальной дальностью полета:

SELECT model ->> 'en' en_model, range
  FROM aircrafts_data
 WHERE range = (SELECT MAX(range)
                  FROM aircrafts_data);
-- либо больше 10 000 км, либо меньше 4 000 км;

SELECT model ->> 'en' en_model, range
  FROM aircrafts_data
 WHERE range > 4000
   AND range < 10000;
-- больше 6 000 км, а название не заканчивается на «100».
SELECT model ->> 'en' en_model, range
  FROM aircrafts_data
 WHERE range > 6000
   AND model ->> 'en' NOT LIKE '%100';
-- Обратите внимание на порядок следования предложений WHERE и FROM.
-- Упражнение 4.4. Определите номера и время отправления всех рейсов, прибывших в аэропорт назначения не вовремя.
SELECT departure_airport                                        dep,
       arrival_airport                                          arr,
       flights.actual_arrival::time                             actual,
       flights.scheduled_arrival::time                          sc,
       (flights.actual_arrival::time - scheduled_arrival::time) delta
  FROM flights
 WHERE (flights.actual_arrival::time - scheduled_arrival::time) > '10 min';
-- Упражнение 4.5. Подсчитайте количество отмененных рейсов из аэропорта
-- Пулково (LED), как вылет, так и прибытие которых было назначено на четверг.
SELECT flight_no
  FROM flights
 WHERE (EXTRACT(DOW FROM scheduled_departure) = 3)
   AND (EXTRACT(DOW FROM scheduled_arrival) = 3);
-- **Соединения**
-- Упражнение 4.6. Выведите имена пассажиров, купивших билеты экономкласса за сумму, превышающую 70 000 рублей.

SELECT tickets.passenger_name,
       fare_conditions,
       amount
  FROM tickets
           JOIN bookings.ticket_flights tf ON tickets.ticket_no = tf.ticket_no
 WHERE amount > 70000
   AND fare_conditions = 'Economy'
 ORDER BY amount;

-- Упражнение 4.7. Напечатанный посадочный талон должен содержать фамилию и имя пассажира,
-- коды аэропортов вылета и прилета, дату и время
-- вылета и прилета по расписанию, номер места в салоне самолета.
-- Напишите запрос, выводящий всю необходимую информацию для полученных
-- посадочных талонов на рейсы, которые еще не вылетели.

SELECT passenger_name,
       departure_airport dep,
       arrival_airport arr,
       scheduled_departure::date dep_date,
       scheduled_departure::time dep_time,
       scheduled_arrival::date arr_date,
       scheduled_arrival::time arr_time,
       seat_no

  FROM ticket_flights
           JOIN bookings.tickets t ON t.ticket_no = ticket_flights.ticket_no
           JOIN bookings.flights f ON f.flight_id = ticket_flights.flight_id
           JOIN bookings.boarding_passes bp
                ON ticket_flights.ticket_no = bp.ticket_no AND ticket_flights.flight_id = bp.flight_id;

-- Упражнение 4.8. Некоторые пассажиры, вылетающие сегодняшним рейсом
-- («сегодня» определяется функцией bookings.now), еще не прошли регистрацию, т. е. не получили посадочного талона. Выведите имена этих пассажиров и номера рейсов.
SELECT passenger_name,
       flight_no,
       seat_no
  FROM tickets JOIN bookings.ticket_flights tf
    ON tickets.ticket_no = tf.ticket_no
JOIN bookings.flights f ON f.flight_id = tf.flight_id
LEFT JOIN bookings.boarding_passes bp ON tf.ticket_no = bp.ticket_no AND tf.flight_id = bp.flight_id
WHERE seat_no ISNULL ;

SELECT * FROM tickets;

-- Упражнение 4.9. Выведите номера мест, оставшихся свободными в рейсах из
-- Анапы (AAQ) в Шереметьево (SVO), вместе с номером рейса и его датой.
--
-- **Агрегирование и группировка**
-- Упражнение 4.10. Напишите запрос, возвращающий среднюю стоимость авиабилета из Воронежа (VOZ) в Санкт-Петербург (LED). Поэкспериментируйте с другими агрегирующими функциями (sum, max). Какие еще агрегирующие функции бывают?
-- Упражнение 4.11. Напишите запрос, возвращающий среднюю стоимость авиабилета в каждом из классов перевозки. Модифицируйте его таким образом, чтобы было видно, какому классу какое значение соответствует.
-- Упражнение 4.12. Выведите все модели самолетов вместе с общим количеством мест в салоне.
-- Упражнение 4.13. Напишите запрос, возвращающий список аэропортов, в которых было принято более 500 рейсов.
--
-- **Модификация данных**
-- Упражнение 4.14. Авиакомпания провела модернизацию салонов всех имеющихся самолетов «Сессна» (код CN1), в результате которой был добавлен седьмой ряд кресел. Измените соответствующую таблицу, чтобы отразить
-- этот факт.
-- Упражнение 4.15. В результате еще одной модернизации в самолетах «Аэробус A319» (код 319) ряды кресел с шестого по восьмой были переведены в разряд бизнес-класса. Измените таблицу одним запросом и получите измененные данные с помощью предложения RETURNING.
-- Упражнение 4.16. Создайте новое бронирование текущей датой. В качестве номера бронирования можно взять любую последовательность из шести символов, начинающуюся на символ подчеркивания. Общая сумма должна составлять 30 000 рублей.
-- Создайте электронный билет, связанный с бронированием, на ваше имя.
-- Назначьте электронному билету два рейса: один из Москвы (VKO) во Владивосток (VVO) через неделю, другой — обратно через две недели. Оба рейса выполняются эконом-классом, стоимость каждого должна составлять 15 000 рублей.
--
-- **Описание данных: отношения**
-- Упражнение 4.17. Авиакомпания хочет предоставить пассажирам возможность повышения класса обслуживания уже после покупки билета при регистрации на рейс. За это взимается отдельная плата. Добавьте в демонстрационную базу данных возможность хранения таких операций.
-- Упражнение 4.18. Авиакомпания начинает выдавать пассажирам карточки постоянных клиентов. Вместо того чтобы каждый раз вводить имя, номер документа и контактную информацию, постоянный клиент может указать номер своей карты, к которой привязана вся необходимая информация. При этом клиенту может предоставляться скидка.
-- Измените существующую схему данных так, чтобы иметь возможность
-- хранить информацию о постоянных клиентах.
-- Упражнение 4.19. Постоянные клиенты могут бесплатно провозить с собой животных. Добавьте в ранее созданную таблицу постоянных клиентов информацию о перевозке домашних животных.
--
-- **Вложенные подзапросы**
-- Упражнение 4.20. Найдите модели самолетов «дальнего следования», максимальная продолжительность рейсов которых составила более 6 часов.
-- Упражнение 4.21. Подсчитайте количество рейсов, которые хотя бы раз были
-- задержаны более чем на 4 часа.
-- Упражнение 4.22. Для составления рейтинга аэропортов учитывается суточная пропускная способность, т. е. среднее количество вылетевших из него и
-- прилетевших в него за сутки пассажиров. Выведите 10 аэропортов с наибольшей суточной пропускной  способностью, упорядоченных по убыванию данной величины.