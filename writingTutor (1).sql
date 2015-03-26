-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 24, 2015 at 01:48 PM
-- Server version: 5.6.16
-- PHP Version: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `writingTutor`
--

-- --------------------------------------------------------

--
-- Table structure for table `essays`
--

CREATE TABLE IF NOT EXISTS `essays` (
  `essay_id` int(11) NOT NULL AUTO_INCREMENT,
  `essay_name` varchar(255) DEFAULT NULL,
  `essay_description` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`essay_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `essays`
--

INSERT INTO `essays` (`essay_id`, `essay_name`, `essay_description`) VALUES
(1, 'hg mhg', 'None...'),
(2, 'Hello', 'None...'),
(3, 'Hello', 'None...'),
(4, 'Hello', 'None...'),
(5, 'Hello', 'None...'),
(6, 'Hello', 'None...'),
(7, 'Hello', 'None...'),
(8, 'Hello', 'None...'),
(9, 'Good morning', 'None...'),
(10, 'Laughter', 'None...'),
(11, 'Laughter', 'None...');

-- --------------------------------------------------------

--
-- Table structure for table `misused_words`
--

CREATE TABLE IF NOT EXISTS `misused_words` (
  `misused_word_id` int(11) NOT NULL AUTO_INCREMENT,
  `misused_word_name` varchar(255) DEFAULT NULL,
  `misused_word_description` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`misused_word_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `paragraphs`
--

CREATE TABLE IF NOT EXISTS `paragraphs` (
  `paragraph_id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_essay_id` int(11) DEFAULT NULL,
  `paragraph_number` int(11) DEFAULT NULL,
  `paragraph_comment` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`paragraph_id`),
  KEY `fk_essay_id` (`fk_essay_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `paragraphs`
--

INSERT INTO `paragraphs` (`paragraph_id`, `fk_essay_id`, `paragraph_number`, `paragraph_comment`) VALUES
(1, 1, 1, 'Lovely paragraph'),
(2, 1, 2, 'Lovely paragraph'),
(3, 1, 3, 'Lovely paragraph'),
(4, 2, 1, 'Lovely paragraph'),
(5, 3, 1, 'Lovely paragraph'),
(6, 4, 1, 'Lovely paragraph'),
(7, 5, 1, 'Lovely paragraph'),
(8, 6, 1, 'Lovely paragraph'),
(9, 7, 1, 'Lovely paragraph'),
(10, 8, 1, 'Lovely paragraph'),
(11, 9, 1, 'Lovely paragraph'),
(12, 10, 1, 'Lovely paragraph'),
(13, 11, 1, 'Lovely paragraph');

-- --------------------------------------------------------

--
-- Table structure for table `sentences`
--

CREATE TABLE IF NOT EXISTS `sentences` (
  `sentence_id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_paragraph_id` int(11) DEFAULT NULL,
  `sentence_number` int(11) DEFAULT NULL,
  `sentence` text NOT NULL,
  `tags` text NOT NULL,
  `total_words` int(11) NOT NULL,
  `sentence_quality` int(2) NOT NULL,
  `sentence_comment` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`sentence_id`),
  KEY `fk_paragraph_id` (`fk_paragraph_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=35 ;

--
-- Dumping data for table `sentences`
--

INSERT INTO `sentences` (`sentence_id`, `fk_paragraph_id`, `sentence_number`, `sentence`, `tags`, `total_words`, `sentence_quality`, `sentence_comment`) VALUES
(1, 1, 1, 'I feel sick.', '', 0, 0, 'Lovely sentence'),
(2, 1, 2, 'I&#8217;m nervous and my stomach&#8217;s turning.', '', 0, 0, 'Lovely sentence'),
(3, 1, 3, 'The room is lined with neat rows of desks, each one occupied by another kid my age.', '', 0, 0, 'Lovely sentence'),
(4, 1, 4, 'We&#8217;re all about to take the SATs.', '', 0, 0, 'Lovely sentence'),
(5, 1, 5, 'The proctor has instructed us to fill out section four: &#8220;race.&#8221;\n', '', 0, 0, 'Lovely sentence'),
(6, 2, 1, 'I cannot be placed neatly into a single racial category, although I&#8217;m sure that people walking down the street don&#8217;t hesitate to label me &#8220;caucasian.&#8221; Never in my life has a stranger not been surprised when I told them I was half black.\n', '', 0, 0, 'Lovely sentence'),
(7, 3, 1, 'Having light skin, eyes, and hair, but being black and white often leaves me misperceived.', '', 0, 0, 'Lovely sentence'),
(8, 3, 2, 'Do I wish that my skin were darker so that when I tell people I&#8217;m black they won&#8217;t laugh at me?', '', 0, 0, 'Lovely sentence'),
(9, 3, 3, 'No, I accept and value who I am.', '', 0, 0, 'Lovely sentence'),
(10, 3, 4, 'To me, being black is more than having brown skin; it&#8217;s having ancestors who were enslaved, a grandfather who managed one of the nation&#8217;s oldest black newspapers, the Chicago Daily Defender, and a family who is as proud of their heritage as I am.', '', 0, 0, 'Lovely sentence'),
(11, 3, 5, 'I prove that one cannot always discern another&#8217;s race by his or her appearance.', '', 0, 0, 'Lovely sentence'),
(12, 7, 1, '(''home'', ''NN'')', 'NN', 0, 0, 'Lovely sentence'),
(13, 8, 1, '(''?'', ''.'')', 'WRB', 0, 0, 'Lovely sentence'),
(14, 9, 1, 'How are you leaving?', 'WRB', 0, 0, 'Lovely sentence'),
(15, 9, 2, 'How are you leaving?', 'VBP', 0, 0, 'Lovely sentence'),
(16, 9, 3, 'How are you leaving?', 'PRP', 0, 0, 'Lovely sentence'),
(17, 9, 4, 'How are you leaving?', 'VBG', 0, 0, 'Lovely sentence'),
(18, 9, 5, 'How are you leaving?', '.', 0, 0, 'Lovely sentence'),
(19, 10, 1, 'It is a great thing to be alive.', '[''PRP'']', 0, 0, 'Lovely sentence'),
(20, 10, 2, 'It is a great thing to be alive.', '[''PRP'', ''VBZ'']', 0, 0, 'Lovely sentence'),
(21, 10, 3, 'It is a great thing to be alive.', '[''PRP'', ''VBZ'', ''DT'']', 0, 0, 'Lovely sentence'),
(22, 10, 4, 'It is a great thing to be alive.', '[''PRP'', ''VBZ'', ''DT'', ''JJ'']', 0, 0, 'Lovely sentence'),
(23, 10, 5, 'It is a great thing to be alive.', '[''PRP'', ''VBZ'', ''DT'', ''JJ'', ''NN'']', 0, 0, 'Lovely sentence'),
(24, 10, 6, 'It is a great thing to be alive.', '[''PRP'', ''VBZ'', ''DT'', ''JJ'', ''NN'', ''TO'']', 0, 0, 'Lovely sentence'),
(25, 10, 7, 'It is a great thing to be alive.', '[''PRP'', ''VBZ'', ''DT'', ''JJ'', ''NN'', ''TO'', ''VB'']', 0, 0, 'Lovely sentence'),
(26, 10, 8, 'It is a great thing to be alive.', '[''PRP'', ''VBZ'', ''DT'', ''JJ'', ''NN'', ''TO'', ''VB'', ''JJ'']', 0, 0, 'Lovely sentence'),
(27, 10, 9, 'It is a great thing to be alive.', '[''PRP'', ''VBZ'', ''DT'', ''JJ'', ''NN'', ''TO'', ''VB'', ''JJ'', ''.'']', 0, 0, 'Lovely sentence'),
(28, 11, 1, 'I have called them.', '[''PRP'']', 0, 0, 'Lovely sentence'),
(29, 11, 2, 'I have called them.', '[''PRP'', ''VBP'']', 0, 0, 'Lovely sentence'),
(30, 11, 3, 'I have called them.', '[''PRP'', ''VBP'', ''VBN'']', 0, 0, 'Lovely sentence'),
(31, 11, 4, 'I have called them.', '[''PRP'', ''VBP'', ''VBN'', ''PRP'']', 0, 0, 'Lovely sentence'),
(32, 11, 5, 'I have called them.', '[''PRP'', ''VBP'', ''VBN'', ''PRP'', ''.'']', 0, 0, 'Lovely sentence'),
(33, 12, 1, 'Who are you?', '[''WP'', ''VBP'', ''PRP'', ''.'']', 0, 0, 'Lovely sentence'),
(34, 13, 1, 'This is really funny.', '[''DT'', ''VBZ'', ''RB'', ''JJ'', ''.'']', 5, 0, 'Lovely sentence');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `user_password` varchar(128) DEFAULT NULL,
  `fk_user_type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_user_type_id` (`fk_user_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `firstname`, `lastname`, `username`, `user_password`, `fk_user_type_id`) VALUES
(1, 'Joyce', 'Amoafo', 'jamoafo', '19053d1f43416ad98dd9443425753488', 1),
(2, 'Henry', 'Djokoto', 'hdjokoto', '027e4180beedb29744413a7ea6b84a42', 2),
(3, 'Georgina', 'Kpo', 'gkpo', '0d0b0b97abeb56bf2a5fd2762452e71f', 2);

-- --------------------------------------------------------

--
-- Table structure for table `user_essay_link`
--

CREATE TABLE IF NOT EXISTS `user_essay_link` (
  `link_id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_user_id` int(11) DEFAULT NULL,
  `fk_essay_id` int(11) DEFAULT NULL,
  `reviewed_status` int(11) NOT NULL,
  PRIMARY KEY (`link_id`),
  KEY `fk_user_id` (`fk_user_id`),
  KEY `user_essay_link_ibfk_1` (`fk_essay_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `user_essay_link`
--

INSERT INTO `user_essay_link` (`link_id`, `fk_user_id`, `fk_essay_id`, `reviewed_status`) VALUES
(1, 1, 1, 0),
(2, 1, 2, 0),
(3, 1, 3, 0),
(4, 1, 4, 0),
(5, 1, 5, 0),
(6, 1, 6, 0),
(7, 1, 7, 0),
(8, 1, 8, 0),
(9, 1, 9, 0),
(10, 1, 10, 0),
(11, 1, 11, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_type`
--

CREATE TABLE IF NOT EXISTS `user_type` (
  `user_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`user_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `user_type`
--

INSERT INTO `user_type` (`user_type_id`, `user_type`) VALUES
(1, 'Student'),
(2, 'Tutor');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `paragraphs`
--
ALTER TABLE `paragraphs`
  ADD CONSTRAINT `paragraphs_ibfk_1` FOREIGN KEY (`fk_essay_id`) REFERENCES `essays` (`essay_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sentences`
--
ALTER TABLE `sentences`
  ADD CONSTRAINT `sentences_ibfk_1` FOREIGN KEY (`fk_paragraph_id`) REFERENCES `paragraphs` (`paragraph_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`fk_user_type_id`) REFERENCES `user_type` (`user_type_id`);

--
-- Constraints for table `user_essay_link`
--
ALTER TABLE `user_essay_link`
  ADD CONSTRAINT `user_essay_link_ibfk_1` FOREIGN KEY (`fk_essay_id`) REFERENCES `essays` (`essay_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_essay_link_ibfk_2` FOREIGN KEY (`fk_user_id`) REFERENCES `users` (`user_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
