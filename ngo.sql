-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 22, 2021 at 11:52 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ngo`
--

-- --------------------------------------------------------

--
-- Table structure for table `donors`
--

CREATE TABLE `donors` (
  `did` int(11) NOT NULL,
  `bank` varchar(50) NOT NULL,
  `ifsc_code` varchar(50) NOT NULL,
  `account` varchar(100) NOT NULL,
  `amount` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `donors`
--

INSERT INTO `donors` (`did`, `bank`, `ifsc_code`, `account`, `amount`) VALUES
(1, 'canara', 'cnrb0000789', '012345678', 200),
(2, 'axis', 'axis7866409', '9876543210', 1000),
(3, 'federal', 'fdrl777098', '8765432109', 500),
(4, 'kotak', 'kotk7890876', '7890123456', 780),
(5, 'sbi', 'sbib7123456', '6758490321', 610);

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

CREATE TABLE `tasks` (
  `tid` int(11) NOT NULL,
  `task_description` varchar(100) NOT NULL,
  `task_leader` varchar(50) NOT NULL,
  `task_assigned_on` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tasks`
--

INSERT INTO `tasks` (`tid`, `task_description`, `task_leader`, `task_assigned_on`) VALUES
(1, 'Help serving food', 'Shah', '2022-10-11'),
(2, 'Stockpile clothes', 'Ritu', '2022-11-11'),
(3, 'Help in cleaning Slums', 'Danish', '2022-08-19'),
(4, 'Gather medical aid', 'Sania', '2022-12-30'),
(5, 'Help building shelters', 'Abul', '2022-06-23');

-- --------------------------------------------------------
--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `iid` int(11) NOT NULL,
  `item_name` varchar(50) NOT NULL,
  `quantity` varchar(150) NOT NULL,
  `pickup_adrs` varchar(150) NOT NULL,
  `phone_no` varchar(20) NOT NULL,
  `donation_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`iid`, `item_name`, `quantity`, `pickup_adrs`, `phone_no`, `donation_date`) VALUES
(1, 'Clothes', '5 Shirts', 'BTM, Bangalore', '9897459836', '2022-12-13'),
(2, 'Ration', '5kg Rice', 'Jigani, Bangalore', '7896734892', '2022-09-03'),
(3, 'Furniture', '3 Study tables', 'E-City, Bangalore', '8310327609', '2022-11-10'),
(4, 'Clothes', '5 Kurtis', 'E-City, Bangalore', '8310864831', '2022-12-03'),
(5, 'furniture', '2 Cupboards', 'MG-Road, Bangalore', '8310327834', '2022-05-10'),
(6, 'Blankets', '6 Blankets', 'King Koti, Hyderabad', '8678927609', '2022-04-19'),
(7, 'Ration', '10kg Wheat', 'Fort Road, Bidar', '8320837609', '2022-06-29'),
(8, 'Water', '20 Litres', 'BTM, Bangalore', '9421327609', '2022-11-10');


-- --------------------------------------------------------
--
-- Table structure for table `volunteer`
--

CREATE TABLE `volunteer` (
  `vid` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_no` varchar(20) NOT NULL,
  `age` int(10) NOT NULL,
  `occupation` varchar(100) NOT NULL,
  `doj` DATE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `volunteer`
--

INSERT INTO `volunteer` (`vid`, `name`, `email`, `phone_no`, `age`, `occupation`, `doj`) VALUES
(1, 'Shah', 'shah@gmail.com', '9897419836', 20, 'Cloud Architect', '2022-12-10'),
(2, 'Ritu', 'ritu@gmail.com', '7896734292', 21, 'Journalist', '2022-12-12'),
(3, 'Sania', 'sania@gmail.com', '8310327609', 21, 'Asst. Doctor', '2022-11-21'),
(4, 'Danish', 'danish@gmail.com', '8310789889', 21, 'Archaeologist', '2022-11-11'),
(5, 'Shrithan', 'shrithan@gmail.com', '8347327678', 19, 'Full Stack Developer', '2022-10-16'),
(6, 'Tanveer', 'tanveer@gmail.com', '8309827602', 24, 'Entrepreneur', '2023-02-11'),
(7, 'Thrikuta', 'thrikuta@gmail.com', '8486129989', 23, 'Software Engineer', '2023-01-21'),
(8, 'Darshan', 'darshan@gmail.com', '9985327609', 23, 'Businessman', '2023-01-04'),
(9, 'Abul', 'abul@gmail.com', '8310227609', 20, 'Graphic Designer', '2023-01-06');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `usertype` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `usertype`, `email`, `password`) VALUES
(11, 'Danish', 'Donor', 'danish@gmail.com', 'pbkdf2:sha256:150000$xAKZCiJG$4c7a7e704708f86659d730565ff92e8327b01be5c49a6b1ef8afdf1c531fa5c3'),
(12, 'Uzair', 'Volunteer', 'uzair@gmail.com', 'pbkdf2:sha256:150000$Yf51ilDC$028cff81a536ed9d477f9e45efcd9e53a9717d0ab5171d75334c397716d581b8'),
(13, 'Afrah', 'Volunteer', 'afrah@gmail.com', 'pbkdf2:sha256:150000$BeSHeRKV$a8b27379ce9b2499d4caef21d9d387260b3e4ba9f7311168b6e180a00db91f22');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `donors`
--
ALTER TABLE `donors`
  ADD PRIMARY KEY (`did`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`iid`);

--
-- Indexes for table `volunteer`
--
ALTER TABLE `volunteer`
  ADD PRIMARY KEY (`vid`);

--
-- Indexes for table `tasks`
--
ALTER TABLE `tasks`
  ADD PRIMARY KEY (`tid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `donors`
--
ALTER TABLE `donors`
  MODIFY `did` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `iid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `volunteer`
--
ALTER TABLE `volunteer`
  MODIFY `vid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tasks`
--
ALTER TABLE `tasks`
  MODIFY `tid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
