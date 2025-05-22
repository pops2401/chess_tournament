-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: mysql
-- Время создания: Май 22 2025 г., 11:11
-- Версия сервера: 8.0.29
-- Версия PHP: 8.0.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `ais_chernov9066_chernov`
--

-- --------------------------------------------------------

--
-- Структура таблицы `board_square`
--

CREATE TABLE `board_square` (
  `id` int NOT NULL COMMENT 'Уникальный идентификатор клетки',
  `letter` char(1) NOT NULL COMMENT 'Координата по букве (A–H)',
  `number` tinyint NOT NULL COMMENT 'Координата по цифре (1–8)',
  `color` tinyint(1) NOT NULL COMMENT 'Цвет поля: 1 — белое, 0 — черное'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица клеток шахматной доски';

--
-- Дамп данных таблицы `board_square`
--

INSERT INTO `board_square` (`id`, `letter`, `number`, `color`) VALUES
(1, 'A', 1, 0),
(2, 'B', 1, 1),
(3, 'C', 1, 0),
(4, 'D', 1, 1),
(5, 'E', 1, 0),
(6, 'F', 1, 1),
(7, 'G', 1, 0),
(8, 'H', 1, 1),
(9, 'A', 2, 1),
(10, 'B', 2, 0),
(11, 'C', 2, 1),
(12, 'D', 2, 0),
(13, 'E', 2, 1),
(14, 'F', 2, 0),
(15, 'G', 2, 1),
(16, 'H', 2, 0),
(17, 'A', 4, 1),
(18, 'B', 4, 0),
(19, 'C', 4, 1),
(20, 'D', 4, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `game`
--

CREATE TABLE `game` (
  `id` int NOT NULL COMMENT 'Уникальный идентификатор партии',
  `white_player_name` varchar(100) NOT NULL COMMENT 'Имя игрока, играющего белыми',
  `black_player_name` varchar(100) NOT NULL COMMENT 'Имя игрока, играющего черными',
  `start_datetime` datetime NOT NULL COMMENT 'Дата и время начала партии'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица шахматных партий';

--
-- Дамп данных таблицы `game`
--

INSERT INTO `game` (`id`, `white_player_name`, `black_player_name`, `start_datetime`) VALUES
(1, 'Иванов И.И.', 'Петров П.П.', '2024-05-01 14:00:00'),
(2, 'Сидоров С.С.', 'Николаев Н.Н.', '2024-05-02 16:00:00'),
(3, 'Карпов А.А.', 'Каспаров Г.Г.', '2024-05-03 12:00:00');

-- --------------------------------------------------------

--
-- Структура таблицы `move`
--

CREATE TABLE `move` (
  `id` int NOT NULL COMMENT 'Уникальный идентификатор хода',
  `game_id` int NOT NULL COMMENT 'ID партии',
  `from_square_id` int NOT NULL COMMENT 'ID клетки, откуда сделан ход',
  `to_square_id` int NOT NULL COMMENT 'ID клетки, куда сделан ход',
  `color` tinyint(1) NOT NULL COMMENT 'Цвет фигуры, совершившей ход (1 — белые, 0 — черные)',
  `seconds_from_start` int NOT NULL COMMENT 'Время от начала партии в секундах'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица ходов в шахматной партии';

--
-- Дамп данных таблицы `move`
--

INSERT INTO `move` (`id`, `game_id`, `from_square_id`, `to_square_id`, `color`, `seconds_from_start`) VALUES
(1, 1, 1, 9, 1, 60),
(2, 1, 9, 17, 0, 120),
(3, 2, 2, 10, 1, 45),
(4, 2, 10, 18, 0, 100),
(5, 3, 3, 11, 1, 30),
(6, 3, 11, 19, 0, 90),
(7, 1, 17, 1, 1, 180),
(8, 2, 18, 2, 1, 160),
(9, 3, 19, 3, 1, 150);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `board_square`
--
ALTER TABLE `board_square`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `move`
--
ALTER TABLE `move`
  ADD PRIMARY KEY (`id`),
  ADD KEY `game_id` (`game_id`),
  ADD KEY `from_square_id` (`from_square_id`),
  ADD KEY `to_square_id` (`to_square_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `board_square`
--
ALTER TABLE `board_square`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор клетки', AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `game`
--
ALTER TABLE `game`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор партии', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `move`
--
ALTER TABLE `move`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT 'Уникальный идентификатор хода', AUTO_INCREMENT=10;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `move`
--
ALTER TABLE `move`
  ADD CONSTRAINT `move_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `game` (`id`),
  ADD CONSTRAINT `move_ibfk_2` FOREIGN KEY (`from_square_id`) REFERENCES `board_square` (`id`),
  ADD CONSTRAINT `move_ibfk_3` FOREIGN KEY (`to_square_id`) REFERENCES `board_square` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
