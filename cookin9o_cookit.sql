-- phpMyAdmin SQL Dump
-- version 4.0.10.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 01, 2015 at 06:04 AM
-- Server version: 5.6.23-72.1-log
-- PHP Version: 5.4.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `cookin9o_cookit`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`cookin9o`@`localhost` PROCEDURE `IngList`()
begin
select * from ingredients;
end$$

CREATE DEFINER=`cookin9o`@`localhost` PROCEDURE `prc_find_recipes`(IN `P_Ing_Name` VARCHAR(25), IN `p_veg` INT)
BEGIN

IF p_veg = 1 THEN
insert into temp_recipe_ig (recipe_id,recipe_name) 
select r_id,r_name from recipe_ig where ig_name LIKE concat('%',P_Ing_Name,'%') and r_veg=1;
else
insert into temp_recipe_ig (recipe_id,recipe_name) 
select r_id,r_name from recipe_ig where ig_name LIKE concat('%',P_Ing_Name,'%') ;

END IF;
COMMIT;
END$$

CREATE DEFINER=`cookin9o`@`localhost` PROCEDURE `prc_recipe_details`(IN `P_recipe_name` VARCHAR(30))
    MODIFIES SQL DATA
BEGIN
Truncate table temp_ig;  

Truncate table temp_steps;

  
insert into temp_ig SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(recipe_details.recipe_ing, '~', numbers.n), '~', -1) name 
FROM numbers 
INNER JOIN recipe_details ON CHAR_LENGTH(recipe_details.recipe_ing) -CHAR_LENGTH(REPLACE(recipe_details.recipe_ing, '~', ''))>=numbers.n-1
where recipe_details.recipe_id = (select r_id from recipe_ig where r_name = P_recipe_name)
ORDER BY name;
  
insert into temp_steps SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(recipe_details.recipe_steps, '~', numbers.n), '~', -1) name 
FROM numbers 
INNER JOIN recipe_details ON CHAR_LENGTH(recipe_details.recipe_steps) -CHAR_LENGTH(REPLACE(recipe_details.recipe_steps, '~', ''))>=numbers.n-1
where recipe_details.recipe_id = (select r_id from recipe_ig where r_name = P_recipe_name)
ORDER BY name;

commit;
  
END$$

CREATE DEFINER=`cookin9o`@`localhost` PROCEDURE `Tbl`(IN `t_name` VARCHAR(255))
    READS SQL DATA
begin
select * from t_name;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cooking_methods`
--

CREATE TABLE IF NOT EXISTS `cooking_methods` (
  `method` varchar(300) DEFAULT NULL,
  `description` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cooking_methods`
--

INSERT INTO `cooking_methods` (`method`, `description`) VALUES
('FLAMBE', 'To flame foods by dousing in some form of potable alcohol and setting alight. '),
('GLAZE', 'To cook with a thin sugar syrup cooked to crack stage; mixture may be thickened slightly. Also, to cover with a thin, glossy icing.'),
('AL DENTE', 'Italian term used to describe pasta that is cooked until it offers a slight resistance to the bite.'),
('BAKE', 'To cook by dry heat, usually in the oven.'),
('BARBECUE', 'Usually used generally to refer to grilling done outdoors or over an open charcoal or wood fire. More specifically, barbecue refers to long, slow direct- heat cooking, including liberal basting with a barbecue sauce.'),
('BASTE', 'To moisten foods during cooking with pan drippings or special sauce to add flavor and prevent drying.'),
('CARAMELIZE', 'To heat sugar in order to turn it brown and give it a special taste.'),
('CLARIFY', 'To separate and remove solids from a liquid, thus making it clear.'),
('DEGLAZE', 'To dissolve the thin glaze of juices and brown bits on the surface of a pan in which food has been fried, sauteed or roasted. To do this, add liquid and stir and scrape over high heat, thereby adding flavor to the liquid for use as a sauce.'),
('DUST', 'To sprinkle food with dry ingredients. Use a strainer or a jar with a perforated cover, or try the good, old-fashioned way of shaking things together in a paper bag.'),
('FLAMBE', 'To flame foods by dousing in some form of potable alcohol and setting alight.'),
('FRICASSEE', 'To cook by braising; usually applied to fowl or rabbit.');

-- --------------------------------------------------------

--
-- Table structure for table `glossary`
--

CREATE TABLE IF NOT EXISTS `glossary` (
  `Ingredient` varchar(30) NOT NULL,
  `Meaning` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `glossary`
--

INSERT INTO `glossary` (`Ingredient`, `Meaning`) VALUES
('Ajowan Seeds', 'Ajwain'),
('Almond', 'Badam'),
('Banana', 'Kela'),
('Black Pepper', 'Kali Mirch'),
('Cauliflower', 'Phool Gobhi'),
('Chickpea (Whole)', 'Chana, Kabuli Chana, Safaid Ch'),
('Date', 'Khajur'),
('Durum Wheat Middlings', 'Suji, Rava'),
('Eschalot', 'Kanda, Gandana, Musir'),
('Egyptian Millet', 'Jowar'),
('Fenugreek', 'Methi'),
('Finger Millet', 'Ragi'),
('Golden Gram', 'Mung'),
('Gram Flour', 'Besan'),
('Habanero Pepper', 'Hari Mirch'),
('Honey', 'Shahad, Shehed, Madhu'),
('Indian Baby Pumpkin', 'Tinda'),
('Indian Yam', 'Suran'),
('Jaggery', 'Gud, Gur'),
('Java Plum', 'Jam, Jamun, Jambul'),
('Kidney Bean', 'Rajma, Razma'),
('Kumaon Lemon', 'Galgal');

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE IF NOT EXISTS `ingredients` (
  `Ing_ID` int(6) NOT NULL AUTO_INCREMENT,
  `Ing_name` varchar(200) NOT NULL,
  PRIMARY KEY (`Ing_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=114 ;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`Ing_ID`, `Ing_name`) VALUES
(1, 'asparagus'),
(2, 'chilli'),
(3, 'egg'),
(4, 'salmon'),
(5, 'cottage cheese'),
(6, 'potato'),
(7, 'coriander'),
(8, 'tomato'),
(9, 'pumpkin'),
(10, 'beef'),
(11, 'chicken'),
(12, 'basmati rice'),
(13, 'butter'),
(14, 'cashewnuts'),
(15, 'cream'),
(16, 'onion'),
(17, 'cornflour'),
(18, 'maida'),
(19, 'riceflour'),
(20, 'rava'),
(21, 'yogurt'),
(22, 'channa'),
(23, 'wheat flour'),
(24, 'poha'),
(25, 'palak'),
(26, 'fenugreek'),
(27, 'curd'),
(28, 'mutton'),
(29, 'saffron'),
(30, 'paneer'),
(31, 'coconut'),
(32, 'black gram'),
(33, 'cauliflower'),
(34, 'peas'),
(35, 'fish'),
(36, 'beans'),
(37, 'mushroom'),
(38, 'black channa'),
(39, 'gram flour'),
(40, 'bombay duck fish'),
(41, 'besan'),
(42, 'taro root leaves'),
(43, 'white peas'),
(44, 'brinjal'),
(45, 'chana dal'),
(46, 'taro root'),
(47, 'chicken breast'),
(48, 'almonds'),
(49, 'bread'),
(50, 'butter milk'),
(51, 'cabbage'),
(52, 'mango'),
(53, 'carrot'),
(54, 'okra'),
(55, 'drumsticks'),
(56, 'garbanzo'),
(57, 'kabuli chana'),
(58, 'urad dal'),
(59, 'bottle gourd'),
(60, 'moong dal'),
(61, 'tur dal'),
(62, 'masoor dal'),
(63, 'kheema'),
(64, 'capsicum'),
(65, 'prawns'),
(66, 'milk'),
(67, 'chickpeas'),
(68, 'mango pickle'),
(69, 'tamarind chutney'),
(70, 'green peas'),
(71, 'ghee'),
(72, 'drumstick leaves'),
(73, 'garlic'),
(74, 'fennel seeds'),
(75, 'poppy seeds'),
(76, 'melon seeds'),
(77, 'kasoori methi'),
(78, 'chickpea flour'),
(79, 'spinach'),
(80, 'sesame seeds'),
(81, 'jaggery'),
(82, 'kidney beans'),
(83, 'chocolate'),
(84, 'oreo cookies'),
(85, 'gelatin'),
(86, 'caramel syrup'),
(87, 'cocoa powder'),
(88, 'vanilla paste'),
(89, 'vanilla ice cream'),
(90, 'peanut butter'),
(91, 'vanilla extract'),
(92, 'strawberries'),
(93, 'dark rum'),
(94, 'dark chocolate sponge'),
(95, 'vanilla custard powder'),
(96, 'orange'),
(97, 'biscuits'),
(98, 'kaju katli'),
(99, 'cinnamon powder'),
(100, 'raisins'),
(101, 'strawberry jelly'),
(102, 'kiwi'),
(103, 'vanilla sponge'),
(104, 'pineapple'),
(105, 'condensed milk'),
(106, 'banana'),
(107, 'rum'),
(108, 'brown sugar'),
(109, 'coffee powder'),
(110, 'apple'),
(111, 'walnuts'),
(112, 'white chocolate'),
(113, 'cranberries');

-- --------------------------------------------------------

--
-- Table structure for table `numbers`
--

CREATE TABLE IF NOT EXISTS `numbers` (
  `n` int(11) NOT NULL,
  PRIMARY KEY (`n`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `numbers`
--

INSERT INTO `numbers` (`n`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29),
(30),
(31),
(32),
(33),
(34),
(35),
(36),
(37),
(38),
(39),
(40),
(41),
(42),
(43),
(44),
(45),
(46),
(47),
(48),
(49),
(50),
(51);

-- --------------------------------------------------------

--
-- Table structure for table `recipe_details`
--

CREATE TABLE IF NOT EXISTS `recipe_details` (
  `recipe_id` int(11) DEFAULT NULL,
  `recipe_ing` varchar(2000) DEFAULT NULL,
  `recipe_steps` varchar(2000) DEFAULT NULL,
  KEY `recipe_ig_and_details_FK` (`recipe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `recipe_details`
--

INSERT INTO `recipe_details` (`recipe_id`, `recipe_ing`, `recipe_steps`) VALUES
(1, '01. 2 lbs Lean Ground Beef 908 Grams~02. 1 Bunch Swiss Chard about 11-12 ounces 310-340 grams~03. 2 Medium Yellow Squash cubed~04. 2 Cups onions 280 grams~05. 5 Cloves~garlic chopped~06. 3 Chiles seeds removed and chopped~07. Salt~08. Pepper~09. 1 Tablespoon Tomato Paste~10. 2.5 Tablespoon Chili Powder~11. 1 Tablespoon Ground Cumin~12. 1 Can of Light Beer (12 oz or 375 mL)~13. 1 Can (13 oz) Red Kidney Beans drained and rinsed~14. 1 Can (28 oz) Chopped Tomatoes~15. 1 Cup Red Lentils washed (240g)~16. 2 Cups Chicken Stock (480 ml)~17. 2 Oz Bittersweet Chocolate (56 grams)', '01. Heat oil in a heavy pot or Dutch Oven over medium-high heat. Add beef, season with salt and pepper, and cook until browned. Add oil if necessary to keep from drying out.~02. Cook until most of the liquid from the beef has evaporated off.~03. Remove beef to a bowl, Add onions, chills, garlic, and cook until onions have softened. Add beef back to pot. Add tomato paste, cook for a few seconds, and then mix everything to combine.~04. Add spices, mix, then pour in the beer. Sitr, then let beer cook off. Add chard, squash, and season with salt and pepper. Stir, and add tomatoes and lentils.~05. Bring to a simmer, then add chicken stock. Lower heat until chili is just simmering. Add bittersweet chocolate, stir in until melted. Cover, and cook, stirring occasionally for 1 hour, or until the chili is as thick as you like it.~06. Chopped Garnish: Onion Cilantro Jalapeño Lime Wedges~07. Dice the onion and Jalepeño fine. Remove cilantro (aka coriander) stems, then chop roughly (rustic!). Garnish with as much or little of each as you want.'),
(2, '01. 1 lb (453 g) Salmon~02. 2 Garlic Cloves~03. 1 Tsp Fresh Ginger~04. 1 Lemon~05. 1 Tsp Ground Chili Pepper~06. 3 Tbsp Soy Sauce~07. 2 Tbsp Olive Oil~08. 1 Tsp Brown Sugar~09. 1/2 Tsp Honey~10. Salt', '01. Mince the fresh ginger.~02. Mash the garlic cloves into a big bowl.~03. Squeeze a fresh lemon juice into the bowl.~04. Add ground chili pepper, salt, soy sauce, olive oil, brown sugar and honey to bowl.~05. Stir until well blended.~06. Pour the mixture into a plastic or a zip lock bag, place the salmon pieces into the bag and seal/zip the bag tight.~07. Marinate the salmon for two hours (Keep in a refrigerator).~08. Transfer the salmon along with the mixture into a bakeware.~09. Preheat the oven to 375º F (190º C), cook the fish for 22 to 27 minutes. (Glaze the salmon occasionally while cooking)'),
(3, '01. 2 Large Russet Potatoes~02. 1/2 Cup Milk~03. 4 Tablespoon Butter~04. Salt~05. White Pepper Powder', '01. Peel the potatoes and cut them in half.~02. Boil 4-5 Cups Water.~03. Boil the potatoes for 15 to 20 minutes or until easily pierced with a fork.~04. Mash the potatoes.~05. Add 4 tbsp butter, white pepper powder and 1/2 cup milk and mash until well mixed.~06. Green onions may be added to the mixture before serving.'),
(5, '01. 1 tsp all purpose flour~02. 50 grams capsicum~03. 1 bunch coriander leaves~04. 1 tbsp Coriander powder~05. as needed creme fresh~06. 1/2 tsp cumin powder~07. 1 tsp cumin seeds~08. 1 cup curd thick~09. pinch 0 garam masala~10. 1 tsp ginger garlic paste~11. pinch 0 kasoori methi~12. 1/2 number lime juice~13. 3 tbsp oil~14. 50 number onion~15. 1 cup onion chopped~16. 1 lbs paneer~17. 1 tbsp red chilli powder~18. as per taste salt~19. 50 number tomato~20. 1 cup tomato puree~21. pinch 0 turmeric powder', '01. First cut all the vegetables and paneer in cubes and keep aside.~02. Take a bowl add thick curd, red chilli powder,salt,kasoori methi powder, lime juice and add oil little mix well and add all the vegetables and paneer mix well.~03. In a non stick pan add one tablespoon of oil ,add marinated paneer and vegetables, cook both the sides, once it is done keep aside.~04. Take a pan add oil, cumin seeds,onion chopped, salt pinch, turmeric,ginger garlic paste, all purpose flour, mix cook for 3 min,now add tomato puree, coriander powder,cumin powder,red chilli powder, mix well, and let it cook till u can see oil.~05. once it is done add water as need,bring it to boil, then add cooked paneer and vegetables, garam masala powder, cream as needed and cook for 3 min and finish it of with coriander leaves.'),
(7, '01. Lemon or Lime juice~02. Sugar~03. Black salt~04. Fresh mint~05. Fresh lime or lemon pieces~06. Ice cubes~07. Water', '01. In a large bowl add lemon juice and water.~02. Add sugar how much u want and add 1/2 spoon of black salt.~03. In a serving glass pour half glass lemon mixture and add ice cubs in it.~04. Now add lemon pieces and fresh mint and your Mint lemonade cooler is ready.'),
(8, '01. 4 slices Challah or Pannetone~02. 4 whole eggs beaten~03. 1 /4 cup Milk~04. 1 tsp vanilla extract~05. ½ tsp cinnamon~06. 2 oz. Whole butter~07. Powdered sugar', '01. Dredge and slightly soak, slices of bread in beaten egg, milk, cinnamon, and extract mixture~02. Heat skillet add butter and when hot add bread and cook until golden brown.~03. Remove and serve with powdered sugar and hot maple syrup.'),
(9, '01. 1/2 tsp amchoor pdr~02. 1 number cauliflower cut into florets~03. 1 bunch chopped coriander leaves~04. 2 tsp coriander powder~05. 1 tsp cumin seeds~1 tsp garam masala~06. 1 tsp ginger garlic paste~07. 1 tbsp gr peas~08. 2 number green chilli~09. 1/4 cup oil~10. 1 number onion~11. 4 number potatoes cubed~12. 1 tsp red chili powder~13. to taste salt~14. 3 number tomatoes chopped~15. 3/4 tsp turmeric powder', '01. Heat oil in a pan, saute cumin seeds, ginger-garlic paste for a minute and crushed tomato,onion and gr chilli and add turmeric cook till oil ozzes out add rest of spices mixed in water~02. add poatoes. and cauliflower~03. Also salt. Fry for few minutes.~04. Lower the heat, cover and simmer for about 15 minutes until the vegetables are cooked~05. serve hot with naan , chapati , roti'),
(10, '01. Freshly ground coconut paste 1 Tablespoons~02. Sesame seeds powder roasted 1 Tablespoons~03. Roasted peanut powder 2 Tablespoons~04. Garam masala powder 1/2 Teaspoons~05. Jeera powder 1/2 Teaspoons~06. Red chilli powder 1/2 Teaspoons~07. Fennel seeds 1/2 Teaspoons~08. Whole coriander seeds 1/2 Teaspoons~09. Cumin seeds 1/2 Teaspoons~10. Turmeric powder 1/4 Teaspoons~11. Hing (asafoetida) Pinch~12. Oil 1 Teaspoons~13. Rice flour 1 Teaspoons~14. Besan atta (chickpea flour) 1 Cup~15. Taro root leaves big sized 5-6 Leaf~16. Jaggery powdered 1 Tablespoons~17. Salt to taste~18. Tamarind juice 2 Tablespoons~19. Water as needed ~20. Oil for deep frying', '01. Dry roast 1 cup of besan (chickpea flour) in a pan on slow flame and cook for few minutes till you get a nice flavor from the flour.~02. Add tsp rice flour and toss well. Switch off the flame and keep aside. To this flour mixture, add little oil, pinch of hing, turmeric, cumin seeds, whole coriander seeds, fennel seeds, chilli powder, jeera powder, garam masala, 2 tbsp dry roasted peanut powder, 1 tbsp roasted sesame seeds powder, freshly ground coconut and powdered jaggery. Mix all these ingredients~03. Add salt, little tamarind juice and water and mix and make to a thick paste. Place the taro root leaf upside down on a flat surface, and thinly coat the leaf with the besan mixture and then place another leaf over it and again coat the leaf with besan mixture. Repeat this with at least about 5 to 6 leaves. If they are very bigger leaves, then 3-4 are sufficient. Fold the half of the leaf on both sides and roll them gently similar to an egg roll.'),
(11, '01. pinch Ajwain~02. 1 springs Coriander leaves chopped~03. 1 tbsp Coriander powder~04. 1 tsp Cumin seeds~05. few springs Curry leaves~06. 12-14 small Eggplant/ Brinjals~07. 1 tsp Fresh grated Coconut~08. 2 tbsp Goda masala~09. 1/2 tsp Green chillies chopped~10. pinch Hing (asafoetida)~11. 1 tbsp Jaggery~12. 1 tsp Mustard seeds~13. 2 tbsp Oil~14. 1 tbsp Peanuts roasted~15. 2 tsp Red chilli powder~16. Salt to taste~17. 1 tbsp Sesame seeds roasted~18. 1 tbsp Tamarind pulp~19. 1 tsp Turmeric powder', '01. Remove stems and give four vertical slits (not fully) to the brinjals from the top. If you want to keep the stems, give the slits from the bottom of the brinajls keeping the stem intact. Keep them in salt water for 10 minutes and rinse. Set aside.~02. In a bowl, add chopped coriander, goda masala, coriander powder, grated coconut, roasted peanuts and till seeds powder, pinch of salt and mix all the ingredients well.~03.Stuff all the brinjals with above masala.~04.Take a kadai or a shallow non stick pan, and heat oil in it. Add mustard seeds. When you hear spluttering sound, add cumin seeds, pinch of ajwain, asafoetida, curry leaves, Â½ tsp chopped green chillies, turmeric powder and chilli powder. Reduce the flame and sautÃ© all the spices nicely.'),
(12, '01. 100 grams butter~02. 4 piece cashewnuts~03. 1 springs coriander leaves~04. 1 tbsp coriander pdr~05. 1/2 tsp Crushed fenugreek leaves~06. 1/2 tsp cumin seeds~07. 100 ml Fresh cream~08. 1 tsp Ginger garlic paste~09. 2 slice green chillies~10. 2 tbsp oil~11. 1 number onion~12. 500 grams Raw chicken slices~13. 1 tsp Red chilli powder~14. to taste Salt~15. 1/2 tsp Sugar~16. 200 grams Tomato~17. tomato ketchup', '01. cut chicken into thin slices and apply ginger garlic paste ,salt ,chillipdr and shallow fry in oil and set aside~02. to the leftover oil add ,cumin,onion,ginger garlic paste , add onion ,tomatoes, cashewand other spices and cook covered with little water till everything is mashed up~03. put it in a blender and add to hot melted butter and cook on a medium flame season ,color and add chicken and cook for few more minutes~04. tomato ketchup is optional and usually use in 2 min butter chicken which i will show in near future'),
(13, '01. ginger garlic paste Â½ ts~02. Garam masala Â½ ts~03. Pepper corn powder Â½ ts~04. Chilly paste 1 ts~05. Salt~06. Coriander chopped Â½ b~07. Curry leaves chopped 2 sp~08. Oil for deep fry~09. All purpose flour 3 ts~10. Corn starch 4 ts~11. Cauliflower (medium size) 1 n', '01. Take cauliflower florets blanch them in hot water for 1 minute.~02. Take a bowl add salt, ginger garlic paste, garam masala, chopped coriander, chopped curry leaves, red chilly paste, pepper powder, all purpose flour, corn starch, add water mix it like a thick batter, pour this batter on to the cauliflower, coat with the mixture to the cauliflower and deep fry them twice. (Green chilly and curry leaves also deep fried along with cauliflower), then serve this hot.'),
(14, '01. 1/2 tsp Aji no moto(MSG)~02. 2 lbs Chicken-dark meat(boneless thigh meat)~03. 1/2 bunch Coriander leaves-chopped~04. 2 tsp Cornflour~05. 1/2 tsp each tsp Cumin seeds Pepper powder chilli powder salt~06. 4-5 number Curry Leaves chopped~07. 1 number Egg~08. 1 tsp Garlic chopped~09. 1/2 tsp Ginger chopped~10. 2 tsp Ginger Garlic paste~11. 4 5 number Green Chilli~12. to fry Oil~13. 2-3Drops Red color', '01. To make the fried chicken pieces Take chicken pieces in a non reactive bowl-(We use dark meat so that it is nice and juicy when fried).~02. Add salt, Aji-no-moto,1 tsp ginger garlic paste, pepper powder-pinch, cornflour and mix-Then add 1 egg and mix in completely-(Egg coats the meat and keeps the juices in)~03. Heat oil in a frying wok or kadhai-Add chicken pieces few at a time(Do not crowd the kadhai) and fry until lightly golden brown-Drain and remove on a paper towel~04. To make the sauce This does not need to be very salty-so control salt Heat 2-3 tsp oil in a pan-Add cumin, add the chopped ginger and garlic and suate until fragrant-Add chopped chillies, curry leaves,1 tsp ginger/garlic paste, remaining pepper powder, chilli powder, salt,chilli/garlic paste, aji-no-moto, red color and mix-Cook for a few minutesAdd a little water and then add chicken to this paste and toss lightly-Stir in the coriander leaves and serve'),
(15, '01. 200 grams channa~02. 25 grams channa masala pdr~03. 1 springs coriander leaves~04. 1 pinch cumin~05. 1 tbsp ginger garlic paste~06. 2 number gr chillies~07. 1 number lime~08. 3 tbsp oil~09. 2 number onion~to taste salt~10. 2 number tomatoes~11. 1 pinch turmeric~12. few piece whole garam masala', '01. Soak chana in water overnight or to cook the same day soak them in warm water for at least 5-6hrs~02. Pressure cook chole~03. Drain the chole, reserve the liquid ~04. Chop up onion, tomatoes~05. Heat oil in a deep saucepan and add cumin seeds whole garam masala.~06. When the cumin seeds change color add chopped onion to it and saute till they are brown~07. Add the Ginger-garlic paste to it and saute for couple of minutes~08. Add all the tomatoes dry powders to it and saute add salt~09. Saute the tomatoes till they are soft and mushed up~10. .Add the chana to the mixture and mix gently so that chole are properly coated in the mixture~11. Add the reserved water depending on the gravy you need, check and adjust the seasoning~12. Simmer the stove and cook covered for 5-6 minutes and garnish it with cilantro leaves~13. Serve it with bhature, puri or chapatti with sliced onion and lemon wedge by the side'),
(16, '01. pinch Aji no moto(MSG)~02. 2 tbsp Breadcrumbs to coat~03. 5 number chicken wings frenched~04. 1 tbsp Chilli garlic sauce~05. Crushed 1 Egg-beaten~06. 1 ginger garlic~07. Curry leaves~08. 1/4 lbs Ground Chicken/Paneer~09. to fry Oil~10. to taste salt~11. herbs~12. chilli~13. soy sauce', '01. Prepare the chicken wings by turning inside out-Each wing can be made into 2 lollipops-One portion closer to the shoulder(Meatier portion) and another portion away from the shoulder (Remove the second small bone~02. This is the less meaty portion and can be stuffed so the presentation looks nice Prepare stuffing~03. Season chicken mince with paneer mixed in, salt,chilli powder,herbs, green chilli and stuff the smaller lollipops with this mixture~04. Now we can season the prepared lollipops with few dashes,soy sauce, chilli/garlic paste,ginger/garlic paste and marinate for some time Prepare batter~05. Mix in chilli powder, chilli/garlic sauce,salt, cornflour to the beaten egg Heat oil to medium heat(the lollipops need to cook completely inside hence, oil should not be too hot or else outside will brown too quickly leaving the insides uncooked)~06. Roll the lollipops in the batter and bread crumbs,drop gently into the oil and fry to a golden brown-not dark brown The Lollipops can also be made without batter/bread crumbs~07. Just fry them till golden brown~08.  These lollipops can be served with a quick sauce made as below Saute in some oil-cumin and crushed ginger/garlic until fragrant-Add curry leaves,soy sauce,green chillies chopped,coriander leaves chopped and Aji no moto-Toss in the fried lollipops and serve immediately'),
(17, '01. 1 tsp caswhnut~02. 1 number chicken~03. 4 number chilli~04. 1 cup coriander leaves~05. 1 tsp coriander powder~06. 1 tbsp cream~07. 1/2 tsp cumin powder~08. 1/2 tsp cumin seeds~09. curd~10. 1 tsp ginger garlic~11. 1 number lemon~12. pinch methi powder~13. 1 number onion~14. as per taste red chilli powder~15. 1 number red pepper~16. as per taste salt~17. 1 number tomato~18. pinch turmuric', '01. take bone less chicken but cut into small pieces.and also vegetables, onions,bell peppers.~02. In a blender add tomato,cashwnuts and blend it.~03. Take a bowl add turmuric,chilli powder,coriander,gingergarlic,methi,curd,lime juice,salt,oil mix it and use half of this marinate to vegetables and half to chicken mix well and keep aside for 1 hr.~04. After one hour grill chicken and vegetables till they are half cooked.~05. Take a pan add oil,garama masala,cumin seeds,chopped onion finely,salt cook slowly add turmuric,gingergarlic,cumin,coriander,chilli powder,little water mix well add tomato paste which was blended mix well close it with a lid for 5 min.~06. Now add the cooked chicken and vegetables let it cook for 2min,add cream optional,add coriander leaves chopped.'),
(18, '01. pinch ajinomoto~02. 1 tsp chilli garlic sauce~03. 1/2 tsp coriander powder~04. 1 1/2 tbsp Corn flour~05. 1/2 tsp cumin seeds~06. 7 number curry leaves~07. 1 number egg~08. 1 tsp garlic chopped~09. 1/2 tbsp ginger garlic paste~10. 4 number green chillies~11. 1 tsp lime juice~12. 1 tbsp maida~13. for fying oil~14. 1/2 cup onion~15. 1 lbs paneer~16. 1 cup red bell pepper~17. as per taste salt~18. 1 tsp soya sauce~19. as needed water~20. 1 cup yellow bell pepper', '01. Cut paneer into cubes.~02. Take a dish add salt,ginger garlic, water,egg and mix well and pour on the cubes mix well and add maida.~03. Take oil to fry add the mixed paneer into it and fry in very slow flame.~04. Take a pan add oil cumin,garlic,ginger garlic paste,chopped green chilli,onion,coriander powder,little water,chill garlic sauce,ajinomoto,red bell pepper,yellow ,chilli powder,soya sauce,curry leaves,salt,lime juice, if you want to add colour u can, now add paneer and mix well'),
(19, '01. 20 grams cashew nuts~02. 1 piece chopped ginger~03. 1 springs chopped coriander~04. 2 piece chopped gr chilli~05. 1 tbsp cumin~06. 1 springs Curry leaves~07. 15 grams dahlia~08. 1 number grated coconut~09. 1 pinch hing Asafoetida~10. 1 tsp mustard~11. 2 tbsp oil~12. 3 piece red chill~13. 1 pinch salt~14. 1 pinch tamarind~15. 1 tbsp black gram''', '01. mix all ingredients coconut ,ginger ,gr chillies,dhalia, cashew,tamrind, salt and put in a blender to fine paste~02. make tempering or tadka in hot oil add mustard , red chilli ,cumin,urad dal hing , curry leaves and top it on chutney and serve with dosa ,Idli or any south Indian breakfast'),
(20, '01. 250 grams Black grams~02. 60 grams butter~03. 1 tbsp coriander pdr~04. 1 cup cream~05. 1 tsp cumin~06. 1 tsp garam masala whole or pdr~07. 2 tbsp Ginger garlic paste~08. 50 grams kidney beans~09. 1 tbsp oil~10. 10 grams Red chilli powder~11. to taste Salt~12. 5 number tomatoes pureed~13. 1 piece turmeric', '01. Thoroughly wash black grams, bengal grams and kidney beans. Then soak it in water (2 glasses) for about few hours . and cook till dal is cooked to mashable consistency~02. heat oil in a heavy bottom pan.~03. add cumin ,garam masala(optional) ,you can skip garam masala and add little garam masala pdr at last~04. Add ginger-garlic paste ,turmeric and add tomato puree and cook well for 10 min in medium flame covered~05. Add chilli powder, and salt. Cook until the mixture thickens into pulpy sauce (about 3 mins)~06. Then add cooked grams and kidney beans to the mixture. Heat for 4-5 minutes. You can add a little water if you find it too thick.~07. Add the remaining butter and cream and cook for 10 minutes.~08. Dal Makhani is ready to serve. you can increase the dal to tomato ratio if you want'),
(21, '01. 2-3 grams baby potato~02. 2-3 number cardamom~03. 2-3 number cloves~04. 1 springs coriander leaves garnish~05. 1 tbsp coriander seeds~06. 1/2 tbsp cumin seeds~07. 100 grams curd~08. 1 tbsp fennel pdr~09. 1/2 tbsp garam masala pdr~10. 1/2 tbsp garlic paste~11. 1/4 tbsp ginger pdr~12. 1 tbsp oil~13. 1/2 tbsp red chilli powder~14. to taste Salt~15. 1/2 tbsp turmeric powder', '01. boil the potatoes and peel them properly. Now prick the peeled potatoes all over with a fork~02. heat oil add cumin ,garam masala whole ,chopped garlic mix all spice pdrs with little water and add to the mixture~03. Mix curd, Simmer~04. add potatoes for about 20-25 minutes and your Kashmiri dum aloo dish is ready to be served.~05. i added little pdr of fried cashew nuts for my own variotion , since one has to develop taste for this recipe you may want to add tomatoes'),
(22, '01. 500 grams Basmati Rice~02. 1 tsp biryani masala pdr~03. 1 tsp black cumin~04. 6 tsp Clarified Butter~05. 8 number Eggs~06. 1 tsp fried onion~07. 1 tsp Fresh Coriander/Cilantro Leaves~08. 1 tbsp Ginger garlic paste~09. 4 number Green Chillies~10. 1 bunch mint~11. 1 tbsp oil~12. 1 large Onions~13. 2 cup Plain Yogurt~14. to taste Salt~15. 10 number whole garam masala', '01. Wash and soak rice for at least Â½ hour.~02. boil eggs~03. Shell the boiled eggs and give four long cuts on the white portion of each egg without separating it.~04. In a kadai or pot, heat the clarified butter or oil. And spices and fry the onions until they become golden brown and add ginger garlic paste ,gr chillies ,mint coriander ,biryani masala and curd and cook~05. In the same masala measure 1 1/2 times the amount water to rice and bring it to boil~06. add soaked rice and mix well and cook covered till rice is done~07. Then add red chilli powder, salt and eggs,beans and fry until the eggs get coated with the spices. Remove the eggs and set aside.~08. When the air holes appear on the rice surface, reduce the stove heat to low. Cook until all of the water has absorbed and the rice is tender.'),
(23, '01. 1 tsp chilli pdr~02. 3 piece chopped chilli~03. 3 number chopped onion~04. 1 tbsp coriander pdr~05. 1 tsp cumin~06. 1 tsp cumin pdr~07. 3 springs curry leaves~08. 10 number eggs~09. 1 tsp fenugreek leaves~10. 1 tbsp ginger garlic paste~11. 1 tsp mustard seeds~12. 3 tbsp oil~13. to taste salt~14. 100 ml tamarind juice~15. 1 pinch turmeric', '01. Heat oil in a vessel and mustard seeds and let them splutter. Now add methi seeds, cumin and add onions curry leaves and fry Add chopped onions and green chillies and fry till they turn light brown.~02. add ginger garlic paste~03. Now add chilli pwd, turmeric pwd, coriander pwd and cumin pwd, mix well and saute for few seconds~04. Add tamarind extract and 2 cups of water and bring to a boil. Add salt and sugar and reduce heat and let it simmer for 10 mts. Add the boiled and fried eggs and let it cook in the gravy for 3 minutes or till you get the required gravy consistency.~05. Garnish with chopped coriander leaves. Serve this hot steamed rice or rotis'),
(24, '01. Almonds(without skin) 6-7~02. Melon seeds 1 tsp~03. Cashew nuts 9-10~04. Poppy seeds 1 tsp~05. Fried onions 1 tbsp~06. Oil 1 tbsp~07. Bay leaf 1~08. Cloves 3-4~09. Cardamom 1\\r\\n~10. Cinnamon 3-4~11. Cumin seeds 1 tsp~12. Ginger garlic paste 1 tbsp~13. Tomato puree Â¼ cup~14. Coriander powder 1 tsp~15. Cumin powder Â½ tsp~16. Turmeric 2 pinch~17. Red chilly powder 1 tsp~18. Salt to taste~19. Curd 3 tbsp~20. Boiled eggs 4', '01. Boil almonds(without skin), melon seeds, cashew nuts and poppy seeds in hot water for 15 min.~02. Once it is boiled take it in a blender with fried onions and blend into a fine paste.~03. In hot oil add bay leaf, cloves, cardamom and cinnamon. When it sizzles add cumin seeds, ginger garlic paste, tomato puree, blended paste, coriander powder, cumin powder, turmeric, red chilly powder, salt and mix it well.~04. Once it starts boiling add curd and let it cook for 25 min with a lid on it.~05. Now in a hot oil add boiled eggs with gashes on it.~06. When the eggs sizzle take out the oil and sprinkle some salt and red chilly powder on it.~07. Toss it properly and keep adding red chilly powder and salt on it.~08. Take the gravy in a plate and and place the eggs and egg pieces with some more gravy on it.~09. Garnish with coriander leaves and serve hot'),
(25, '01. 5 grams chillipowder~02. 1 piece chopped chilles~03. 1 springs coriander leaves~04. 10 grams coriander pdr~05. 1 springs curry leaves~06. 4 piece fish~07. 10 grams gingergarlic paste~08. 5 piece lemon Juice~09. 10 ml oil~10. 1 pinch turmeric', '01. marinate fish with all the ingredients~02. and cook on medium heat both the sides'),
(26, '01. 500 grams Basmati rice~02. 1 tsp black cumin~03. 2 number boiled egg for decoration (optional)~04. 50 grams Cashew nuts (Optional)~05. 1 bunch coriander leaves~06. 2 cup Curd~07. 2 tbsp garam masala~08. 2 tbsp Garam masala powder~09. 2 tbsp Garlic and ginger paste~10. 2 cup Golden fried sliced onions~11. 3 number gr chilli~12. 2 number Lime juice~13. 1 tsp meat tenderizer~14. 1 bunch mint~15. 1000 grams Mutton~16. 5 tbsp Oil~17. 1 tbsp Red chilli pdr~18. 1 tbsp Rose Water (optional)~19. 1 pinch Saffron~20. 1 to taste Salt~21. 1 pinch Turmeric powder', '01. First boil the water ,add oil, salt and cook rice half cooked.~02. Next maranation of mutton, in pan take mutton, add all the spices and curd, onion~03. Now n a pan add the maraniated mutton in the bottom and top it of with half cooked rice,add mint leaves, coriander leaves, fried onions.repeat the same process twice.cook for 30mins~04. serve hot with raita and mirchi ka salan , follow the video recipoe of bagara baingan , make a thinner gravy ,substitute brinjal,eggplant with green chillies'),
(27, '01. 30 grams cornflour~02. 1 cup curd~03. 1 tsp lemon juice~04. 100 grams Maida~05. 1 tbsp Oil~06. fry 0 Oil~07. pinch saffron colour~08. 1 cup sugar~09. as needed water', '01. Take a bowl add curd mix well then add maida,cornflour mix well to avoid lumps then add food colour,Hot oil and mix again.~02. Batter should be pouring consistency set a side for 24hr to ferment.~03. Take a bowl add sugar,water to make sugar syrup of 1 thread consistency add lime juice few drops in the syrup and keep it a side.Lemon juice is to prevent crysalization so just few drops~04. Heat oil to fry jalebi, take a Ziplog bag make a hole and pour the batter so that it can pass through.~05. press the batter in the hot oil fry at a very low flame till golden brown colour.~06. Remove from the oil drain the oil, immediately dip in the sugar syrup for a min and remove in a plate.~07. Serve hot'),
(28, '01. 1 cup basmati rice~02. 1 tbsp butter or oil~03. 1/4 bunch coriander leaves~04. 1 tsp fried onion~05. 2 number gr chilli~06. 1 tsp cumin~07. 1/4 bunch mint~08. 1 pinch saffron color~09. to taste salt~10. 2 cup water', '01. heat oil in a pan nadd cumin ,gr chilli , mint and coriander fry add water twice the amount of measured rice~02. bring the water to boil add salt~03. add pre soaked rice bring it to boil till 90% of water is absorbed add fried onion and saffron color~04. and reduce the flame to minimal and cook covered for 5 more min and you will have awesome jeera rice'),
(29, '01. 1 tsp Browned grated Copra powder~02. 1/2 tsp Coriander powder~03. few leaf Curry leaves~04. pinch Garam masala powder~05. 1/2 tsp Garlic cloves crushed~06. 2-3 number Green chillies chopped~07. pinch Hing (asafoetida)~08. 1 cup Kala Vatana/ Black Channa boiled~09. 1 tbsp Oil~10. 1 number Onions chopped~11. 1 tsp Red chilli powder~12. Salt to taste~13. 2 number Tomato chopped~14. 1/4 tsp Turmeric powder', '01. Soak kala vatana overnight, boil and keep aside.~02. Heat oil in a hot pan and when the oil gets hot, add chopped onions, salt and cook them till they turn golden in colour.~03. Add curry leaves, chopped green chillies, and mix.~04. Once the onions turn golden in colour, add crushed garlic and chopped tomatoes and mix. Reduce the flame and add hing, turmeric powder, coriander powder, cumin powder, red chilli powder and pinch of garam masala.~05. Add 1 cup kala vatana (soaked overnight and boiled), mix well and bring to a boil.~06. Cover and cook on low flame for about 5-10 minutes.~07. Add 1 tsp browned grated dry coconut, mix and just cook for a minute and switch off the flame.'),
(30, '01. 1/2 cup Coconut milk~02. 1 bunch Coriander leaves chopped~03. few leaf Curry leaves~04. 6-8 piece Fresh Bombay duck fish cut into two halves~05. 1/2 tsp Garlic cloves crushed~06. 1/2 tsp Ginger crushed~07. 1/2 tsp Green chillies crushed~08. 2 tbsp Kokum water~09. 1/2 cup Malvani ground masala paste~10. 2 tsp Malvani Masala dry powder~11. 2 tbsp Oil~12. Salt to taste~13. 4-5 piece Triphad spice~14. 1/4 tsp Turmeric powder~15. Water as needed', '01. Heat oil in a hot pan and add few curry leaves, crushed garlic, ginger and green chillies.~02. SautÃ until the raw flavour are gone.~03. Reduce the flame and add Malvani masala powder, turmeric, Malvani masala paste and 4-5 pieces of triphad spice and mix.~04. Add little water, salt to taste to the spices and mix.~05. Add very little kokum juice, cover and cook this on a slow flame for about 5 minutes. After 5 minutes, add the fresh Bombay duck or bomli fish pieces, cover and cook over a slow flame for 3 minutes.~06. Add coconut milk and simmer for a minute.~07. Do not mix the fish too much as they are very delicate and would break.~08. Sprinkle some coriander leaves and switch off the flame.'),
(31, '01. 1 springs chopped coriander~02. 1 number chopped onion~03. 1 tsp coriander pdr~04. 1/2 tsp cumin~05. 1 tsp cumin pdr~06. 1 pinch garam masala whole or pdr~07. 4 piece garlic~08.  1 tsp ginger garlic paste~09. 1/2 piece lemon juice~10. 1 pounds mushroom~11. 1 tbsp oil~12. 1 pinch pepper~12. 1 to taste red chilli~13. 1 to taste salt~14. 1 number tomatoes~15. 1 pinch turmeric', '01. Heat oil in a pan , add whole garam masala, cumin seeds and when they crackle add chopped onions ,salt turmeric ginger garlic paste and cook~02. add curry leaves and chopped gr chillies~03. add tomatoes and cook for few min and add mushrooms and cook till they are soft~04. in another pan add butter. add crushed garlic, pepper,cumin seeds mixture to add coriander pdr  and cumin pdr add the cooked mushroom mixture and cook till the moisture evaporates and dry~05. finish with lemon juice and chopped coriander leaves'),
(32, '01. 1 cup Gram flour~02. 6 number Green chillies~03. to taste Oil~04. 3 number Onions~05. to taste Salt ', '01. Chop onions (length-wise) and green chillies.~02. Make batter with gram flour.~03. Mix onions and green chillies in batter along with salt.~04. Heat oil in a pan.~05. Pour a spoon of the batter into the hot oil and fry the bajjis.~06. Drain on a paper towel.'),
(33, '01. 1 cup Atta (Wheat Flour)~02. 1/2 tsp chatmasala.~03. 1 tsp chilli powder~04. 1 bunch coriander leaves~05. 1/2 tsp cumin powder~06. 3 number green chillis~07. 1 cup maida~08. to fry 0 Oil~09. 1 cup onions~10. 1 cup poha~11. as needed 0 salt~12. as needed 0 water', '01. Take a bowl add maida,atta,salt, 1 tsp oil mix well then add water to make a soft dough rest it for 10min.~02. Now in another bowl,take onions chopped,poha,chilli powder,cumin powder,green chillis chopped,oriander ,chat masala mix well.~03. In a small bowl add 1tsp of maida mix with some water and make a paste keep a side.~04. Now take the dough make a thin chapaties and take a pan slightly cook the chapatis both the sides do not cook more.~05. Once chapaties are ready cut the chapati sheets into long triangle shape.~06. Now apply maida paste one side of the sheet make a cone shape stuff the mixture in the cone then close the edge.~07. In a pan add oil to deep fry, first half fry and remove then after 5min fry again till golden colour'),
(34, '01. 1 tbsp coriader powder~02. 1 tbsp cream fresh~03. 1 tsp cumin powder~04. 2 number Dry garam masalas~05. 1 tbsp fenugrek leaves~06. 5 number garlic~07. 1 tbsp ginger garlic paste~08. 2 number Green Chili~09. 1 number onion~10. 5 number palak~11. as per taste red chilli powder~12. as per taste salt~13. 3 number tomato', '01. Clean and wash spinach and immerse in boiling water for 2 min mash it in a mixer or some prefer to chop and use.~02. Heat oil in a deep pan. . add whole garam masala Now add onions and fry till golden brown.~03. add turmeric and ginger garlic paste Add all spices and red chili powder.~04. Now add the spinach (palak) and cook till it oozes out oil. Cut paneer into pieces some use it fried , if you have fresh paneer just add Add Paneer pieces to the gravy and simmer in for few min adding garlic slices is optional , some prefer to grind green chillies with spinach top with little cream ( optional).'),
(35, '01. 1/2 cup Maida (all-purpose flour)~02. 1 tbsp Oil and Oil for deep frying~03. Salt to taste~04. 1 tbsp Sooji/ Semolina~05. 1/2 cup Spinach puree~06. 2 tbsp Water~07. 1 cup Wheat flour', '01. Wash and chop palak. Grind palak in a blender and turn it into a fine paste.~02. In a bowl, add sooji, little water, oil, salt and mix well.~03. Add wheat flour (atta), maida, and spinach puree, mix all of these together to make a tight/tough dough, add water only if needed.~04. Divide the dough into lemon sized balls and roll each of them by dusting some flour or with oil into small puris with a rolling pin.~05. Heat oil in a kadai. When the oil is hot enough, fry all the puris one by one from both the sides until they turn slightly brown in colour and get puffy.'),
(36, '01. 1 pinch chopped ginger~02. 1 pinch chopped gr chilli~03. 1 small chopped onion~04. 1 pinch cumin~05. 1 tsp ghee,butter or oil~06. 1/4 cup maida~07. 1 pinch pepper crushed~08. 1 cup rice flour~09. 1 to taste salt~10. 1 cup sooji,rava,semolina', '01. mix all ingredients as shown add water (or buttermilk) and make thin batter and sprinke over hot griddle if it is not a non stick pan.~02. spray non-stick spray ,wipe clean and sprinkle the batter and apply butter or oil serve hot with pickle ,chutney , use potato stuffing.'),
(37, '01. 1 number potato~02. 3 cup maida or all purpose flour~03. 3 tsp of oil (1 tsp for 1 cup of flour)~04. 1/4 tsp of carom seeds or ajwain~05. salt to taste~water to knead the dough~06. 2nu potatoes boiled and diced~07. 1 tblsp ginger garlic paste~08. 1/4 tsp tumeric~09. 2 to 3 green chillies finely chopped~10. coriander leaves chopped~11. cumin powder~12. coriander powder~13. red chillie powder~14. chat masala~15. 2tbsp cashew nuts~16. 1/2 tsp cumin seeds~17. salt to taste~18. lime juice of 1/2 lime and oil', '01. For the dough Take the maida,add the ajwain seeds,salt and oil to the maida and mix well by mixing well each flour grain will be coated with the oil and it gives the cruncy texture to the samosas.Start adding water little by little and kneading properly make a stiff dough and let it rest for 15 to 20 mins.~02. Potato stuffing Heat some oil in the pan,add the cumin seeds,ginger garlic paste,green chillies. cashewsand turmeric mix well and let cook for few mins.the add the red chillie pwdr coriander pwdr and cumin pwdr.add little water so the masalas don''''t burn. then add the diced potates,salt and coriander leaves.sprinkle the lime juice over it. you can make any stuffing of ur choice with any variations.~03. Samosa make rolls of the dough depending on the size of samsosa you want. roll the dough in circle first and then make them oval in shape.cut that oval shape into half.take that half apply water on all edge,take one end bend it in canter and taking other end overlap it on the first edge making it a triangle or cone.fill the cone with the stuffing and seal the edges to get a triangular shape for the samosa.~4. Samosa using spring roll sheet take 2 spring roll sheet and cut them in centre.take the half sheet which is 2 ply apply water on the sheet or egg wash and make a cone of it,stuff it with the stuffing and seal the cone using water or egg wash making it triangular in shape.~5. Now fry the samosaos in the oil till they turn golden brown.the samaso with the dough requires oil temp., of @ 300''''F while the spring roll samosas require higher temp., of 350 ''''F.'),
(38, '01. 1 to taste chat masala~02. 6 number chicken legs~03. 1 tsp Coriander Powder~04. 1 tsp Cumin Seed Powder~05. 1 tsp garam masala pdr~06. 1 piece Ginger garlic paste~07. 1 tsp kastoori methi (dry fenu greek leaves)~08. 1 tbsp Lemon Juice~09. 2 tbsp oil~10. 1 tsp Peppercorns pdr~11. 1 tsp Red Chili Powder~12. 1 tsp red color~13. 1 tsp Salt~14. 1 tsp turmeric~15. 6 tbsp Yogurt', '01. Clean and Cut 2 or 3 long slits on each piece. Apply salt ,chilli pdr and lime juice all over the chicken and keep aside for 15 minutes.~02. kemarination with coriander powder, cumin powder, red chilies, kastoorimethi ,turmeric garam masala pdr red color to a smooth paste. Add 1/2 tsp salt to the paste and mix well with yogurt.~03. apply it all over the chicken, making sure to apply well between all the slits and in~04. Preheat your oven to 425 degree Fahrenheit. Cook for 20 to 35 minutes till the chicken is tender. Remove from oven.~05. Remove from oven and serve hot, garnished with sliced onions and lime wedges.and also can be heated on griddle if serving later'),
(39, '01. 1 tbsp broken cashewnuts~02. 1/2 tsp channa dal~03. 1 to taste chilli pdr~04. 1 piece chopped ginger~05. 2 piece chopped gr chilli~06. 4 cup cooked rice~07. 1 pinch cumin~08. 1 sprigs curry leaves~09. 1 pinch garam masala pdr~10. 1 tbsp ghee oil~11. 1 pinch hing (optional)~12. 1 pinch mustard~13. 1/2 number onion~14. 3 piece red chilli~15. 1 to taste salt~16. 3 numbe tomato~17. 1/2 tsp urad dal', '01. Heat some oil and add the red chillies,mustard ,cumin.and hing, add channadal ,urad dal and broken cashew nuts and add hing~02. When they turn color, add the chopped onions and fry them till they turn transperent~03. add chopped gr chilli and curry leaves and tomatoes~04. Fry for 5 minutes.Add any spices and keep frying for a minute.~05. Add the boiled rice and adjust the seasoning'),
(40, '01. pinch asafoetida~02. 1 number boiled potato~03. 2 tsp cumin powder~04. to taste grated coconut and chopped coriander leaves~05. 2-3 number green chilies~06. to taste lemon juice~07. 1 tsp mustard seeds~08. 2 number onion~09. to taste Pav (Indian bread)~10. 2-3 tsp red chili powder~11. to taste salt~12. 1 tsp turmeric powde~13. 2 cup white peas (soaked for 5-6 hrs)', '01. Soak white peas for 5-6 hours and boil them with enough water.~02. Chop onions and green chilies.~03. Heat some oil in a pan. Add mustard seeds, asafoetida, turmeric powder and then half of the chopped onion pieces.~04. Saute onion pieces till they turn brown, add boiled peas and water.~05. Cover and cook till the gravy thickens slightly.~06. Now add cumin powder, chili powder, salt. Stir and cook for some time. Remove from the heat.~07. Garnish with coconut and coriander leaves and some chopped onion. Serve with pav.'),
(41, '01. 1 tsp ajinomoto~30 grams beans~02. 1 cup boiled rice~03. 100 grams cabbage~04. 2 number capsicum pepper~05. 150 grams carrots~06. 50 grams cauliflower~07. 2 piece celery~08. 3 tbsp chilli paste~09. 3 piece choppe gr chillies~10. 30 grams chopped garlic~11. 3 tbsp corn flour~12. 1 large ginger~13. 1 to fry oil~14. 2 number onion~15. 2 tsp pepper pdr~16. 1 to taste salt~17. 2 tbsp sesame oil~18. 4 tbsp soya sauce~19. 1 springs spring onion~20. 1 tsp sugar~21. 3 tbsp sweet and sour sauce', '01. Boil /steam finely chopped minced vegetables and bind with some corn flour and rice with all shown spices and make small lumps the size of a ping pong ball.~02. roll in corn flour and deep fry make sauce as shown add cumin ,2 tbsp chopped garlic ,1 tbs chopped ginger and chopped onion add soya sauce,pepper,chilli paste,spring onion ,ajinomoto sweet sauce or sugar stock~03. and cook thicken with cornflour mixture adding very little at a time add fried dumpling or cauliflower Serve hot with noodles or rice.'),
(42, '01. 750 grams Chicken~02. 2 tbsp coconut grated fresh~03. 2 springs coriander leaves~04. 1 tbsp coriander pwd~05. pinch 0 cumin seeds~06. 2 springs curry leaves~07. pinch 0 garamasala pwd kerala~08. 1 tbsp ginger sliced~09. 4 number green chillies~10. 2 tbsp oil~11. 3 number onion shallots~12. 1 tsp pepper pwd~13. 1 tbsp red chilli powder~14. as per taste 0 salt~15. pinch 0 turmuric ', '01. Take chicken clean and marinate with chilli pwd, salt, coriander pwd, turmuric, gingergarlic paste mix well and keep a side for 4hrs.~02. Now take a pan add oil, cumin seeds, shallots sliced then add curry leaves mix well then add grated coconut mix now add the marinated chicken mix well and close it with a lid and cook till the chicken is done.~03. Once the chicken is 90% done add pepper pwd, green chillies, garamasala kerala mix and cook till the chicken is dry do not cover with lid now.~04. once the chicken is dry or roast top '),
(43, '01. Chickpeas soaked overnight and boiled 1 cup~02. Oil 2 tbsp~03. Rice  2 cups~04. Onion finely sliced 1 big~05. Green chilies 4-5 nos~06. Bay leaves  2-3 nos~07. Fennel seeds  1 tsp~08. Mustard seeds  1 tsp~09. onion seeds 1 tsp~10. Cumin seeds  1 tsp~11. Fenugreek seeds  ½ tsp~12. Garam masala freshly ground  2 tbsp~13. Hing  a pinch~14. Ginger garlic paste  1 tbsp~15. Haldi powder  ¼ tsp~16. Mustard powder  1 tsp~17. Chili powder 2 tsp~18. Mango achaar 2 tbsp~19. Salt to taste~20. Mint leaves~21. Coriander leaves finely chopped', '01. take a pan and add some ghee. When the ghee gets hot, add bay leaves, mustard seeds and when they crackle, add fennel seeds, kalonji, cumin , fenugreek seeds~02. and fry till you get a nice aroma lingering around the room.~03. Add coarsely crushed garam masala, sliced onions and sauté the onions are transparent.~04. Add salt, green chillies, hing, turmeric, ginger garlic paste, cook well until the raw flavours are gone.~05. Add garbanzo beans and cook in this masala.~06. In a separate bowl take some yogurt, add mustard powder, coriander powder, chilli pd, mango achaar and mix well.~07. Mix this yogurt spice into the channa masala and mix well. Add the soaked basmati rice (soak rice for at least 1-2 hours and drain the water off). Spread the rice evenly over the channa masala and pour about 4 cups of water for 2 cups of rice and add salt, finely chopped mint leaves and coriander.~08. Cover the pan with a lid and cook over slow flame till the rice is cooked and done.~09. Once done, serve piping hot.'),
(44, '01. Paneer 250 g~02. Red chilly 4 n~03. Yogurt ½ cup~04. Cumin seeds ½ ts~05. Mustard seeds ½ ts~06. Fenugreek seeds ¼ ts~07. Tomatoes 2 n~08. Bell pepper 1 n~09. Oil 1 tb~10. Onion chopped 1 no.~11. Salt to taste~12. Turmeric pinch~13. Ginger garlic paste 1 ts~14. dil leaves 1 bunch~15. coriander powder 1 ts~16. vinegar ½ ts~17. sugar 1 ts', '01. Heat a pan add red chilly, cumin seeds, mustard seeds, fenugreek seeds, dry roast this and put it into the blender and make a powder, in this add tomato, bell pepper make a paste.~02. Heat oil in a pan add chopped onions, salt, cook the onions till golden in colour, add turmeric, ginger garlic paste, sauté it and add dill leaves (optional) mix it well~03. and add the prepared achari masala, coriander powder, mix it well cook this till oil is oozes out and add yogurt, water, mix it~04. and add vinegar, sugar, cook this till oil oozes out add fried paneer cook this some time and serve this hot.achari paneer is dish made with flavor of pickle'),
(45, '01. Mint chopped 1/2 Bunch~02. Coriander chopped 1 Bunch~03. Chat masala 1 Teaspoons~04. Red chilly powder 1 Tablespoons~05. Green chilly chopped 2 Numbers~06. Onion chopped 1 Numbers~07. Garbanzo (Kabuli chana) 1/2 Cup~08. Potato 2 Numbers~09. Lime juice 1 Teaspoons~10. Salt To Taste~11. Sweet tamarind chutney 2 Tablespoons~12. Pomegranate seeds 3 Tablespoons~13. Cumin powder 1 Teaspoons', '01. Take a bowl add potato, (boiled and cut them into pieces) and garbanzo(boiled), in this add chopped onions, chopped green chilly, red chilly powder, chat masala powder, chopped coriander, mint, lime juice, salt, sweet tamarind chutney, and add pomegranate seeds~02. add freshly roasted powder of cumin seeds, mix all of together.'),
(46, '01. Potato 5 n~02. Yogurt 1 c~03. Cumin seeds 1 ts~04. Mustard seeds 1 ts~05. Hing~06. Turmeric~07. Salt~08. Chilly powder 2 tb~09. Coriander leaves 1 b~10. Oil (mustard & regular) 2 tb ', '01. First boil the potatoes and sauté in oil.~02. Heat half & half of regular & mustard oil in a pan, crackle mustard seeds, cumin seeds, turmeric, hing, salt, and add chilly powder curd at a time. Then add potatoes (boiled and sauté in oil) add coriander leaves, give a boil & switch off the flame.~03. Serve this hot with rice, chapattis.'),
(47, '01. Potatoes (boiled and cut into cubes) - ¼ kgs~02. Green leaves of drumsticks - 1 cup~03. Mustard seeds - 1 tsp~04. Cumin seeds - ½ tsp~05. Urad dal - 1 tsp~06. Garlic, chopped - 1 tbsp ~07. Onion, chopped - 1 no~08. Salt - to taste~09. Turmeric pd - ¼ tsp~10. Coriander pd - ½ tsp~11. Chilli pd - 1 ½ tsp~12. Green leaves of drumstick - 1 cup~13. Tomato puree - 1 tbsp', '01. Add little oil in a pan.~02. When the oil gets hot, add mustard seeds and when they crackle, add in some cumin seeds, urad dal and fry a little till they get slightly browned.~03. Add some finely chopped garlic, onions and salt to taste.~04.  This helps in sweating out the onions and cook faster.~05. Once the onions get slightly brown, add turmeric powder, coriander powder, red chilli powder and the green leaves of drumstick.~06.  Fry the greens well until they get nicely dried and cooked.~07. Add a little tomato puree and fry well.~08. Finally add boiled and cubed potatoes and sauté well. Cover and cook for a few minutes.~09. Once done, remove and serve with roti, chapati or rice.'),
(48, '01. 1/2 tsp amchoor pd~02. 1 number cauliflower, cut into florets~03. 1 bunch chopped coriander leaves~04. 2 tsp coriander powder~05. 1 tsp cumin seeds~06. 1 tsp garam masala~07. 1 tsp ginger-garlic paste~08. 1 tbsp gr peas~09. 2 number green chilli~10. 1/4 cup oil ~11. 1 number onion~12. 4 number potatoes, cubed~13. 1 tsp red chili powder~14. to taste salt~15. 3 number tomatoes, chopped~16. 3/4 tsp turmeric powder', '01. Heat oil in a pan, saute cumin seeds, ginger-garlic paste for a minute and crushed tomato,onion and gr chilli and add turmeric cook till oil ozzes out add rest of spices mixed in water~02. add poatoes. and cauliflower~03. Also salt. Fry for few minutes.~04. Lower the heat, cover and simmer for about 15 minutes until the vegetables are cooked~05. serve hot with naan , chapati , roti'),
(49, '01. Spinach (palak) chopped ½ cup~02. Bay leaves 3 n~03. Cinnamon sticks 2 n~04. Cloves 3 n~05. Cardamom 2 n~06. Shahi jeera ½ ts~07. Green chilly paste 1ts~08. Ginger garlic paste ¼ ts~09. Mint & coriander chopped ½ bunch~10. Tomatoes 3 n~11. Yogurt ½ cup~12. Salt~13. Turmeric~14. Basmati rice 1cup~15. oil 1 tb~16. Fried onions ¼ cup', '01. Heat oil in a biryani handi, add bay leaves, cinnamon sticks, cloves, cardamom, shahi jeera, green chilly paste, ginger garlic paste, chopped mint, coriander, spinach, tomatoes, yogurt, salt, turmeric, cook it in a slow flame, add potato (peel the potatoes and cut them into small pieces and deep fry them.), cook it some time.~02. Take pan add water once come to boil add basmati rice (soaked in the water for 30 minutes) cook this 90% done. Take out the half of the potato masala in another bowl and spread the rest over masala in the handy, when rice is 90% cooked add rice layer to the top of the potato masala, then add potato layer, add fried onions, then add rice layer and again potato layer and rice layer, add ghee, fried onions, put the lid on and do not cook direct on the flame first put the tawa on the flame then put the biryani handi, cook this in a slow flame for 5 to 7 minutes.'),
(50, '01. 200 grams Chapati Atta~02. 1/2 tsp chat masala~03. 2 tbsp Cooking oil~04. 1/2 tsp cumin powder~05. 4 number Green chillies~06. 1/2 bunch Green coriander leaves~07. 1/2 tsp Lemon juice~08. 1 number Onion~09. 3-4 number Potato~10. 1 to taste Salt', '01. In one pan sieve 200 gms chapati atta. Add , cooking oil, and salt.~02. Mix it well.~03. Add mashed potatoes, onion, green coriander leaves, green chillies & lemon juice mix it.~04. Add little water to make a soft dough.~05. Keep a side for about 10 to 20 minutes.~06. Make frying pan (Tava) hot on medium heat.~07. Take small ball from dough and roll it in circular shape .~08. Place it on hot tava. When it gets little brown, apply oil or ghee.~09. Turn it and again apply oil or ghee on other side.~10. Keep turning simultaneously until it gets golden brown.~11. Tasty Aloo Parathas are ready.'),
(51, '01. 1 lbs arbi ( taro root)~02. 1 to taste chilli pdr~03. 1 springs curry leaves~04. 1 to taste salt', '01. boil arbi till they well cooked , drain and cool~02. peel them and cut into thin round les~03. fry in medium hot oil till golden brown and crisp~04. sprinkle fried curry leaves , chilli pdr and salt ,toss~05. serve crispy with many foods as accompaniment or just eat it like chips'),
(52, '01. 1 tbsp Amchoor powder~02. few coriander (chopped)~03. 1 & 1/2 tbsp Besan~04. 1/2 Lime~05. 1 lbs Okra~06. to taste Salt~07. 4 tbsp Sambar powder~08. 1/2 number Sliced onions', '01. Wash & dry tender okra.Cut the head & slit open halfway through okra.~02. For the filling :-In a bowl mix sambhar powder,amchoor powder,gram flour,salt , lime juice & few drops of water to make a thick paste. (Note:-Ratio of sambar powder & amchoor powder is 4:1 & add less amount of salt in the filling mixture)~03. Stuff mixture in the bhindi & set the nonstick pan on medium heat.~04. Arrange stuffed bhindis on the pan keeping the stuffed part upwards.Add one tbsp of oil on all the bhindis & sprinkle little water.Cover it & let it cook. (Note:- Oil is added to fry slightly the bhindis & water is added to steam them until cooked)~05. At small intervals of 3-4 mins continue sprinkling water & flip bhindi so it is cooked from other sides as well .Repeat the process three four times. (Note:- Make sure water is not added in excess to avoid running out of mixture)~06. When you notice bhindi is evenly cooked add sliced add onions,coriander leaves,little salt & chilli pwdr(optional) to it .Allow it to cook without the lid for 5 mins & saute well~07. Its ready to be served with rotis or rice');
INSERT INTO `recipe_details` (`recipe_id`, `recipe_ing`, `recipe_steps`) VALUES
(53, '01. Potatoes 4n~02. Garam masala 1 ts~03. Green chilly chopped 3 n~04. Coriander chopped 2 b~05. Red chilly powder 1 tb~06. Salt~07. Chat masala 1 ts~08. Onions chopped 2 n~09. Bread slice 2 n~10. Mint chutney 2 tb~11. Paneer grated 100 g', '01. Take a bowl add grated potato (boiled), garam masala, chopped green chilly, chopped coriander, red chilly powder, salt, Chat masala, chopped onions, mix this.~02. Take a bread slice spread the potato mixture; take another bread slice spread the mint chutney on this spread the grated paneer, now cover this potato bread with another slice of bread, to which both butter and chutney has been applied.~03. Put this on a grill the sandwich till browned from both sides.\r\nIt''s crisp from outside and spicy and soft from inside.~04. Serve this hot with tomato ketchup.'),
(54, '01. Egg 2 n~02. Potato 4 n~03. Butter 2 tb~04. Cumin seeds ½ ts~05. Ginger garlic chopped 2 tb~06. Salt~07. Turmeric~08. Chilly powder ½ ts~09. Onion chopped 1 n~10. Green chilly 3 n~11. Mushrooms 6 n~12. Tomato chopped 4 n~13. Coriander 2 b~14. Bread coarse crumbs 1 cup', '01. Heat white butter in a pan add cumin seeds, ginger garlic chopped, raw potatoes (cut in to small pieces), salt, turmeric, chilly powder, add chopped onions, let it cook for 2 minutes~02. add green chilly, mushrooms, eggs, chopped tomatoes, chopped coriander, bread powder, sprinkle water, mix it well~03. put the lid on cook for 2 minutes and switch off the flame.'),
(55, '01. Brinjal, cut and cubes into small pieces - 3 nos~02. Tomatoes, finely chopped - 1 cup~03. Tamarind juice, extracted - 1 cup~04. Dal water, taken from cooked dal - 2 cups~05. Spice powder - 3 tbsps~06. Green chillies - 2 to 3 nos~07. Turmeric powder - ½ tsp~08. Salt to taste~09. Water - 3 -- 4 cups~10. Mustard seeds - 1 tsp~11. Hing (asafoetida) - a pinch~12. Curry leaves - few', '01. for making the spice powder: Firstly take few peppercorns, 6 to 7 red chillies, 1 tbsp coriander seed, 1 tbsp channa dal, 1 tsp jeera and dry roast in a pan till you get a sweet aroma. Grind to a fairly coarsely powder and keep aside.~02. For making the rasam: Add some water in a sauce pot, add the brinjals, chopped tomatoes, a pinch of turmeric powder, salt, tamarind juice, green chillies; cover the pot with a lid and allow it to boil nicely till the brinjals become soft and are done.~03. After about 10 mins, add dal water and freshly ground spice powder and mix. Get this to just one boil and switch off the flame. Before switching off the flame, place a pan on the other side of the stove and add little oil for tempering, add mustard seeds, when they crackle, add hing (asafoetida), curry leaves. Switch off the flame. Add some coriander leaves in the rasam and immediately put the tempering in and close the pot with a lid. Swith off the flame and allow it to rest for about 4 -- 5 mins before serving. Serve with hot steamed rice, any side dish curry and some nicely roasted papads or fryums.'),
(56, '01. Wheat flour 1 cup~02. Salt ~03. Butter 2 tb~04. Baking powder 1 pinch~05. Butter milk ½ cup~06. Water as required', '01. Take a bowl add wheat flour, salt, butter, baking powder, mix this well and add butter milk, water mix this like a dosa batter.~02. Fill the ladle with dosa batter, pour this batter on to the center of the griddle and rotate the batter with ladle and add melted butter, cook this and transfer into a plate.~03. Serve this with coconut chutney.'),
(57, '01. ½ cabbage head finely chopped~02. 3 tsp chana dal boiled~03. pinch of shahi jeera~04. 1 green chilli finely chopped~05. pinch of red chilli powder~06. 1/2 tsp besan for binding~07. oil for frying~08. 1 onion chopped~09. 1/2 tsp of shahi jeera~10. 1 tbsp ginger garlic paste~11. pinch of turmeric~12. 1 tsp red chilli powder~13. 1 1/2 tbsp coriander powder~14. 1 tsp cumin powder~15. 2 tbsp cashew powder~16. 1/2 to 3/4th cu p of yoghurt beaten~17. 1 tsp dry mango powder~18. oil for cooking', '01. Boil some water in a pan,then add the finely chopped cabbage.boil the chana dal till its 70%~02. add the chana dal to the steaming cabbage,cover and cook till the cabbage is soft~03. cooked completely and also the dal.cooking cabbage properly is necessary so that the koftas~04. don''t break while frying.~05. when they are well done put them on a muslin cloth and squeeze out all the water from it.reserve the water~06. don''t throw.~07. Now take the cabbage and chana dal,to it add pinch of shahi jeera,red chilli powder,chopped green~08. chilli,salt,little besan and mix everything so that you can make small balls of it ready to fry.~09. heat the oil on slow flame,avoid heating oil too hot.drop them in oil and fry them on slow heat~10. till they get golden brown,remove them and set aside.~11. Heat some oil in the pan,add shahi jeera and then onion,little salt and cook the onions till they are slightly brown.~13. then add the turmeric and ginger garlic paste,when g-g paste is cooked add the\r\nreserved water to it.~14. then add the red chilli powder,coriander powder and cumin powder and mix well~16. and then add the beaten yoghurt to it and bring it to nice boil till gravy is cooked.~17. gravy is done when the froth coming disappears completely.when it come to boil and thickens little~18. add the powdered cashew nuts which will further thicken the gravy to a nice consistency.~19. then add the dried mint powder and let it cook and thicken.add the koftas and garnish with green coriander'),
(58, '01. 1 cup Cauliflower~02. 1 cup Carrot~03. 1/2 tsp Cumin Seed~04. small Curry Leaves~05. 5-6 Garlic~06. 1 tsp GARLIC PASTE~07. pinch Hing~08. 2 small Lemon Juice~09. Pinch fenugreek powder~10. 1/4 cup Mustard Powder~11. 1/2 tsp Mustard Seeds~12. 1/2 cup oil~13. 3 Red Chilli Dry~14. 1/2 cup Red Chilli powder~15. Salt (To taste)~16. pinch Turmeric Powder\r\n', '01. Slice the Carrot and Cauliflower into small cubes and keep it aside.~02. Take bowl add Red chilli powder,mustard powder,fenugreek powder,garlic mashed,turmeric powder mix this well and keep it aside.~03. Take pan heat oil add mustard seeds,cumin seeds,red chillies,hing,garlic once it is done switch off the flame and add curry leaves keep this tempering a side till it cool down.~04. Now take spices mixture add tempering into it and mix it well, now add cut Carrot and cauliflower cubes into it and mix it well at last add lemon juice. keep this mixture for 6 hrs a side.'),
(59, '01. Cauliflower (medium size) 1 n~02. Butter 3tb~03. Oil 1 tb~04. Salt~05. pepper powder 1 ts~06. Cumin powder 1 ts~07. Chilly powder 1 ts~08. Amchur powder ½ ts~09. Coriander chopped ½ b~10. Wheat flour 1 ½ cup', '01. Take a bowl add wheat flour, oil, salt, mix it with water make a soft dough, cover this dough with wet cloth and rest it for 15 minutes.~02. Take another bowl add butter, pepper powder, jeera powder (cumin seed powder), amtur powder, chilly powder, salt, chopped coriander mix it well. Add grated cauliflower, mix this well and divide the mixtrure in to equal portions.~03. Stuffing has to be more then the dough.\r\nAfter resting dough divide in to equal portions, take the dough ball with the help of the fingers make a small disk, place one portion of the cauliflower stuffing in the center of the dough and seal it, flatten the stuffed ball and dip it into the dry flour on both sides, using a rolling pin, roll out the stuffed ball into a round shape.~04. Place the rolled paratha on the heated griddle, using very little butter cook it on both sides till golden brown.~05. Serve this with curd.'),
(60, '01. Chicken 500 g~02. Chana daal 100 g~03. Oil 3 tb~04. Onion chopped 2 n~05. Salt~06. Ginger garlic paste 1 ts~07. Turmeric ¼ ts~08. Chilly powder 1 tb~09. Garam masala 1tb~10. Yogurt 1 cup~11. Tomatoes chopped 4 n~12. Coriander chopped 1 b', '01. Heat oil in a pan add chicken pieces, salt put the lid on let it cook till the chicken is 70 % cook, then transfer the chicken into the plate, in the same oil add chopped onion, salt, ginger garlic paste, turmeric, cook this onions are golden in colour, add chilly powder, garam masala powder, yogurt, chopped tomatoes, cook this tomatoes are mashed, chana daal (soaked and boiled still it is grainy), add chicken pieces, put the lid on and let it cook for some time, add chopped coriander, switch off the flame.~02. Serve this hot with naan, roti, puri and chapatti.'),
(61, '01. pring onions chopped 1 Tablespoons~02. Onions, cut 1 Numbers~03. Green bell pepper 1 Numbers~04. Ginger, chopped 1/2 Teaspoons~05. Garlic, chopped 1/2 Teaspoons~06. Pepper pd 1/2 Teaspoons~07. Green chilli sauce 1 Tablespoons~08. Soya sauce 1 Tablespoons~09. Salt to taste ~10. Vinegar 1 Teaspoons~11. MSG pinch ~12. Tomato ketchup 1 Teaspoons~13. Water as needed ~14. Cornstarch 1 Tablespoons~15. All purpose flour 11/2 Tablespoons~16. Salt to taste ~17. Chilli paste 1/2 Teaspoons~18. Potatoes, cut into cubes 200 Grams~19. Oil for frying', '01. in bowl, add some chilli paste, salt, cornstarch, all-purpose flour, little water and make a slightly thick batter.~02. Put in the potato pieces in this mixture and mix gently to coat all the potato pieces nicely. Heat oil in a pan and deep fry the potato pieces until golden in colour and crisp.~03. For making the slurry, in a bowl add tomato ketchup, vinegar, MSG, salt, soya sauce, green chilli sauce, pepper pd and mix well.~04. Keep this mixture aside.~05. Heat little oil in a pan and when itrsquo;s hot, add finely chopped ginger, garlic, green chillies, green bell peppers and onions.~06. Slightly sauteacute; and add the slurry, mix and bring to a boil.~07. Add the fried potatoes and toss weIn~08. Sprinkle some spring onions, mix and switch off the flame. Serve hot.'),
(62, '01. 1 cup Urad daal~02. 1 tbsp cumin~03. 5 leaf curry leaves~04. 500 ml yogurt~05. 1 bunch Finely chopped coriander leaves~06. 1-2 number green chilies chopped~07. to taste hing~08. to fry Oil~09. 2 piece Red chili~10. 1 to taste Salt', '01. For vada - Clean, wash and soak the dal overnight.~02. Grind it into smooth paste.~03. Add salt to taste.~04. Heat oil in a pan and drop a spoonfuls of batter and fry till golden brown as shown.~05. Take the hot vadas and put in cold water for 2-3 minutes.~06. Now Take them out of water and squeeze the water and keep aside.~07. For Dahi -add cumin , gr chilli,coriander leaves\r\nblend and add to yogurt and season~08. Serving - In a deep dish arrange wada and pour dahi over them.~09. Garnish with tempering as shown.Serve the dahi vadas chilled.'),
(63, '01. Oil 2 tb~02. Tur daal ½ cup~03. Channa daal ½ cup~04. Pepper corns 1 ts~05. Red chilly 4 n~06. Urad dal 1 ts~07. Coriander seeds 1 ts~08. Grated coconut ½ cup~09. Mustard seeds ¼ ts~10. Cumin seeds ¼ ts~11. Curry leaves 2 sprin~12. Turmeric pinch~13. Hing pinch~14. Salt~15. Tomatoes 2 n~16. Drumsticks (medium size) 4 n', '01. First Boil the tour daal, channa dal keep it aside.~02. Heat oil in a pan add pepper corns, red chilly, chanadal, Urad dal, coriander seeds~03. Cook this till raw flavor is gone, add freshly grated coconut, sauté it for 2 minutes and switch off the flame, and let it cool down put this in a blender make a coarse paste.~04. Heat oil in a pan add mustard seeds, when mustard seeds is splatter add cumin seeds, curry leaves, drumstick, turmeric, hing, water of boiled dal, salt, tomatoes (optional)~05. Cook this till drumsticks are nicely tender; add water, grinded masala powder, boiled tour daal, channa dal, cook till it comes to a boil, when dal is thicken switch off the flame.~06. Serve this with rice.'),
(64, '01. Rice 1 Cup~02. Tur dal 1 Tablespoons~03. Channa dal 1 Tablespoons~04. Red chillies 3-4 Numbers~05. Curry leaves 2 Springs~06. Hing 1 Pinch~07. Salt~08. Drumstick leaves, finely chopped 2~09. Tablespoons~10. Coconut, freshly grated 1 Tablespoons~11. Oil for frying ', '01. In a bowl put in the rice, channa dal, toor dal, dry red chillies and curry leaves. Add water, wash the ingredients nicely once and drain off the water.~02. Put in the hing, salt and water till all the lentils are soaked properly and rest aside for at least for 3-4 hrs.~03. Drain the water and grind them in a blender to a coarse paste. The batter needs no fermentation.~04. Add finely chopped drumstick leaves, grated fresh coconut to this coarse batter and mix well.~05. Take a flat non stick pan and pour 1 spatula batter in the pan and spread evenly from inside out with your fingers.~06. Drizzle some oil at the edges of the adai and in the center. Cook it on medium flame.~07. Cover with a lid and allow it to steam cook for few minutes. Brown it on one side and then flip over to the other side for a minute.~08. Serve hot with sambar, coconut chutney, jaggery or pickle.'),
(65, '01. Tour Daal 100g~02. Cumin seeds ½ ts~03. Garlic slices 8 n~04. Turmeric ¼ ts~05. Salt~06. Coriander chopped 1 b~07. Red chilly powder 1 tb~08. Garam masala 1 ts', '01. Take pan heat ghee add cumin seeds, slice garlic, turmeric, salt, chopped coriander, red chilly powder, garam masala powder and add daal (boiled) mix this, cook it for 1 minute and switch off the flame.'),
(66, '01. 1 tbsp chilli powder~02. 1 tsp coriander powder~03. 2 bunch coriander leaves~04. 8 number garlic cloves~05. 2 number Green Chili~06. 500 grams meat mince~07. 2 tbsp oil~08. 1 number onion chopped~09. 1 tsp pepper~10. as needed salt~11. 1 tbsp Rava~12. 1 tbsp Soy Sauce~13. pinch 0 turmeric powder~14. as needed water~15. 1/2 tsp zeera', '01. Take a pan add oil 1 tsp, add jeera, onions,salt, cook till light brown colour~02.  then add turmeric,ginger garlic paste,mix well,then chilli powder, coriander powder, chopped coriander mix well and switch off the flame and cool it down.~03. In a bowl take sooji add water and soak it for 2 min.~04. In another bowl take meat mince,add sooji remove water,then onion masala mix well if require add salt,chilli powder mix well and make into small balls and keep a side.'),
(67, '01. Onions 350g~02. Cashew nuts ¼ cup~03. Kashmiri red chilly 150 g~04. Green chilly 75g~05. Salt~06. Butter ½ cup~07. Tomatoes 1500 g~08. Sugar 2 ts~09. Whole garam masala (each) 8g~10. Ginger garlic paste 1 tb~11. Kasoori methi 1/8 cup~12. Oil for deep fry~13. Corn starch 1 ts~14. All purpose flour 1 ts~15. Cauliflower (big pieces) 2 n~16. Pepper crushes ½ ts', '01. Add whole garam masala in the muslin cloth and tie it .Heat butter in a pressure cooker and put the garam masala sachet in it, add onions cashew nuts, sauté it for 5 minutes, then add salt, ginger garlic paste, cook this till raw flavour is gone.~02. Add colour giving chilli or Kashmiri red chilly, green chilly, tomatoes, mix it well and put the lid on and let it cook for 15 to 20 minutes in a slow flame (5 to 6 whistles). Let it cool down, remove the sachet & using strainer drain out the water and put the onion and tomato into the blender and blend them and make a paste and again strain it, after straining all, discard the seeds and peels of tomato.~03. Cook the strained paste of tomatoes and onions for 20 minutes then add salt, sugar as required , mix it and add toasted kasoori methi (crush it with hands) once it comes to boil switch off the flame. Cool it and store in small containers in refrigeration conditions. Use this makhani gravy in many veg and non veg dishes.~04. Take cauliflower big pieces; blanch it in the salt water. Take a plate add corn starch, all purpose flour, crush pepper, coriander powder, salt, add water make a paste, and coat the mixture into the cauliflower and shallow fry them on both sides till golden in colour and transfer it into the another plate. In the same pan add some makhani gravy, add butter and fried cauliflower pieces, cook this for 2 minutes and add cream mix this along with makhani gravy.~05. Serve this with pulka, naan, roti and chapati.'),
(68, '01. 1 cup bell pepper yellow and green~02. 1 bunch coriander leaves~03. 2 tsp coriander powder~04. 1 tsp coriander seeds powder~05. 2 tsp cumin powder~06. 7 number curry leaves optional~07. 3/4 tsp garama masala powder~08. 1 tsp ginger garlic paste~09. 4 number green chillies~10. as need oil~11. 400 grams okra~12. 1 cup onion~13. 1 tsp red chilli powder~14. as per taste salt~15. 1 cup tomato~16. a pinch turmuric', '01. Cut bhendi into small pieces and deep fry them little bit to avoide stick ness.~02. Cut tomatoes and bell pepper into small cubes.~03. crush coriander seeds in dingchick and keep it a side.~04. Take a pan add oil,cumin seeds,corinader seeds crushed,chopped onion,salt mix well and then add turmuric, ginger garlic paste,cook it for 2 mins and then add curry leaves,green chillies saute them.~05. Now add tomatoes cook it for 1 min, then add coriander powder, cumin powder,chilli powder mix well and cook for 4min till tomatoes are cooked now add bell pepper,and sprinkle chopped coriander leaves , and finely add the fried bhendi, mix little bit and close it a lid for 4 min in very slow flame.~06. onces bhendi is cooked add garama masala powder and mix well serve hot with roti or rice'),
(69, '01. Paneer 300 g~02. Pepper corns 9 n~03. Red chilly whole 4n~04. Coriander seeds 1 tb~05. Cumin seeds 1 ts~06. Fennel seeds ½ ts~07. Butter 2 tb~08. Chilly powder 1 tb~09. Garam masala 1 ts~10. Onions 1 medium size~11. Bell pepper 1 n~12. Tomato puree 250 g~13. Salt~14. Sugar ½ ts~15. Cream 2tbsp', '01. Heat a pan add pepper corn, red chilly, coriander seeds, cumin seeds, fennel seeds (optional) dry roast these ingredients till the flavor comes out then add fenugreek leaves, roast them transfer in to a plate and let it cool down make a coarse powder in the mortar pestle.~02. Divide into two parts one is slightly finnier, and another is coarse powder.~03. Heat butter in a pan add made finnier powder cook this masala in the butter, add chilly powder, garam masala powder, onion, bell pepper, and then add tomato puree (blanched remove the skin and cut them in to small pieces) let this cook till raw flavor is gone add salt, sugar, paneer (fry them) Sprinkle kadai masala and add coriander leaves, cream mix it well.~04. Serve this hot along with naan, roti.'),
(70, '01. Cashew nuts 20 g~02. Almonds 10 g~03. Poppy seeds 10 g~04. Melon seeds 20 g~05. Tomato puree 1 ½ tb~06. Coriander powder 1 ts~07. Cumin powder ½ ts~08. Chilly powder ½ ts~09. Curd (beaten) 3 tb~10. Fried onions 1 n~11. Cloves 3 n~12. Cardamom 2 n~13. Cinnamon sticks (1/2 inch) 2 n~14. Bay leaves 1 n~15. Turmeric pinch~16. Salt to taste~17. Oil 1 tb~18. Cream 2 ts', '01. Take cashew nuts, almonds, poppy seeds, melon seeds, put it in to the hot water and cook for 15 minutes, then let it cool down put them into the blender and add fried onions, make a paste.~02. Heat oil in a pan add cloves, cinnamon, cardamom, bayleaves, add cumin seeds, sauté it and add ginger garlic paste, turmeric, cook this till raw flavour is gone, add tomato puree, coriander powder, cumin powder, chilly powder, mix it well once it comes to boil then add curd, add soaked whole cashew nuts cook this for 10 minutes, then add cream, reduce the flame cook for 2 minutes then switch off the flame.~03. Serve this with chapathi.'),
(71, '01. 200 grm Chocolate~02. 3/4 cup Cream~03. 8 Oreo Cookies~04. 1 & 1/2 tsp Melted Butter~05. 3/4 tsp Gelatin~06. 2 tbsp Water~07. 1 tbsp Caramel Syrup~08. 1 cup Whipped Cream', '01. In a bowl put dark chocolate and cream and microwave it~02. Whisk the melted chocolate and cream and let it cool~03. Grind the oreo cookies into a fine powder~04. Add melted butter to oreo cookie powder and mix it well~05. Make a thin layer in the base of the serving glass and refrigerate it for few mins.~06. Soak Gelatin in water for at least 5 mins and add it to the chocolate mixture~07. Add caramel Syrup and whisk it and refrigerate it for about 10 mins~08. Add whipped cream to the chocolate mix and mix it well with a spatula~09. Pour the chocolate mousse onto the oreo cookie base serving glass~10. Set for another 15 mins in freezer~11. Garnish it with whipped cream, chocolate piece and oreo cookie on top and the dessert is ready to be served.'),
(72, '01. 4 tbsp unsalted butter, cut into pieces~02. 1 oz bittersweet chocolate, chopped + two 1/2 oz pieces of bittersweet ~03. chocolate (see note)~04. 1/4 cup sugar~05. 2 large eggs~06. 2 tbsp unsweetened cocoa powder~07. 1 tsp vanilla paste or extract~08. 1/4 tsp salt~09. 1.25 oz all-purpose flour (1/4 cup)~10. 1/2 tsp baking powder~11. vanilla ice cream, for serving', '01. Select two mugs that hold at least 11oz of liquid in them (about a cup and a half of water).~02. Microwave the butter and chopped bittersweet chocolate in a large bowl for about 1 minute, stirring halfway through, until fully melted. Set aside.~03. Whisk the sugar, eggs, cocoa powder, vanilla, and salt in a medium bowl, then whisk this into the melted butter and chocolate. Whisk in the flour and baking powder, then evenly divide the batter between the two mugs.~04. Put the mugs on opposite sides of the microwave turntable, and microwave at 50% power for 45 seconds. Stir the batter well with a spoon, then microwave for another 45 seconds at 50% power. Press the two chocolate squares down into each cake until it is nestled nicely on the surface. Microwave for an additional 35 seconds at 50% power. At this point the cakes should be done. The cake may be a little gooey on top, but you can check that the interior of the cake should be around 200 degrees F. Let the cakes sit for 2 minutes while the heat continues to cook the cakes slightly, then serve with vanilla ice cream. Enjoy!\r\n'),
(73, '01. For the Peanut Butter Cookies:\r\n1/2 cup unsalted butter, softened (1 stick)~02. 1/2 cup crunchy peanut butter~03. 1/2 cup sugar~04. 1/4 cup light brown sugar, lightly packed~05. 1/2 tsp vanilla extract~06. 1 large egg~07. 3/4 cup all-purpose flour~08. 1/2 tsp baking soda~09. 1/4 tsp baking powder~10. 1/4 tsp sea salt~11. For the Peanut Butter Buttercream:\r\n1/2 cup butter, softened (1 stick)~12. 1/2 cup creamy peanut butter~13. 1 cup confectioner''s sugar~14. 1 tbsp heavy whipping cream', '01. Preheat the oven to 350 degrees F.~02. For the peanut butter cookies, cream together the butter and peanut butter for 30 seconds on medium high speed with a hand mixer, until fluffy and light. Add the sugar and brown sugar, and cream for another 30 seconds, until combined. Add the vanilla extract and egg, and mix until combined.~03. In a separate bowl, whisk to combine the flour, baking soda, baking powder, and salt, then add this mixture to the wet ingredients in the other bowl. Mix until the flour just barely disappears (do not overmix, or the cookies will be tough).~04. Take a medium cookie scoop and portion mounds of cookie dough onto a silicone mat or parchment paper lined baking sheet (12 scoops per sheet pan, with two sheet pans total), then bake for 13 minutes until the cookies are golden around the edges. Let the cookies cool completely.~05. To make the buttercream filling, cream together the butter and peanut butter until fluffy. Add the confectioner''s sugar and mix with medium high speed for 30 seconds, until airy and light. Add the heavy whipping cream and whip for another 30 seconds.~06. To assemble, place the buttercream filling into a piping bag, then pipe the filling onto half of the cookies. Top the piped cookies off with a plain cookie, then press gently with your fingertips to make a sandwich. Serve and enjoy!'),
(74, '01. 2 cups sugar~02. 3/4 cup cocoa powder~03. 1/2 cup butter~04. 1 tin (400 gms) or 2 cups condensed milk~05. 1/2 cup water~06. 2-3 tbsp bread crumbs + 1 tbsp cocoa powder\r\n', '01. Mix together the bread crumbs and 1/2 cup cocoa.~02. Set aside.~03. Boil the remaining ingredients together over low heat.~04. Stir continuously.~05. Patience is the key here.~06. Cook till a drop in cold water forms a ball.~07. Remove from heat.~08. Sprinkle half the bread crumb-cocoa mixture on a greased tray.~09. Spread the prepared fudge. 2" thick.~10. Top with the remaining bread crumbs-cocoa mixture.~11. Leave to set.~12. Cut when cold.'),
(75, '01. 1lb fresh strawberries~02. 1/4 cup white sugar~03. 1 (3.4oz) pkg instant vanilla pudding, prepared according to package\r\npound cake (homemade or store bought)~04. fresh whipped cream~05. half pint Ball mason jam jars', '01. Wash and hull the strawberries. Cut into pieces and add in the sugar. Stir to coat the berries. Let sit for 20-30 minutes.~02. While they are macerating, prepare the instant pudding according to package instructions. Also prepare the whipped cream.~03. For the pound cake, slice into 1/2" slices and using a biscuit cutter, cookie cutter or measuring cup, cut into rounds slightly smaller than the jar you will put these in.~04. To assemble the mini trifles, place a slice of pound cake in the bottom of the jar. Put a spoonful of pudding on top of the cake. Next, place a spoonful of the macerated strawberries and finish with a layer of whipped cream. Repeat using another round of pound cake, another spoonful of pudding, another spoonful of strawberries and finally, top with a nice rosette of whipped cream on top. Repeat until you run out of ingredients. You may have some pudding left over but not much. Makes 6 mini trifles. Store in the refrigerator until ready for serving or up to 4 days. Enjoy!!'),
(76, '01. 200 gms Dark Chocolate Sponge~02. 2 & 1/2 tbsp Condensed Milk~03. 50 gms Melted Dark Chocolate~04. 2 tbsp Dark Rum~05. 2 tbsp chopped Walnuts~06. 1/2 tbsp Butter~07. Icing Sugar~08. 150 gms Dark Chocolate', '01. Grind chocolate sponge in a grinder and get that out in a bowl~02. Add condensed milk, melted dark chocolate, dark rum, walnuts, butter and mix everything well together~03. Dust icing sugar in hands and make 1'' inch balls and refrigerate it for about 10 mins~04. Coat the rum balls in melted dark chocolate using a fork and coat it well~05. Drip the excess chocolate and sprinkle some colored sprinkles on it.~06. Refrigerate it for another 5 -6 mins and its ready to be served or preserved in air tight containers!'),
(77, '01. 250 ml (1 cup) milk~02. 170 gm (3/4 cup) granulated sugar~03. 210 gm (1 1/2 cups) plain flour~04. 65 gm (1/2 cup) vanilla custard powder (or cornflour/cornstarch)~05. 2 tsp baking powder~06. 1/4 tsp baking soda~07. 1 tsp vanilla extract~08. 100 gm (1/2 cup) butter', '01. Prepare a 7” round cake tin by greasing it well with oil or butter and lightly dusting it with plain flour. Tap to remove excess flour from the surface of the pan. Alternatively, grease the pan and line the base with greaseproof paper.~02. In a saucepan, heat the milk. Stir in the sugar and after it melts completely set it aside to cool to room temperature. After the milk reaches room temperature, add the custard powder and vanilla extract and mix well with a whisk. Add in the butter and mix again.~03. Heat the oven to 160 degrees centigrade/325 F.~04. In a large mixing bowl, assemble the flour, baking powder, baking soda and mix with a whisk. Pour in the prepared milk mixture and mix well with a whisk until there are no lumps. Alternatively use an electric hand mixer/beater.~05. Put the batter into the prepared pan/tin and bake for 55 minutes to 60 minutes, until a skewer comes out clean.~06. If using cornstarch instead of custard powder add a pinch of yellow colour and additional vanilla extract.'),
(78, '01. 500 ml vanilla ice cream (family pack)~02. 1 cup cream~03. 2-3 tbsp powdered sugar~04. 5 tbsp strawberry puree~05. 1tbsp gelatin~06. 1/2 cup water', '01. Soak gelatin in water.~02. After 5 minutes, gently heat to dissolve. Cool.~03. In a bowl, soften the ice-cream. Add cream, sugar and strawberry puree.~04. Add melted gelatin to the ice-cream mixture. Beat to mix well. Pour the mixture in a serving bowl. Refrigerate to set for 4-5 hours.~05. Serve topped with the slices of strawberry.'),
(79, '01. 1 cup Flour~02. 1/4 tsp salt~03. 1 tsp Baking Powder~04. 1/2 Cup Castor Sugar~05. 1/4 Cup Brown Sugar~06. 1/2 or 1/3 cup Cocoa Powder~07. 1 tbsp cornflour~08. 3/4 tbsp White Vinegar~09. 1 tsp Vanilla Essence~10. 1/4 Cup Oil~11. 3/4 cup Plain Water', '01. Mix all the wet ingredients in a bowl and keep it aside.~02. Mix well all the dry ingredients in a bowl except cornflour and pour the wet mixture on it bit by bit~03. Whisk all the ingredients well till the batter is runny.~04. In a baking container pour the batter~05. Put the container in a baking oven at 140 Degree Celsius for about 20 - 25 Minutes~06. Take it out when it is baked properly and let it cool~07. take out the cake from the container & put it on a plate~08. Meanwhile, prepare the chocolate sauce.~09. In a frying pan pour 1 cup of water, 1 tbsp of cocoa powder, 1 tbsp of brown sugar and 1 tbsp of cornflour.~10. Mix all the ingredients well to make a smooth running liquid add boil for 2mins.~11. Add a tsp of butter to it and the chocolate sauce is ready~12. Cool the sauce and pour it all over the cake and it is ready to be served.'),
(80, '01. Cottage Cheese~02. 1/2 cup Yogurt~03. 5 crushed Digestive Biscuits~04. 1 tbsp Butter~05. 1/4 cup Orange Squash~06. 1/4 cup Water~07. 1/2 tbsp Gelatin~08. 1/3 cup Orange Squash~09. 1 & 1/2 tbsp Powdered Sugar~10. 1&1/2 Cornflour', '01. Heat butter in a pan and add biscuit powder to the melted butter, mix well and put it in the cake tin.~02. Add paneer, curd, orange squash, water, powdered sugar to a mixer and blend everything well to make a smooth paste by adding melted gelatin~03. Pour the churned mixture in the cake tin where we have previously put in our biscuit powder and refrigerate it~04. Meanwhile we make our Sauce, for that we add orange squash, water, sugar, butter, cornflour in a pan and mix it well so that it does there is no lump formation.~05. Cool the syrup and pour it over the cheesecake and its ready to be served'),
(81, '01. 12 Strawberries~02. 90 gm Cream Cheese~03. Powdered Sugar~04. 1/2 tsp Vanilla Essence', '01. Cut the top and bottom of the strawberry and scoop out the strawberry pulp with the strawberry edge intact.~02. Put a doily on a plate, sift some powdered sugar with the help of a sieve~03. Mix well cream cheese, powdered sugar, vanilla essence and put it in piping nozzle.~04. Fill the strawberries with the whipped cream and garnish with mint leaves / pista on top.'),
(82, '01. 25 gms Kaju Katli~02. Saffron (soaked in water)~03. Almonds', '01. Take some Kaju Katli and with a wet cloth wipe off al the silver coating~02. Mash all these up and make a dough~03. Roll this up (not too thick not too thin)~04. Cut it into round shape and brush some soaked saffron color on it~05. Place a almond and press on one edge~06. Gently fold and slightly overlap and its ready to be served'),
(83, '01. 2 cups Flour~02. 1/2 tsp salt~03. 4 tbsp Melted Butter~04. 3/4 cup milk~05. 1 tbsp of fresh Yeast~06. 1 tsp Sugar~07. 2 tbsp Demerara Sugar~08. 1 tsp Cinnamon Powder~09. 2 tbsp Raisins', '01. In a bowl, add milk to the sugar (milk should be Body Temperature)~02. Add the yeast as well and stir well, cover it and leave it to rise~03. Meanwhile take flour in a bowl and add salt to it.~04. Add the milk mixture to flour~05. Knead all the ingredients well and add water and melted butter and make a smooth dough~06. Leave the dough to rise for about 15 - 20 mins~07. Spread some melted butter on a board and sprinkle some demerara sugar, 1/2 tsp cinnamon and spread the ingredients on the board~08. Take the dough and place it on the top of the cinnamon mix~09. Roll it up with the help of a rolling pin to give it a rectangular shape~10. Spread some melted butter again from the top and add rest of the damerara sugar and cinnamon powder and spread it all over the rolled dough~11. Add the raisins from one side of the flattened dough~12. Start rolling the flattened dough from one side.~13. Sprinkle some flour on the board and put the rolled roll on it~14. Cut the roll into small pieces and press the small pieces and place it on baking tray.~15. Cover it with a semi wet cloth and leave it to rise~16. Put the tray in the oven at 140C for 20 - 25 mins approx~17. Once its baked remove the rolls on a plate~18. In a bowl take icing sugar and water and mix well to make a smooth paste~19. Drizzle some of it on the baked rolls and serve it with tea / coffee'),
(84, '01. 1 cup milk~02. 1 & 1/2 tbsp. custard powder~03. 2 tbsp. sugar~04. 1/2 tsp. pineapple essence in colour~05. 3 pieces of vanilla sponge~06. tinned pineapple chopped~07. strawberry crush~08. strawberries~09. kiwi~10. orange veggies~11. strawberry jelly~12. whipped cream', '01. Pour some part of the milk in a round bottomed pan. Add custard powder.~02. Add sugar and mix well. Break lumps. Add remaining milk.~03. Turn on the flame.~04. Once the custard thickens, turn off the flame.~05. Add pineapple colour in essence. Let it cool down.~06. Chop all the fruits.~07. In a bowl, start layering, first with custard.~08. Make next layer of the vanilla sponge cake.~09. Layer custard over the second layer~10. Make next 2 layers of strawberry crush and chopped fruits.~11. Pipe the cream over the pudding.~12. Top the layer with strawberry jelly.~13. Drizzle strawberry crush over the whipped cream.~14. Let the pudding set in the refrigerator for 30-40 minutes and serve chilled.'),
(85, '01. 1 tin (200 ml.) condensed milk~02. 1 tin measure milk~03. 1 tin measure yogurt~04. ring mould greased with butter', '01. Prepare the steaming vessel~02. Mix together condensed milk, milk and yogurt till well blended~03. Pour into the ring mould. Place it in the steaming vessel. Cover and cook till firm. (20-30 min)~04. Let cool completely and drain off the excess water.~05. Unmould onto a serving dish.~06. Surround with the mango pieces, pulp. Serve cold.'),
(86, '01. 3 tbsp Brown Sugar~02. 4 tbsp Maple Syrup~03. 1/4 tsp Cinnamon Powder~04. 1 tbsp Rum~05. 1 tbsp Crunchy Peanut Butter~06. 1 tsp Butter~07. 2 tbsp Cream~08. Olive Oil~09. Strawberries', '01. Mix brown sugar, maple syrup, cinnamon powder, rum, crunchy peanut butter, butter, cream in a pan, put it on flame and cook it for a minute by stirring continuously.~02. Peel the Banana and slit in two halves~03. Brush some olive oil and put them in griller for grilling for 2 - 3 mins and flip them over.~04. Place the grilled bananas on a plate, place a dollop of ice cream and sliced strawberry~05. Drizzle the peanut Butter sauce and serve them.'),
(87, '01. For Cake: 3/4 cups Brown Sugar~02. 2 Eggs~03. 1 & 1/4 cup Plain Flour~04. 1/2 cup Butter~05. 2 tsp Baking Powder~06. 2 tbsp Instant Coffee Powder~07. Milk as per requirement~08. For Icing: 6 tbsp of Icing Sugar~09. 1 tbsp Coffee Powder~10. Water', '01. Take a bowl, put the brown sugar and break the eggs on it and blend it till its light and fluffy.~02. Add butter and beat it again~03. Gradually add in the flour in it, 1 tbsp at a time, twice, then add the rest of the flour.~04. Add baking powder, coffee powder and beat it well~05. Keep adding milk and blend it till it has a dropping consistency~06. Put the mixture in previously greased cake tin mold and spread it well all around.~07. Put the tin in the oven in 220c for about 20 -- 25 mins~08. Once the cake is baked, scrape the knife through the edges and invert it.~09. Let the cake come out of the mold and let it cool~10. Meanwhile prepare the icing~11. In a bowl add icing sugar, coffee powder, water and beat it well till it has a running consistency and no lumps formed.~12. Drop the icing on the cake and its ready to be served.'),
(88, '01. 2 cups apple (peeled & chopped)~02. 1/3 cup brown sugar~03. 1/2 tsp cinnamon powder~04. 3/4 cup plain flour~05. 4 tbsp Caster Sugar~06. Salt~07. 30 gms Butter', '01. Mix well apple, brown sugar, cinnamon powder and put in a baking tray~02. In a bowl take plain flour, Caster Sugar, salt, butter and mix everything well to make a mixture like bread crumbs~03. Spread the flour mixture on the sugar coated apples from top~04. Bake the apple crumble at 180 C in a preheated oven for at least 10 mins, then at 160 C for another 15 mins approx.~05. The dish is ready to be served hot.'),
(89, '01. Wet Ingredients: 1/2 cup oil~02. 250 gms honey~03. 1 cup sugar~04. 1 cup milk~05. 1.5 tbsp vanilla essence~06. Dry Ingredients: 2 cups of flour~07. 3/4 cups whole wheat flour~08. 2 tsp baking powder~09. 2 tsp soda bicarb~10. 1 tsp cinnamon powder~11. 1 tsp salt~12. 3 cups grated carrots ~13. 1/4 cup raisins~14. 1/2 cup chopped walnuts', '01. Beat the wet ingredients together using a beater till all the sugar dissolves.~02. Add dry ingredients to it and beat it lightly~03. Add carrots, raisins, walnuts and mix everything well using hands and no beater~04. Put the mixture in a baking tray for baking in a preheated oven at 220c and bake for an approx time of 30 - 40 mins~05. Once baked scrape from the sides of the tray, take it out, cool it down and serve at normal room temperature! '),
(90, '01. 150 gms white chocolate chips~02. 200 gms dark chocolate (roughly chopped)~03. 1/2 cup cranberries (finely chopped)~04. 1/4 cup walnuts (finely chopped)~05. 1 tbsp honey', '01. Double boil the white chocolate and let it cool~02. Microwave the dark chocolate for 50 secs approx and cool it.~03. Pour the melted chocolates in two separate piping bags and let it cool~04. Mix well cranberries, walnuts and honey~05. Pour a white chocolate layer in the mold and tap so that the chocolate spreads well~06. Using a paint brush spread the white chocolate around and clean the edges with a tissue~07. Set the mold for three minutes in the refrigerator~08. Put the dry fruits filling on white chocolate and fill the rest with dark chocolate~09. Tap the mold again to evenly spread the chocolate and let it set in the refrigerator for about 6 mins~10. Get them out of the molds and drizzle some chocolate syrup on top~11. Refrigerate it another 2 mins and have it anytime you want or gift them in a box ! ');

-- --------------------------------------------------------

--
-- Table structure for table `recipe_ig`
--

CREATE TABLE IF NOT EXISTS `recipe_ig` (
  `R_id` int(6) NOT NULL AUTO_INCREMENT,
  `R_name` varchar(200) DEFAULT NULL,
  `R_veg` int(2) DEFAULT NULL,
  `Ig_name` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`R_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=91 ;

--
-- Dumping data for table `recipe_ig`
--

INSERT INTO `recipe_ig` (`R_id`, `R_name`, `R_veg`, `Ig_name`) VALUES
(1, 'chilli beef', 0, 'egg,potato,beef,chilli'),
(2, 'salmon fillet', 0, 'asparagus,butter,chilli,lemon,salmon'),
(3, 'potato mash', 1, 'potato,cheese,chilli,salt'),
(5, 'paneer tikka', 1, 'salt,cottage cheese,chilli, onions,capsicum'),
(7, 'cooler', 1, 'coriander,water,mint,cumin,sugar'),
(8, 'french toast', 0, 'Eggs,Bread,cinnamon,sugar'),
(9, 'aloo gobi', 1, 'amchoor pdr,cauliflower,coriander leaves,coriander powder,cumin seeds,garam masala,ginger-garlic paste,\r\ngr peas,green chilli,oil, onion,potatoes,red chili powder,salt,\r\ntomatoes,turmeric powder,\r\n'),
(10, 'alu vadi', 1, 'coconut paste,Sesame seeds powder,Roasted peanut powder,Garam masala powder,Jeera powder,Redchilli powder, Fennel seeds,Whole coriander seeds,Cumin seeds,Turmeric powder, \r\nHing (asafoetida),Oil, Rice flour\r\nBesan atta (chickpea flour), Taro root leaves,Jaggery,Salt, Tamarind juice,\r\nWater, Oil '),
(11, 'stuffed brinjal', 1, 'Ajwain,Coriander leaves,Coriander powder,Cumin seeds,springs Curry leaves,\r\nsmall Eggplant/ Brinjals,Fresh grated Coconut,Goda masala,Green chillies,Hing (asafoetida),Jaggery,Mustard seeds,Oil,Peanuts roasted,Red chilli powder,Salt,Sesame seeds roasted,\r\nTamarind pulp,Turmeric powder'),
(12, 'butter chicken', 0, 'butter,cashewnuts,coriander leaves,coriander pdr,Crushed fenugreek leaves,cumin seeds,Fresh cream,Ginger garlic paste,green chillies,oil,onion,Raw chicken slices,Red chilli powder,Salt,Sugar,Tomato,tomato ketchup ( optional )'),
(13, 'cauliflower 65', 1, 'Ginger garlic paste,Garam masala,Pepper corn powder,Chilly paste,Coriander,Curry leaves,Oil,All purpose flour,Corn starch,Cauliflower'),
(14, 'chicken 65', 0, 'Aji no moto(MSG),Chicken-dark meat(boneless thigh meat)Coriander leaves,Cornflour,Cumin seeds,Pepper powder,chilli powder,salt,Curry Leaves,Egg,Garlic,Ginger,Ginger/Garlic paste,Green Chilli,Oil,Red color(Optional)'),
(15, 'channa masala', 1, 'channa,channa masala pdr,coriander leaves,cumin,ginger garlic paste,gr chillies,lime,oil,onion,salt,tomatoes,\r\nturmeric,whole garam masala'),
(16, 'chicken lollipop', 0, 'Aji no moto(MSG),Breadcrumbs,chicken wings,Chilli garlic sauce,Crushed Egg,ginger/garlic,Curry leaves,Ground Chicken/Paneer,Oil,salt,herbs,chilli,soysauce'),
(17, 'chicken tikka masala', 0, 'caswhnut,chicken,chilli,coriander leaves,coriander powder,cream,cumin powder,cumin seeds,curd,ginger garlic,lemon,methi powder,onion,onion,red chilli powder,red pepper,salt,tomato,turmuric'),
(18, 'chilli paneer', 1, 'ajinomoto,chilli garlic sauce,coriander powder,Corn flour,cumin seeds,curry leaves,egg,garlic,ginger garlic paste,green chillies,lime juice,maida,oil,onion,paneer,red bell pepper,salt,soya sauce,water,yellow bell pepper'),
(19, 'coconut chutney', 1, 'cashew nuts,ginger,coriander,gr chilli,cumin,Curry leaves,dahliagrated coconut,hing Asafoetida,mustard,oil,red chilli,salt,tamarind or lime,black gram'),
(20, 'dal makhani', 1, 'Black grams,butter,coriander pdr,cream,cumin,garam masala pdr,Ginger garlic paste,Kidney beans,oil,Red chilli powder,Salt,tomatoes puree,turmeric'),
(21, 'dum aloo', 1, 'potato,cardamom,cloves,coriander leaves,coriander seeds,cumin seeds,curd,fennel pdr,garam masala pdr,garlic paste,ginger pdr,oil,red chilli powder,Salt,turmeric powder'),
(22, 'egg biryani', 0, 'Basmati Rice,biryani masala pdr,black cumin,Clarified Butter,Eggs,onion,Coriander Leaves,Ginger garlic paste,Green Chillies,mint,oil,Onions,Yogurt,Salt,\r\nwhole garam masala'),
(23, 'egg curry', 0, 'chilli pdr,chilli,onion,coriander pdr,cumin,cumin pdr,curry leaves,eggs,fenugreek leaves,ginger garlic paste,mustard seeds,oil,salt,tamarind juice,turmeric'),
(24, 'egg korma', 0, 'Almonds,Melon seeds,Cashew nuts,Poppy seeds,onions,Oil,Bay leaf,Cloves,Cardamom,Cinnamon,Cumin seeds,Ginger garlic paste,Tomato puree,Coriander powder,Cumin powder,Turmeric,Red chilly powder,Salt,Curd,eggs'),
(25, 'fish fry', 0, 'chilles,coriander leaves,coriander pdr,curry leaves,fish,ginger garlic paste,lemon Juice,oil,turmeric'),
(26, 'mutton biryani', 0, 'Basmati rice,black cumin,Cashew nuts,coriander leaves,Curd,garam masala,\r\nGaram masala powder,Garlic and ginger paste,onions,gr chilli,Lime juice,meat tenderizer,mint,Mutton,Oil,Red chilli pdr,Rose Water,Saffron,Salt,Turmeric powder'),
(27, 'jalebi', 1, 'cornflour,curd,lemon juice,Maida,Oil,saffron colour,sugar,water'),
(28, 'jeera rice', 1, 'basmati rice,butter,oil,coriander leaves,onion,gr chilli,cumin,mint,saffron color,salt,water'),
(29, 'kala vatana amti', 1, 'Browned grated Copra powder,Coriander powder,leaf Curry leaves,Garam masala powder,Garlic cloves,Green chillies,Hing (asafoetida),Kala Vatana, Black Channa,Oil,Onions,Red chilli powder,Salt,Tomato,Turmeric powder'),
(30, 'malvani fish curry', 0, 'Coconut milk,Coriander leaves,leaf Curry leaves,Bombay duck fish,Garlic cloves,Ginger,Green chillies,Kokum water,Malvani ground masala paste,Malvani Masala dry powder,Oil,Salt,Triphad spice,Turmeric powder,Water '),
(31, 'mushrooms fry', 1, 'coriander,onion,coriander pdr,cumin,cumin pdr,garam masala pdr,garlic,ginger garlic paste,lemon juice,mushroom,oil,pepper,red chilli,salt,tomatoes,turmeric'),
(32, 'onion pakora', 1, 'flour(Kadala podi),Green chillies,Oil,Onions,Salt'),
(33, 'onion samosa', 1, 'Atta (Wheat Flour),chatmasala,chilli powder,coriander leaves,cumin powder,green chillis,maida,Oil,onions,poha,salt,water'),
(34, 'palak paneer', 1, 'coriader powder,cream,cumin powder,garam masala,fenugrek leaves,garlic,ginger garlic paste,Green Chili,onion,palak,red chilli powder,salt,tomato'),
(35, 'palak puri', 1, 'Maida,Oil,Salt,Semolina,Spinach puree,Water,Wheat flour'),
(36, 'rava dosa', 1, 'ginger,gr chilli,onion,cumin,ghee,butter,maida,\r\npepper,rice flour,salt,sooji,rava,semolina'),
(37, 'samosa', 1, 'potato,maida,oil,carom seeds,ajwain,salt,\r\nwater'),
(38, 'tandoori chicken', 0, 'chat masala,chicken legs,Coriander Powder,Cumin Seed Powder,garam masala pdr,Ginger garlic paste,fenugreek leaves,Lemon Juice,oil,Peppercorns pdr,Red Chili Powder,red color,Salt,turmeric,Yogurt'),
(39, 'tomato rice', 1, 'cashewnuts,channa dal,chilli pdr,ginger,gr chilli,rice,cumin,curry leaves,garam masala pdr,oil,hing,,mustard,onion,red chilli,salt,tomato,urad dal'),
(40, 'usal pav', 1, 'asafoetida,potato,cumin powder,grated coconut,coriander leaves,green chilies,lemon juice,mustard seeds,onion,Pav,red chili powder,salt,turmeric powder,white peas'),
(41, 'vegetable manchurian', 1, 'ajinomoto,beans,rice,cabbage,capsicum,pepper,carrots,cauliflower,celery,chilli paste,gr chillies,garlic,corn flour,ginger,oil,onion,pepper pdr,salt,sesame oil,soya sauce,sugar,sweet and sour sauce'),
(42, 'chicken roast', 0, 'Chicken,coconut,coriander leaves,coriander pwd,cumin seeds,curry leaves,garamasala pwd,ginger,green chillies,oil,onion,pepper pwd,red chilli powder,salt,turmuric '),
(43, 'achari channa pulao', 1, 'Chickpeas,Oil,Rice,Onion,Green chilies,Bay leaves,Fennel seeds,Mustard seeds,onion seeds,Cumin seeds,Fenugreek seeds,Garam masala,Hing,Ginger garlic paste,Haldi powder,Mustard powder,Chili powder,Mango achaar,Salt,Mint leaves,Coriander leaves'),
(44, 'achari paneer', 1, 'Paneer,Red chilly,Yogurt,Cumin seeds,Mustard seeds,Fenugreek seeds,Tomatoes,Bell pepper,Oil,Onion,Salt,Turmeric,Ginger garlic paste,dil leaves,coriander powder,Vinegar,Sugar'),
(45, 'aloo channa chaat', 1, 'mint,coriander,chat masala,red chilly powder,Green chilly,Onion,Kabuli chana,Potato,Lime juice,Salt,Sweet tamarind chutney,Pomegranate seeds,Cumin powder'),
(46, 'aloo dahi', 1, 'Potato,Yogurt,Cumin seeds,Mustard seeds,Hing,Turmeric,Salt,Chilly powder,Coriander leaves,Oil'),
(47, 'aloo drumstick', 1, 'Potatoes,Green leaves of drumsticks,,Mustard seeds,Cumin seeds,Urad dal,Garlic,Onion,Salt,Turmeric pd,Coriander pd,Chilli pd,Green leaves of drumstick,Tomato puree'),
(48, 'aloo gobi mutter', 1, 'amchoor pdr,cauliflower,coriander leaves,coriander powder,cumin seeds,garam masala,ginger-garlic paste,green peas,green chilli,oil,onion,potatoes,red chili powder,salt,tomatoes,turmeric powder'),
(49, 'aloo palak biryani', 1, 'palak,Bay leaves,Cinnamon sticks,Cloves,Cardamom,Shahi jeera,Green chilly paste,Ginger garlic paste,Mint,coriander,Tomatoes,Yogurt,Salt,Turmeric,Basmati rice,oil,Fried onions'),
(50, 'aloo paratha', 1, 'wheatflour,chat masala,oil,cumin powder,Green chillies,Green coriander leaves,Lemon juice,Onion,Potato,Salt'),
(51, 'arbi fry', 1, 'arbi( taro root),chilli pdr,curry leaves,salt'),
(52, 'bharwan bhindi', 1, 'Amchoor powder,coriander,Besan,Lime,Okra,Salt,Sambar powder,onions'),
(53, 'bombay grilled sandwich', 1, 'Potatoes,Garam masala,Green chilly chopped,Coriander,Red chilly powder,Salt,Chat masala,Onions,Bread slice,Mint chutney,Paneer'),
(54, 'breakfast egg potato bread upma', 0, 'Egg,Potato,Butter,Cumin seeds,Ginger,garlic,Salt,Turmeric,Chilly powder,Onion,Green chilly,Mushrooms,Tomato,Coriander,Bread'),
(55, 'brinjal rasam', 1, 'Brinjal,Tomatoes,Tamarind juice,Dal water,Spice powder,Green chillies,Turmeric powder,Salt,Water,Mustard seeds,Hing,Curry leaves'),
(56, 'butter roast dosa', 1, 'Wheat flour,Salt,Butter,Baking powder,Butter milk,Water'),
(57, 'cabbage kofta curry', 1, 'cabbage,chana dal,shahi jeera,chilli,red chilli powder,besan,oil for frying,onion,ginger garlic paste,turmeric,red chilli powder,coriander powder,cumin powder,cashew powder,yoghurt,dry mango powder'),
(58, 'carrot and cauliflower pickle', 1, 'Cauliflower,Carrot,Cumin Seed,Curry Leaves,Garlic,Garlic paste,Hing,Lemon Juice,fenugreek powder,Mustard Powder,Mustard Seeds,Oil.Red Chilli,Red Chilli powder,Salt,Turmeric Powder'),
(59, 'cauliflower paratha', 1, 'Cauliflower,Butter,Oil,Salt,pepper powder,Cumin powder,Chilly powder,Amchur powder,Coriander,Wheat flour'),
(60, 'chicken channa masala', 0, 'Chicken,Chana daal,Oil,Onion,Salt,Ginger garlic paste,Turmeric,Chilly powder,Garam masala,Yogurt,Tomatoes,Coriander'),
(61, 'chilli aloo', 1, 'onions,Green bell pepper,Ginger,Garlic,Pepper pd,Green chilli sauce,Soya sauce,Salt,Vinegar,MSG,Tomato ketchup,Water,Cornstarch,All purpose flour,Salt,Chilli paste,Potatoes,Oil'),
(62, 'dahi vada', 1, 'Urad daal,cumin,curry leaves,yogurt,coriander leaves,green chilies,hing,Oil,Red chili,Salt'),
(63, 'dal curry with drumsticks', 1, 'Oil,Tur daal,Channa daal,Pepper corns,Red chilly,Urad dal,Coriander seeds,coconut,Mustard seeds,Cumin seeds,Curry leaves,Turmeric,Hing,Salt,Tomatoes,Drumsticks'),
(64, 'drumsticks leaves dal', 1, 'Rice,Tur dal,Channa dal,Red chillies,Curry leaves,Hing,Salt,Drumstick leaves,Coconut,Oil'),
(65, 'garlic dal fry', 1, 'Tur Daal,Cumin seeds,Garlic slices,Turmeric,Salt,Coriander,Red chilly powder,Garam masala'),
(66, 'garlic pepper meat balls', 0, 'chilli powder,coriander powder,coriander leaves,garlic,cloves,Green Chili,meat,oil,onion,pepper,salt,Rava,Soy Sauce,turmeric powder,water'),
(67, 'gobi butter masala', 1, 'Onions,Cashew nuts,red chilly,Green chilly,Salt,Butter,Tomatoes,Sugar,Whole garam masala,Ginger garlic paste,Kasoori methi,Oil,Corn starch,All purpose flour,Cauliflower,Pepper'),
(68, 'kadai bhindi', 1, 'bell pepper yellow and green,coriander leaves,coriander powder,coriander seeds powder,cumin powder,curry leaves,garama masala powder,ginger garlic paste,green chillies,oil,okra,onion,red chilli powder,salt,tomato,turmuric'),
(69, 'kadai paneer', 1, 'Paneer,Pepper corns,Red chilly,Coriander seeds,Cumin seeds,Fennel seeds,Butter,Chilly powder,Garam masala,Onions,Bell pepper,Tomato puree,Salt,Sugar,Cream'),
(70, 'korma with cashew nuts', 1, 'Cashew nuts,Almonds,Poppy seeds,Melon seeds,Tomato puree,Coriander powder,Cumin powder,Chilly powder,Curd,onions,Cloves,Cardamom,Cinnamon sticks,Bay leaves,Turmeric,Salt,Oil,Cream'),
(71, 'Chocolate Mousse', 1, 'Chocolate,Cream,Oreo Cookies,Melted Butter,Gelatin,Water,Caramel Syrup,Whipped Cream'),
(72, 'Chocolate Mug Cake', 0, 'unsalted butter,chocolate,sugar,eggs,cocoa powder,vanilla paste,salt,all-purpose flour,baking powder,vanilla ice cream'),
(73, 'Peanut Butter Sandwich Cookies', 1, 'butter,light brown sugar,vanilla extract,egg,all-purpose flour,baking soda,baking powder,salt,peanut butter,sugar,whipping cream'),
(74, 'Chocolate Fudge', 1, 'sugar,butter,milk,water,bread,cocoa powder'),
(75, 'Strawberry Shortcake Perfaits', 1, 'strawberries,sugar,vanilla extract,pound cake,whipped cream,jam'),
(76, 'Chocolate Rum Balls', 0, 'Dark Chocolate Sponge,Milk,Dark Rum,Walnuts,Butter,Icing Sugar,Dark Chocolate'),
(77, 'Eggless Golden Yellow Cake', 1, 'milk,sugar,plain flour,vanilla custard powder,baking powder,baking soda,vanilla extract,butter'),
(78, 'Strawberry Souffle - Sweet Dessert', 1, 'vanilla ice cream,cream,powdered sugar,strawberries,gelatin,water'),
(79, 'Eggless Chocolate Cake', 1, 'Flour,salt,Baking Powder,Castor Sugar,Brown Sugar,Cocoa Powder,cornflour,White Vinegar,Vanilla Essence,Oil,Plain Water'),
(80, 'Cheesecake', 1, 'Cottage Cheese,Yogurt,Biscuits,Butter,Water,Gelatin,Orange Squash,Powdered Sugar,Cornflour\r\n'),
(81, 'Stuffed Strawberries', 1, 'Strawberries,Cream Cheese,Powdered Sugar,Vanilla Essence'),
(82, 'Marzipan Lilies', 1, 'Kaju Katli,Saffron,Almonds'),
(83, 'Cinnamon Roll', 1, 'Flour,salt,Butter,milk,fresh Yeast,Sugar,Demerara Sugar,Cinnamon Powder,Raisins'),
(84, 'Trifle Pudding', 1, 'milk,custard powder,sugar,pineapple essence,vanilla sponge,pineapple,strawberries,kiwi,orange veggies,strawberry jelly,whipped cream'),
(85, 'Sweet Mango Pudding', 1, 'condensed milk,yogurt,butter,milk,mangoes\r\n'),
(86, 'Grilled Bananas With Peanut Butter Sauce', 1, 'banana,Brown Sugar,Maple Syrup,Cinnamon Powder,Rum,Peanut Butter,Butter,Cream,Olive Oil,Strawberries'),
(87, 'Coffee Cake ', 0, 'Brown Sugar,Eggs,Plain Flour,Butter,Baking Powder,Milk,Icing Sugar,Coffee Powder'),
(88, 'Apple Crumble', 1, 'apple,brown sugar,cinnamon powder,plain flour,Caster Sugar,Salt,Butter'),
(89, 'Carrot Cake ', 1, 'oil,honey,sugar,milk,vanilla essence,flour,wheat flour,baking powder,soda,cinnamon powder,salt,carrot,raisins,walnuts\r\n'),
(90, 'Fruit & Nut Chocolate', 1, 'white chocolate,dark chocolate,cranberries,walnuts,honey');

-- --------------------------------------------------------

--
-- Table structure for table `recipe_youtube`
--

CREATE TABLE IF NOT EXISTS `recipe_youtube` (
  `recipe_name` varchar(50) NOT NULL,
  `youtube_link` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `recipe_youtube`
--

INSERT INTO `recipe_youtube` (`recipe_name`, `youtube_link`) VALUES
('chilli beef', 'oalyvG8BLlw'),
('salmon fillet', 'cO0omi05PhQ'),
('paneer tikka', 'LhGn1upyy_Q'),
('cooler', 'E88Sr9H3Wi8'),
('aloo gobi', 'IQ7jerp2S80'),
('alu vadi', 'xfRklG8uYUg'),
('stuffed brinjal', 'ZMxF3pKIUGE'),
('butter chicken', 'tD9O-L2Xvzo'),
('cauliflower 65', 'v9NM9tbAOcw'),
('chicken 65', 'EZEaYngbp4w'),
('channa masala', 'pDWfDUi108U'),
('chicken lollipop', 'fAwUCvm5egg'),
('chicken tikka masala 	', 'QPCwH8uJawA'),
('chilli paneer', 'IjRQdZPS8Kc'),
('coconut chutney', '11_MFw24Lto'),
('dal makhani', 'Gq9rHij2z20'),
('dum aloo', 'evpomtCO0mk'),
('egg biryani', 'jPBxl9gFqNY'),
('egg curry', '7zMjCVwTjaU'),
('egg korma', 'TyiY7c28ytc'),
('fish fry', 'qgV469nQxXM'),
('mutton biryani', 'WOvFCGjGp1A'),
('jeera rice', 'k-lz_Q6LTGU'),
('kala vatana amti', 'LhBErQeU5wo'),
('malvani fish curry', 'rYNpy90USEo'),
('mushrooms fry', '-CQ8rRy9was'),
('onion pakora', 'I2ANLkM2x4s'),
('onion samosa', 'a1sUPZIB62g'),
('palak paneer', 'ZtPDWTAYpoY'),
('palak puri', 'iIylW6qmEcQ'),
('rava dosa', '7FDbSvQ8wGo'),
('samosa', 'TnvKRdNhx64'),
('tandoori chicken', 'gsb311KiG1U'),
('tomato rice', '7wDr-qZCVWY'),
('usal pav', 'lNGh2mAOPO8'),
('vegetable manchurian', 'wq4lJhp9gSc'),
('chicken roast', 'tvElYd-A2X0'),
('achari channa pulao', 'k18gU7xOSmc'),
('achari paneer', '_zpM9eK4oU4'),
('aloo channa chaat', '4x_5b0wzaPE'),
('aloo dahi', 'z5jEMu_IdFA'),
('aloo drumstick', 'bTaaOsg1SSs'),
('aloo gobi mutter', 'KZ2v4sUuIoE'),
('aloo palak biryani', 'eRvPsntXXgI'),
('aloo paratha', 'UV3dYBaiVjg'),
('arbi fry', 'Rg_x6XccBH8'),
('bharwan bhindi', '5vrDZorMX8c'),
('bombay grilled sandwich', 'OpxxQYbZsTs'),
('breakfast egg potato bread upma', '881h6JEp6d8'),
('brinjal rasam', 'DloeRxrmrqM'),
('butter roast dosa', 'QrV-WjbyaLA'),
('cabbage kofta curry', 'AwAKHuhPow4'),
(' carrot and cauliflower pickle', '8-S1htwNOyc'),
('cauliflower paratha', 'WSUhnPX_rNQ'),
('chicken channa masala', 'i7MhbJw9OYQ'),
('chilli aloo', '2Tt2BeLP7FE'),
('dahi vada', 'a2Y1p5ily0U'),
('dal curry with drumsticks', 'lLNhV8_f6is'),
('drumsticks leaves dal', '0QroDpQ4Mi8'),
('garlic dal fry', 'f98fODWszRs'),
('garlic pepper meat balls', 'XnnPgByqpTo'),
('gobi butter masala', 'Jgt9iB4h9EQ'),
('kadai bhindi', '1hG99ZMPg8o'),
('kadai paneer', 'EU9KBQC6WAU'),
('korma with cashew nuts', 'Kh7ne2WyoNc'),
('jalebi', 'CTzchNgpEUs'),
('Chocolate Mousse', 'RR4K6Ma3Sc4'),
('Chocolate Mug Cake', 'bESX_cKa2-w'),
('Peanut Butter Sandwich Cookies', 'SE7shxcnY4'),
('Chocolate Fudge', 'zEpEAuSOrA8'),
('Strawberry Shortcake Perfaits', 'UsCCb97C5Ew'),
('Chocolate Rum Balls', 'r0XfWGyG9B8'),
('Eggless Golden Yellow Cake', 'FMuVPUW38Zc'),
('Strawberry Souffle - Sweet Dessert', 'aqflcI5Dv18'),
('Eggless Chocolate Cake', 'FVom69ExYE8'),
('Cheesecake', 'GomJFb1VuNY'),
('Stuffed Strawberries', '-M7bBjA7rfU'),
('Marzipan Lilies', 'Y02Fzh_CveQ'),
('Cinnamon Roll', '5NlE-WxdGZc'),
('Trifle Pudding', 'qzUpn8wlRvQ'),
('Sweet Mango Pudding', 'n8tuIdG59q4'),
('Grilled Bananas With Peanut Butter Sauce', 'PefgVIfocSY'),
('Coffee Cake', 'CKU_KZMrBvM'),
('Apple Crumble', 'y59EyZKaLNY'),
('Carrot Cake', 'FLqtp0trGws'),
('Fruit & Nut Chocolate', 'qwxx5KxRVNY');

-- --------------------------------------------------------

--
-- Table structure for table `temp_ig`
--

CREATE TABLE IF NOT EXISTS `temp_ig` (
  `ingredients` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `temp_ig`
--

INSERT INTO `temp_ig` (`ingredients`) VALUES
('01. 2 cups apple (peeled & chopped)'),
('02. 1/3 cup brown sugar'),
('03. 1/2 tsp cinnamon powder'),
('04. 3/4 cup plain flour'),
('05. 4 tbsp Caster Sugar'),
('06. Salt'),
('07. 30 gms Butter');

-- --------------------------------------------------------

--
-- Table structure for table `temp_recipe_ig`
--

CREATE TABLE IF NOT EXISTS `temp_recipe_ig` (
  `recipe_id` int(11) DEFAULT NULL,
  `recipe_name` varchar(200) DEFAULT NULL,
  KEY `temp_and_recipe_ig_tbl_FK` (`recipe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `temp_recipe_ig`
--

INSERT INTO `temp_recipe_ig` (`recipe_id`, `recipe_name`) VALUES
(84, 'Trifle Pudding'),
(88, 'Apple Crumble');

-- --------------------------------------------------------

--
-- Table structure for table `temp_steps`
--

CREATE TABLE IF NOT EXISTS `temp_steps` (
  `steps` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `temp_steps`
--

INSERT INTO `temp_steps` (`steps`) VALUES
('01. Mix well apple, brown sugar, cinnamon powder and put in a baking tray'),
('02. In a bowl take plain flour, Caster Sugar, salt, butter and mix everything well to make a mixture like bread crumbs'),
('03. Spread the flour mixture on the sugar coated apples from top'),
('04. Bake the apple crumble at 180 C in a preheated oven for at least 10 mins, then at 160 C for another 15 mins approx.'),
('05. The dish is ready to be served hot.');

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE IF NOT EXISTS `test` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`ID`, `NAME`) VALUES
(1, '1. A,2. B,3. C,4. D');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `recipe_details`
--
ALTER TABLE `recipe_details`
  ADD CONSTRAINT `recipe_ig_and_details_FK` FOREIGN KEY (`recipe_id`) REFERENCES `recipe_ig` (`R_id`) ON DELETE CASCADE;

--
-- Constraints for table `temp_recipe_ig`
--
ALTER TABLE `temp_recipe_ig`
  ADD CONSTRAINT `temp_and_recipe_ig_tbl_FK` FOREIGN KEY (`recipe_id`) REFERENCES `recipe_ig` (`R_id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
