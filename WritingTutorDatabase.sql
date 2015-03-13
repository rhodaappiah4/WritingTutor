-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 13, 2015 at 02:07 AM
-- Server version: 5.6.16
-- PHP Version: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `testPython`
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `essays`
--

INSERT INTO `essays` (`essay_id`, `essay_name`, `essay_description`) VALUES
(1, 'Hello World', 'Very technical paper.'),
(2, 'Golda''s Travel', 'Good use of pronouns'),
(4, 'Azonto in Ghana', 'Excessive use of jargons'),
(5, 'Bye bye', 'Good'),
(6, 'The Revenge', 'Bad'),
(7, 'Timbuktu''s Revenge', 'Bad'),
(8, 'Survival of the fittest', 'Good paper');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=31 ;

--
-- Dumping data for table `paragraphs`
--

INSERT INTO `paragraphs` (`paragraph_id`, `fk_essay_id`, `paragraph_number`, `paragraph_comment`) VALUES
(1, 1, 1, 'Lovely paragraph'),
(2, 1, 2, 'Lovely paragraph'),
(3, 1, 3, 'Lovely paragraph'),
(4, 1, 4, 'Lovely paragraph'),
(5, 1, 5, 'Lovely paragraph'),
(6, 1, 6, 'Lovely paragraph'),
(7, 2, 1, 'Lovely paragraph'),
(8, 2, 2, 'Lovely paragraph'),
(9, 2, 3, 'Lovely paragraph'),
(10, 2, 4, 'Lovely paragraph'),
(11, 2, 5, 'Lovely paragraph'),
(12, 2, 6, 'Lovely paragraph'),
(13, 2, 7, 'Lovely paragraph'),
(15, 4, 1, 'Lovely paragraph'),
(16, 4, 2, 'Lovely paragraph'),
(17, 4, 3, 'Lovely paragraph'),
(18, 4, 4, 'Lovely paragraph'),
(19, 4, 5, 'Lovely paragraph'),
(20, 4, 6, 'Lovely paragraph'),
(21, 5, 1, 'Lovely paragraph'),
(22, 5, 2, 'Lovely paragraph'),
(23, 5, 3, 'Lovely paragraph'),
(24, 5, 4, 'Lovely paragraph'),
(25, 5, 5, 'Lovely paragraph'),
(26, 5, 6, 'Lovely paragraph'),
(27, 5, 7, 'Lovely paragraph'),
(28, 6, 1, 'Lovely paragraph'),
(29, 7, 1, 'Lovely paragraph'),
(30, 1, 1, 'Good start');

-- --------------------------------------------------------

--
-- Table structure for table `sentences`
--

CREATE TABLE IF NOT EXISTS `sentences` (
  `sentence_id` int(11) NOT NULL AUTO_INCREMENT,
  `fk_paragraph_id` int(11) DEFAULT NULL,
  `sentence_number` int(11) DEFAULT NULL,
  `sentence` text NOT NULL,
  `sentence_quality` int(2) NOT NULL,
  `sentence_comment` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`sentence_id`),
  KEY `fk_paragraph_id` (`fk_paragraph_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=200 ;

--
-- Dumping data for table `sentences`
--

INSERT INTO `sentences` (`sentence_id`, `fk_paragraph_id`, `sentence_number`, `sentence`, `sentence_quality`, `sentence_comment`) VALUES
(1, 1, 1, 'Mother Theresa', 0, 'Lovely sentence'),
(2, 1, 1, '\n', 0, 'Lovely sentence'),
(3, 2, 1, 'According to Mother Teresa, &#8220;If you judge someone, you have no time to love them.&#8221; I first saw this quote when it was posted on my sixth-grade classroom wall, and I hated it.', 0, 'Lovely sentence'),
(4, 2, 2, 'Rather, I hated Mother Teresa&#8217;s intention, but I knew that the quote&#8217;s veracity was inarguable.', 0, 'Lovely sentence'),
(5, 2, 3, 'I felt that it was better to judge people so as not to have to love them, because some people don&#8217;t deserve a chance.', 0, 'Lovely sentence'),
(6, 2, 4, 'Judgments are shields, and mine was impenetrable.\n', 0, 'Lovely sentence'),
(7, 3, 1, 'Laura was my dad&#8217;s first girlfriend after my parents&#8217; divorce.', 0, ''),
(8, 3, 2, 'The first three years of our relationship were characterized solely by my hatred toward her, manifested in my hurting her, each moment hurting myself twice as much.', 0, 'Lovely sentence'),
(9, 3, 3, 'From the moment I laid eyes on her, she was the object of my unabated hatred, not because of anything she had ever done, but because of everything she represented.', 0, 'Lovely sentence'),
(10, 3, 4, 'I judged her to be a heartless, soulless, two-dimensional figure: she was a representation of my loneliness and pain.', 0, 'Lovely sentence'),
(11, 3, 5, 'I left whenever she entered a room, I slammed car doors in her face.', 0, 'Lovely sentence'),
(12, 3, 6, 'Over those three years, I took pride in the fact that I had not spoken a word to her or made eye contact with her.', 0, 'Lovely sentence'),
(13, 3, 7, 'I treated Laura with such resentment and anger because my hate was my protection, my shield.', 0, 'Lovely sentence'),
(14, 3, 8, 'I, accustomed to viewing her as the embodiment of my pain, was afraid to let go of the anger and hate, afraid to love the person who allowed me to hold onto my anger, afraid that if I gave her a chance, I might love her.\n', 0, 'Lovely sentence'),
(15, 4, 1, 'For those three years, Laura didn&#8217;t hate me; she understood me.', 0, 'Lovely sentence'),
(16, 4, 2, 'She understood my anger and my confusion, and Laura put her faith in me, although she had every reason not to.', 0, 'Lovely sentence'),
(17, 4, 3, 'To her, I was essentially a good person, just confused and scared; trying to do her best, but just not able to get a hold of herself.', 0, 'Lovely sentence'),
(18, 4, 4, 'She saw me as I wished I could see myself.\n', 0, 'Lovely sentence'),
(19, 5, 1, 'None of this became clear to me overnight.', 0, 'Lovely sentence'),
(20, 5, 2, 'Instead, over the next two years, the one-dimensional image of her in my mind began to take the shape of a person.', 0, 'Lovely sentence'),
(21, 5, 3, 'As I let go of my hatred, I gave her a chance.', 0, 'Lovely sentence'),
(22, 5, 4, 'She became a woman who, like me, loves Ally McBeal and drinks a lot of coffee; who, unlike me, buys things advertised on infomercials.\n', 0, 'Lovely sentence'),
(23, 6, 1, 'Three weeks ago, I saw that same Mother Teresa quote again, but this time I smiled.', 0, 'Lovely sentence'),
(24, 6, 2, 'Laura never gave up on me, and the chance she gave me to like her was a chance that changed my life.', 0, 'Lovely sentence'),
(25, 6, 3, 'Because of this, I know the value of a chance, of having faith in a person, of seeing others as they wish they could see themselves.', 0, 'Lovely sentence'),
(26, 6, 4, 'I&#8217;m glad I have a lot of time left, because I definitely have a lot of chances left to give, a lot of people left to love.', 1, 'Lovely sentence'),
(27, 7, 1, 'I feel sick.', 0, 'Lovely sentence'),
(28, 7, 2, 'I&#8217;m nervous and my stomach&#8217;s turning.', 0, 'Lovely sentence'),
(29, 7, 3, 'The room is lined with neat rows of desks, each one occupied by another kid my age.', 0, 'Lovely sentence'),
(30, 7, 4, 'We&#8217;re all about to take the SATs.', 1, 'Lovely sentence muhahahaha'),
(31, 7, 5, 'The proctor has instructed us to fill out section four: &#8220;race.&#8221;\n', 0, 'Lovely sentence'),
(32, 8, 1, 'I cannot be placed neatly into a single racial category, although I&#8217;m sure that people walking down the street don&#8217;t hesitate to label me &#8220;caucasian.&#8221; Never in my life has a stranger not been surprised when I told them I was half black.\n', 1, 'Lovely sentence'),
(33, 9, 1, 'Having light skin, eyes, and hair, but being black and white often leaves me misperceived.', 0, 'Lovely sentence'),
(34, 9, 2, 'Do I wish that my skin were darker so that when I tell people I&#8217;m black they won&#8217;t laugh at me?', 0, 'Lovely sentence'),
(35, 9, 3, 'No, I accept and value who I am.', 0, 'Lovely sentence'),
(36, 9, 4, 'To me, being black is more than having brown skin; it&#8217;s having ancestors who were enslaved, a grandfather who managed one of the nation&#8217;s oldest black newspapers, the Chicago Daily Defender, and a family who is as proud of their heritage as I am.', 0, 'Lovely sentence'),
(37, 9, 5, 'I prove that one cannot always discern another&#8217;s race by his or her appearance.\n', 0, 'Lovely sentence'),
(38, 10, 1, 'I often find myself frustrated when explaining my racial background, because I am almost always proving my &#8220;blackness&#8221; and left neglecting my Irish-American side.', 0, 'Lovely sentence'),
(39, 10, 2, 'People have told me that &#8220;one drop of black blood determines your race,&#8221; but I opt not to follow this rule.', 0, 'Lovely sentence'),
(40, 10, 3, 'In this country a century ago, most mixed-race children were products of rape or other relationships of power imbalance, but I am not.', 0, 'Lovely sentence'),
(41, 10, 4, 'I am a child in the twenty-first century who is a product of a loving relationship.', 0, 'Lovely sentence'),
(42, 10, 5, 'I choose the label biracial and identify with my black and Irish sides equally.', 0, 'Lovely sentence'),
(43, 10, 6, 'I am proud to say that my paternal great-grandparents immigrated to this country from Ireland and that I have found their names on the wall at Ellis Island, but people are rarely interested in that.', 0, 'Lovely sentence'),
(44, 10, 7, 'They can&#8217;t get over the idea that this girl, who according to their definition looks white, is not.\n', 0, 'Lovely sentence'),
(45, 11, 1, 'Last year, at my school&#8217;s &#8220;Sexual Awareness Day,&#8221; a guest lecturer spoke about the stereotypical portrayal of different types of people on MTV&#8217;s The Real World.', 0, 'Lovely sentence'),
(46, 11, 2, 'He pointed out that the white, blond-haired girls are always depicted as completely ditsy and asked me how it felt to fit that description.', 0, 'Lovely sentence'),
(47, 11, 3, 'I wasn&#8217;t surprised that he assumed I was white, but I did correct his mistake.', 0, 'Lovely sentence'),
(48, 11, 4, 'I told him that I thought the show&#8217;s portrayal of white girls with blond hair was unfair.', 0, 'Lovely sentence'),
(49, 11, 5, 'I went on to say that we should also be careful not to make assumptions about people based on their physical appearance.', 0, 'Lovely sentence'),
(50, 11, 6, '&#8220;For example,&#8221; I told him, &#8220;I&#8217;m not white.&#8221; It was interesting that the lecturer, whose goal was to teach students not to judge or make assumptions about people based on their sexual orientation, had himself made a racial assumption about me.\n', 0, 'Lovely sentence'),
(51, 12, 1, 'I often find myself wishing that racial labels didn&#8217;t exist so that people wouldn&#8217;t rely on race alone to understand a person&#8217;s thoughts, actions, habits, and personality.', 0, 'Lovely sentence'),
(52, 12, 2, 'One&#8217;s race does not reveal the content of their character.', 0, 'Lovely sentence'),
(53, 12, 3, 'When someone finds out that I am biracial, do I become a different person in his or her eyes?', 0, 'Lovely sentence'),
(54, 12, 4, 'Am I suddenly &#8220;deeper,&#8221; because I&#8217;m not just the &#8220;plain white girl&#8221; they assumed I was?', 0, 'Lovely sentence'),
(55, 12, 5, 'Am I more complex?', 0, 'Lovely sentence'),
(56, 12, 6, 'Can they suddenly relate to me more (or less)?', 0, 'Lovely sentence'),
(57, 12, 7, 'No, my race alone doesn&#8217;t reveal who I am.', 0, 'Lovely sentence'),
(58, 12, 8, 'If one&#8217;s race cannot be determined simply by looking at a person, then how can it be possible to look at a person and determine her inner qualities?\n', 0, 'Lovely sentence'),
(59, 13, 1, 'Through census forms, racial questionnaires on the SATs, and other devices, our society tries to draw conclusions about people based on appearance.', 0, 'Lovely sentence'),
(60, 13, 2, 'It is a quick and easy way to categorize people without taking the time to get to know them, but it simply cannot be done.', 0, 'Lovely sentence'),
(87, 15, 1, 'Mother Theresa |TB|\n', 0, 'Lovely sentence'),
(88, 15, 1, '\n', 0, 'Lovely sentence'),
(89, 16, 1, 'According to Mother Teresa, &#8220;If you judge someone, you have no time to love them.&#8221; I first saw this quote when it was posted on my sixth-grade classroom wall, and I hated it.', 0, 'Lovely sentence'),
(90, 16, 2, 'Rather, I hated Mother Teresa&#8217;s intention, but I knew that the quote&#8217;s veracity was inarguable.', 0, 'Lovely sentence'),
(91, 16, 3, 'I felt that it was better to judge people so as not to have to love them, because some people don&#8217;t deserve a chance.', 0, 'Lovely sentence'),
(92, 16, 4, 'Judgments are shields, and mine was impenetrable.\n', 0, 'Lovely sentence'),
(93, 17, 1, 'Laura was my dad&#8217;s first girlfriend after my parents&#8217; divorce.', 0, 'Lovely sentence'),
(94, 17, 2, 'The first three years of our relationship were characterized solely by my hatred toward her, manifested in my hurting her, each moment hurting myself twice as much.', 0, 'Lovely sentence'),
(95, 17, 3, 'From the moment I laid eyes on her, she was the object of my unabated hatred, not because of anything she had ever done, but because of everything she represented.', 0, 'Lovely sentence'),
(96, 17, 4, 'I judged her to be a heartless, soulless, two-dimensional figure: she was a representation of my loneliness and pain.', 0, 'Lovely sentence'),
(97, 17, 5, 'I left whenever she entered a room, I slammed car doors in her face.', 0, 'Lovely sentence'),
(98, 17, 6, 'Over those three years, I took pride in the fact that I had not spoken a word to her or made eye contact with her.', 0, 'Lovely sentence'),
(99, 17, 7, 'I treated Laura with such resentment and anger because my hate was my protection, my shield.', 0, 'Lovely sentence'),
(100, 17, 8, 'I, accustomed to viewing her as the embodiment of my pain, was afraid to let go of the anger and hate, afraid to love the person who allowed me to hold onto my anger, afraid that if I gave her a chance, I might love her.\n', 0, 'Lovely sentence'),
(101, 18, 1, 'For those three years, Laura didn&#8217;t hate me; she understood me.', 0, 'Lovely sentence'),
(102, 18, 2, 'She understood my anger and my confusion, and Laura put her faith in me, although she had every reason not to.', 0, 'Lovely sentence'),
(103, 18, 3, 'To her, I was essentially a good person, just confused and scared; trying to do her best, but just not able to get a hold of herself.', 0, 'Lovely sentence'),
(104, 18, 4, 'She saw me as I wished I could see myself.\n', 0, 'Lovely sentence'),
(105, 19, 1, 'None of this became clear to me overnight.', 0, 'Lovely sentence'),
(106, 19, 2, 'Instead, over the next two years, the one-dimensional image of her in my mind began to take the shape of a person.', 0, 'Lovely sentence'),
(107, 19, 3, 'As I let go of my hatred, I gave her a chance.', 0, 'Lovely sentence'),
(108, 19, 4, 'She became a woman who, like me, loves Ally McBeal and drinks a lot of coffee; who, unlike me, buys things advertised on infomercials.\n', 0, 'Lovely sentence'),
(109, 20, 1, 'Three weeks ago, I saw that same Mother Teresa quote again, but this time I smiled.', 0, 'Lovely sentence'),
(110, 20, 2, 'Laura never gave up on me, and the chance she gave me to like her was a chance that changed my life.', 0, 'Lovely sentence'),
(111, 20, 3, 'Because of this, I know the value of a chance, of having faith in a person, of seeing others as they wish they could see themselves.', 0, 'Lovely sentence'),
(112, 20, 4, 'I&#8217;m glad I have a lot of time left, because I definitely have a lot of chances left to give, a lot of people left to love.', 0, 'Lovely sentence'),
(113, 21, 1, 'I feel sick.', 0, 'Lovely sentence'),
(114, 21, 2, 'I&#8217;m nervous and my stomach&#8217;s turning.', 0, 'Lovely sentence'),
(115, 21, 3, 'The room is lined with neat rows of desks, each one occupied by another kid my age.', 0, 'Lovely sentence'),
(116, 21, 4, 'We&#8217;re all about to take the SATs.', 0, 'Lovely sentence'),
(117, 21, 5, 'The proctor has instructed us to fill out section four: &#8220;race.&#8221;\n', 0, 'Lovely sentence'),
(118, 22, 1, 'I cannot be placed neatly into a single racial category, although I&#8217;m sure that people walking down the street don&#8217;t hesitate to label me &#8220;caucasian.&#8221; Never in my life has a stranger not been surprised when I told them I was half black.\n', 0, 'Lovely sentence'),
(119, 23, 1, 'Having light skin, eyes, and hair, but being black and white often leaves me misperceived.', 0, 'Lovely sentence'),
(120, 23, 2, 'Do I wish that my skin were darker so that when I tell people I&#8217;m black they won&#8217;t laugh at me?', 0, 'Lovely sentence'),
(121, 23, 3, 'No, I accept and value who I am.', 0, 'Lovely sentence'),
(122, 23, 4, 'To me, being black is more than having brown skin; it&#8217;s having ancestors who were enslaved, a grandfather who managed one of the nation&#8217;s oldest black newspapers, the Chicago Daily Defender, and a family who is as proud of their heritage as I am.', 0, 'Lovely sentence'),
(123, 23, 5, 'I prove that one cannot always discern another&#8217;s race by his or her appearance.\n', 0, 'Lovely sentence'),
(124, 24, 1, 'I often find myself frustrated when explaining my racial background, because I am almost always proving my &#8220;blackness&#8221; and left neglecting my Irish-American side.', 0, 'Lovely sentence'),
(125, 24, 2, 'People have told me that &#8220;one drop of black blood determines your race,&#8221; but I opt not to follow this rule.', 0, 'Lovely sentence'),
(126, 24, 3, 'In this country a century ago, most mixed-race children were products of rape or other relationships of power imbalance, but I am not.', 0, 'Lovely sentence'),
(127, 24, 4, 'I am a child in the twenty-first century who is a product of a loving relationship.', 0, 'Lovely sentence'),
(128, 24, 5, 'I choose the label biracial and identify with my black and Irish sides equally.', 0, 'Lovely sentence'),
(129, 24, 6, 'I am proud to say that my paternal great-grandparents immigrated to this country from Ireland and that I have found their names on the wall at Ellis Island, but people are rarely interested in that.', 0, 'Lovely sentence'),
(130, 24, 7, 'They can&#8217;t get over the idea that this girl, who according to their definition looks white, is not.\n', 0, 'Lovely sentence'),
(131, 25, 1, 'Last year, at my school&#8217;s &#8220;Sexual Awareness Day,&#8221; a guest lecturer spoke about the stereotypical portrayal of different types of people on MTV&#8217;s The Real World.', 0, 'Lovely sentence'),
(132, 25, 2, 'He pointed out that the white, blond-haired girls are always depicted as completely ditsy and asked me how it felt to fit that description.', 0, 'Lovely sentence'),
(133, 25, 3, 'I wasn&#8217;t surprised that he assumed I was white, but I did correct his mistake.', 0, 'Lovely sentence'),
(134, 25, 4, 'I told him that I thought the show&#8217;s portrayal of white girls with blond hair was unfair.', 0, 'Lovely sentence'),
(135, 25, 5, 'I went on to say that we should also be careful not to make assumptions about people based on their physical appearance.', 0, 'Lovely sentence'),
(136, 25, 6, '&#8220;For example,&#8221; I told him, &#8220;I&#8217;m not white.&#8221; It was interesting that the lecturer, whose goal was to teach students not to judge or make assumptions about people based on their sexual orientation, had himself made a racial assumption about me.\n', 0, 'Lovely sentence'),
(137, 26, 1, 'I often find myself wishing that racial labels didn&#8217;t exist so that people wouldn&#8217;t rely on race alone to understand a person&#8217;s thoughts, actions, habits, and personality.', 0, 'Lovely sentence'),
(138, 26, 2, 'One&#8217;s race does not reveal the content of their character.', 0, 'Lovely sentence'),
(139, 26, 3, 'When someone finds out that I am biracial, do I become a different person in his or her eyes?', 0, 'Lovely sentence'),
(140, 26, 4, 'Am I suddenly &#8220;deeper,&#8221; because I&#8217;m not just the &#8220;plain white girl&#8221; they assumed I was?', 0, 'Lovely sentence'),
(141, 26, 5, 'Am I more complex?', 0, 'Lovely sentence'),
(142, 26, 6, 'Can they suddenly relate to me more (or less)?', 0, 'Lovely sentence'),
(143, 26, 7, 'No, my race alone doesn&#8217;t reveal who I am.', 0, 'Lovely sentence'),
(144, 26, 8, 'If one&#8217;s race cannot be determined simply by looking at a person, then how can it be possible to look at a person and determine her inner qualities?\n', 0, 'Lovely sentence'),
(145, 27, 1, 'Through census forms, racial questionnaires on the SATs, and other devices, our society tries to draw conclusions about people based on appearance.', 0, 'Lovely sentence'),
(146, 27, 2, 'It is a quick and easy way to categorize people without taking the time to get to know them, but it simply cannot be done.', 0, 'Lovely sentence'),
(147, 28, 1, 'H', 0, 'Lovely sentence'),
(148, 28, 1, 'e', 0, 'Lovely sentence'),
(149, 28, 1, ' ', 0, 'Lovely sentence'),
(150, 28, 1, 'i', 0, 'Lovely sentence'),
(151, 28, 1, 's', 0, 'Lovely sentence'),
(152, 28, 1, ' ', 0, 'Lovely sentence'),
(153, 28, 1, 's', 0, 'Lovely sentence'),
(154, 28, 1, 'o', 0, 'Lovely sentence'),
(155, 28, 1, ' ', 0, 'Lovely sentence'),
(156, 28, 1, 'c', 0, 'Lovely sentence'),
(157, 28, 1, 'o', 0, 'Lovely sentence'),
(158, 28, 1, 'o', 0, 'Lovely sentence'),
(159, 28, 1, 'l', 0, 'Lovely sentence'),
(160, 28, 1, '.', 0, 'Lovely sentence'),
(161, 28, 1, ' ', 0, 'Lovely sentence'),
(162, 28, 1, 'Y', 0, 'Lovely sentence'),
(163, 28, 1, 'e', 0, 'Lovely sentence'),
(164, 28, 1, 'a', 0, 'Lovely sentence'),
(165, 28, 1, 'h', 0, 'Lovely sentence'),
(166, 28, 1, ' ', 0, 'Lovely sentence'),
(167, 28, 1, 'r', 0, 'Lovely sentence'),
(168, 28, 1, 'i', 0, 'Lovely sentence'),
(169, 28, 1, 'g', 0, 'Lovely sentence'),
(170, 28, 1, 'h', 0, 'Lovely sentence'),
(171, 28, 1, 't', 0, 'Lovely sentence'),
(172, 28, 1, '.', 0, 'Lovely sentence'),
(173, 29, 1, 'I', 0, 'Lovely sentence'),
(174, 29, 1, ' ', 0, 'Lovely sentence'),
(175, 29, 1, 'a', 0, 'Lovely sentence'),
(176, 29, 1, 'm', 0, 'Lovely sentence'),
(177, 29, 1, ' ', 0, 'Lovely sentence'),
(178, 29, 1, 'a', 0, 'Lovely sentence'),
(179, 29, 1, ' ', 0, 'Lovely sentence'),
(180, 29, 1, 'g', 0, 'Lovely sentence'),
(181, 29, 1, 'i', 0, 'Lovely sentence'),
(182, 29, 1, 'r', 0, 'Lovely sentence'),
(183, 29, 1, 'l', 0, 'Lovely sentence'),
(184, 29, 1, '.', 0, 'Lovely sentence'),
(185, 29, 1, ' ', 0, 'Lovely sentence'),
(186, 29, 1, 'H', 0, 'Lovely sentence'),
(187, 29, 1, 'o', 0, 'Lovely sentence'),
(188, 29, 1, 'w', 0, 'Lovely sentence'),
(189, 29, 1, ' ', 0, 'Lovely sentence'),
(190, 29, 1, 'a', 0, 'Lovely sentence'),
(191, 29, 1, 'b', 0, 'Lovely sentence'),
(192, 29, 1, 'o', 0, 'Lovely sentence'),
(193, 29, 1, 'u', 0, 'Lovely sentence'),
(194, 29, 1, 't', 0, 'Lovely sentence'),
(195, 29, 1, ' ', 0, 'Lovely sentence'),
(196, 29, 1, 'y', 0, 'Lovely sentence'),
(197, 29, 1, 'o', 0, 'Lovely sentence'),
(198, 29, 1, 'u', 0, 'Lovely sentence'),
(199, 29, 1, '?', 0, 'Lovely sentence');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `user_essay_link`
--

INSERT INTO `user_essay_link` (`link_id`, `fk_user_id`, `fk_essay_id`, `reviewed_status`) VALUES
(2, 2, 2, 0),
(3, 2, 1, 1),
(4, 2, 7, 1),
(5, 1, 5, 1),
(6, 1, 6, 0);

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
