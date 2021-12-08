-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2021-12-07 08:17:02
-- 伺服器版本： 10.4.18-MariaDB
-- PHP 版本： 8.0.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `facedb`
--

-- --------------------------------------------------------

--
-- 資料表結構 `faces`
--

CREATE TABLE `faces` (
  `id` int(11) NOT NULL,
  `features` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` double NOT NULL,
  `end_time` double NOT NULL,
  `device` char(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 傾印資料表的資料 `faces`
--

INSERT INTO `faces` (`id`, `features`, `start_time`, `end_time`, `device`) VALUES
(1, '-0.051418057945254558,0.112517370757731522,0.045765614475716247,0.007586310412009041,-0.066795761418807040,-0.016814824425034805,-0.061852544110703775,-0.167474383077064110,0.087826450198114692,-0.099944764240221542,0.277278047683951145,-0.067311295876642321,-0.227094485194652113,-0.113872309783836459,-0.067794654469985463,0.189797076892543159,-0.150755255350044803,-0.109037073837085205,-0.052552411877005906,-0.012753991083568566,0.056362550802432097,0.008640008942260370,0.058799301262025712,0.001365461132743142,-0.051663217606482570,-0.338732418688860781,-0.102876156665288016,-0.064115901368779024,0.039399327045040469,-0.064937834083646923,-0.074700927386036162,0.038552121325795143,-0.145807430438407049,-0.059603824993813191,0.057957978314393525,0.093246222848629018,-0.044471059172934334,-0.061852534289483903,0.231531657762341692,-0.038956015431261683,-0.162687477933896041,0.027010302857628891,0.074725773088730768,0.241089310158382752,0.181950610759970433,0.081356891322058519,0.021505544107262190,-0.145386043016786703,0.084137842784841335,-0.123010430823672898,0.032956011269797948,0.139218206916536608,0.107193656362496420,0.076258246678036531,-0.001872284080857387,-0.119499022697473506,0.039115070546795798,0.092787763515076074,-0.110671065360694737,-0.008081491238304548,0.096777587258196490,-0.109259994724741225,-0.029174136094652213,-0.051329051434703461,0.242469395135904292,0.037505996546575000,-0.109423660903007952,-0.160147803557383561,0.111480465957096639,-0.142980329692363739,-0.113983148878270935,0.030105917530085940,-0.155462966336832431,-0.142898682166229585,-0.314790234163210003,-0.002616282068676763,0.382969212609452103,0.105158199011892467,-0.200876374910404165,0.026555959594907700,0.003087815659290010,-0.015290756177689348,0.149506831130424095,0.148040159182115022,-0.037423967782940180,-0.017152432110402491,-0.122502641534650486,-0.017291544803551266,0.214152355666284433,-0.077108884641489420,-0.062000784321458308,0.164018142339471096,-0.015377381743935796,0.100108450109308411,0.028982321925267771,0.025146445186881274,-0.051904119345565124,0.042740439850982130,-0.127101502828783797,-0.018891487391544629,0.062501245867702865,-0.028070289423906956,0.001451902067312947,0.125112400813536223,-0.128681645958454577,0.104096076221435102,-0.027985360884627740,0.040471677462775989,0.050513762013091670,-0.019867476970924960,-0.107034952125766067,-0.050466391511938789,0.141321324199051052,-0.216036446295775370,0.202836290001869202,0.186982733088654346,0.042595796117728409,0.087054002594638177,0.149830381688359493,0.117267047139731323,-0.007808897849898059,0.003136892428065275,-0.233443961515055087,-0.072130194659550464,0.079681143696819029,-0.009775409730477863,0.123713000350958335,0.004549417644739151', 5.633333333333334, 8.333333333333334, 'walk.mp4'),
(2, '-0.166036967493471549,0.102760331857888423,-0.020223481092052381,-0.052640488188042019,-0.086100817215247233,-0.058904750631419853,0.019793623432394911,-0.080781710044038099,0.137193790163661622,-0.057498278733739847,0.164961023286717828,-0.034225088956414677,-0.220302202906764916,0.026180159102087139,-0.095523990141075169,0.063430583684659397,-0.118217970046107887,-0.143627839743113911,-0.100460555434959839,-0.114358036794134824,0.089545828137607850,0.064312356432563944,-0.043111129297462643,0.086442883447056917,-0.179608652826215409,-0.176519196663723621,-0.049420189707860593,-0.099139163759155352,0.074341433672387089,-0.098597743319439102,-0.017822347909639605,0.028594177452938966,-0.189047546293891838,-0.089618863385231770,0.004725351089947536,0.085724145479378150,-0.038791592515333269,-0.090095933221402719,0.201742415667557323,0.024089328288176996,-0.133318736294253920,-0.002425938898117327,0.102226117503691899,0.332011792259138128,0.124575332845332190,0.004513983301757301,-0.004104190994603712,-0.031478329854597503,0.123782005588539315,-0.225755224950978023,0.046889042145893220,0.138186259347884394,0.179986206356619216,0.098435350037256231,0.065577434811008264,-0.188321717327735449,0.075756667323074622,0.119200009608366450,-0.178259548776950993,0.107507391328938676,0.059468395229367935,-0.044709063020580614,0.032594276588318531,-0.036802627581370172,0.127375717015295736,0.024890827473069799,-0.062960285265914726,-0.058559779886950235,0.128744034554626130,-0.169846193467984435,-0.056173926747984208,0.072769322295169359,-0.076130679686416375,-0.193812720782932685,-0.247306922664407819,0.064173914446327529,0.345100439718512231,0.215515261424369498,-0.097039997883018897,0.055638171640820189,-0.009160345946972976,-0.045314684731610974,0.060372107994330466,0.000707746834539976,-0.152337164969229305,0.016167549920253089,-0.131230726105267897,0.070750456425498737,0.229438505089673839,0.026093110923090430,-0.036450692467757916,0.182627475286116364,0.047091561033711080,-0.054648552822773575,0.050001087422925430,0.058443845448191048,-0.152022391130201162,-0.009613840413264563,-0.073045305907726288,0.036579843854806462,0.057567115109719215,-0.150655560256516358,-0.005302198170149913,0.108362390827692917,-0.182835795962419667,0.098793561158121615,-0.012505476958438998,-0.050719190633199254,-0.106604139519030930,0.022206077092617262,-0.128487802125879985,-0.000594011920153118,0.125838279876796938,-0.172625456616038175,0.154426659900145452,0.178458325564861298,0.027117911611729471,0.139015176928922790,0.096658320975352513,-0.007280107897698696,0.023562760759320598,0.012895170171729853,-0.109506559054382516,-0.139026888020214484,0.075069647060982028,-0.032791989489046276,0.097243250362941472,0.059145631955661734', 12.066666666666666, 16.3, 'walk.mp4'),
(4, '-0.093654352763579002,0.067875009766292002,0.028382040010321710,-0.034985612456997238,-0.100422054067963645,0.010971419069738616,-0.038181767266775878,-0.081814287390027732,0.180495023585501180,-0.112898812584933783,0.186799503224236635,-0.031285428557367552,-0.227142459721792311,-0.094468966445752547,0.011307128075332868,0.137005295285156786,-0.138578691865716669,-0.069136736098499518,-0.105454829831918076,-0.125414121009054635,-0.012729464542298089,0.014193875245040372,0.058509091110456560,0.057080444551649547,-0.131298063056809550,-0.346136759860175003,-0.090357789042450135,-0.162146280422097167,0.051753167896753265,-0.101630183672975924,-0.022042922107946304,0.013154783997950809,-0.192389637657574247,-0.065988190720478693,-0.039204173481890134,0.028686116249965771,-0.012800965707616083,-0.086277612901869277,0.180074871437890194,-0.007551054053363346,-0.131555046850726720,0.015537651920957225,0.025912466574282873,0.202006899742853074,0.215435123727435146,0.004105368793188106,0.071020658580320223,-0.033671886263237825,0.166570337471507846,-0.249098272124926245,0.047736898725963241,0.067097912373996912,0.110326843815190451,0.006408986378283727,0.119552670064426603,-0.118521718432505932,-0.017526636450063613,0.128866824862502866,-0.183627976619061967,0.106680492631026677,0.023668995535089856,-0.041976004138234116,-0.068438614044515858,-0.023880792134219692,0.212422580804143640,0.123079427650996623,-0.097392303709472924,-0.129608927418788267,0.177074427405993134,-0.180881877385434653,-0.015132529173223745,0.083205993668664074,-0.113816976369846432,-0.163385832664512454,-0.345643753664834186,0.071671627985224834,0.426713230780192798,0.154464761558033181,-0.133460060542538062,0.020521698466369084,-0.080107569144595242,-0.015167301822276342,0.025499452078448875,0.065528514174123600,-0.082925048151186537,-0.055871883832982611,-0.056440176122954912,0.062117885195073629,0.208443755762917654,-0.001407969237438270,-0.066932264200988273,0.209480535416376012,-0.014846774953461829,0.022969668894074858,-0.015888215444006381,0.032465419811861858,-0.092575039989536714,-0.065659538656473157,-0.058651750747646607,0.026119376878653254,0.071599139969441158,-0.100824216930639171,-0.000314392184927350,0.078233289470275247,-0.204920133238746999,0.114125773505795572,-0.061240918544076740,-0.051823417877867109,-0.018498631540153708,0.023014185843723160,-0.131744363762083511,0.048553022085910752,0.179671065580277206,-0.274794411517324921,0.193228669109798606,0.178310507677850283,0.015976857323022117,0.138728304065409147,0.036288722608948040,0.037736306104454255,0.005266943478602029,-0.005456752436501639,-0.129324326132025047,-0.126949038108189888,0.039831233530172282,-0.046938602454472511,0.063616015495998518,0.043360632037123044', 19.2, 22.766666666666666, 'walk.mp4'),
(5, '-0.156539660166291617,0.138877721247719771,0.004464000974800072,-0.060396916653011362,-0.108960533843320953,0.000189504430939754,-0.050437159398022818,-0.094110169466219695,0.119593551272855092,-0.094351628174384430,0.131000594181172991,-0.012549723772441639,-0.229295454773248419,-0.017928521495823767,-0.024222394232364261,0.157903894197707090,-0.198242589831352234,-0.168016471260902939,-0.102395389448193944,-0.146779782339638343,-0.001890620253249711,0.031374781155118756,-0.009460958341757456,0.085528105789539857,-0.188608419953608053,-0.264994866707745746,-0.059081431770441582,-0.103427715234312351,0.128704857008129947,-0.074561174374585051,-0.025435942553860301,-0.028799593558206278,-0.182269080596811628,-0.053614151463204737,0.022523272344294715,0.072034882892872770,-0.054400130175054073,-0.070588606610602025,0.235988464717771490,0.048639722661498713,-0.153494541843732207,0.057117399303059951,0.055097187339675190,0.350137483839895236,0.154297609101323507,0.023422451251569915,0.077270325017618199,-0.082979845211786377,0.131441442259386476,-0.192136287689208984,0.093176888046311399,0.171864023103433489,0.081300895515025826,0.071437862354750734,0.009984840229199286,-0.156612921871391003,0.035553760735281541,0.198039814829826355,-0.223649864395459502,0.143485630698063804,0.137412172906539010,-0.073686707691819064,-0.043355009171600435,-0.028052499024745298,0.188211303569522564,0.077595650565390487,-0.103146095047978795,-0.169707278994952943,0.180122349484294064,-0.162556977248659335,-0.053044958916657114,0.026308897581389722,-0.098650662995436608,-0.143961766186882473,-0.323467028199457662,0.063651286942117358,0.368433921944861298,0.189807292585279425,-0.097165677915601170,0.044526985134272015,-0.052310451153008378,-0.018015339660147827,0.087002880944340832,0.088589158712648872,-0.140186694907207116,-0.050866928535933588,-0.058535324957440883,0.071741782640125235,0.198004057594374117,0.055641585340102516,-0.031672225498101288,0.174253918960982690,0.084866966394817125,-0.062509773043440839,0.028368347160079899,0.077072447421504001,-0.187052317694121728,-0.059899384849796108,-0.093135110741736846,-0.021702853999301500,0.018881723581466312,-0.103245907664006834,0.049622938840412627,0.134307228759223352,-0.192885326988556816,0.189818254726774549,-0.007056170380582996,-0.031872600937883057,-0.047642419279059940,0.073611145473870571,-0.119135536107362480,-0.051592329991798774,0.155382365134416833,-0.209050600143039916,0.172291527483977525,0.246825725424523440,0.090984733884825419,0.115760782623992253,0.134833018277205674,0.037919182796031237,0.001139282166738720,0.036116197632223949,-0.160871220423894762,-0.096451301638986547,0.045389579609036446,-0.044419396997374648,0.114683628082275391,0.085663678964563450', 25.566666666666666, 27.666666666666668, 'walk.mp4'),
(6, '-0.083060394742921609,0.103821232353579512,0.044986248705280972,-0.014297398904415027,-0.098784980912731121,-0.103605057125630451,-0.065037139372466357,-0.080304289109086338,0.149053731091218444,-0.063081958458746132,0.188861188823229637,-0.045795267881595922,-0.155240470722113583,-0.072036126041657308,-0.078933329461780319,0.125757040430421685,-0.157159058504725169,-0.099841519679925217,-0.104011294776446203,-0.089745419125442635,0.015735538906022292,0.006070592657548108,0.018062229127916572,0.033098068598606818,-0.063022638836952111,-0.339647620916366577,-0.067114915239484346,-0.092452644485316871,0.085213324897093309,-0.042619116106772256,0.027059363252291940,0.054187723652344859,-0.197568337394766619,-0.127653561532497406,0.009793226772995845,0.065799779233152736,-0.054225405837626084,-0.025091000615733945,0.243625592491398119,-0.013299626055849742,-0.108694870790390113,0.055097964400910353,0.061385123697045733,0.296035979708580144,0.229309279012353456,0.077646730161488875,0.034549466825460326,-0.072804385362422633,0.151475958628197238,-0.245204131897181682,0.055587058539234409,0.158167983162893017,0.103210137570149282,0.036855478043833823,0.131598558634111323,-0.094675644007447643,0.051515721524619078,0.103011592304053379,-0.227105442383517958,0.085499425405917095,0.054493968362269336,-0.027556084963965090,-0.038252792754912210,-0.039309062446429302,0.176349156115153061,0.064857394574847946,-0.038940632128960463,-0.093329495252811742,0.174839886900496816,-0.194443132166993132,-0.017267026625930854,0.056096030545918503,-0.073218488402358478,-0.160687191131180268,-0.331189666300603813,0.015710434117290662,0.400001262557016679,0.180620396790439147,-0.108635449093090350,0.062759521710750180,-0.010555628489396751,-0.068607284368513377,0.095680320673711503,-0.018002446523982370,-0.124992214755652697,-0.047286637382556312,-0.100721841205983126,0.068044966622574685,0.181908068387475724,0.016158435710590995,-0.048072975792296947,0.193866651148012242,0.020409678963765707,-0.013990251449485347,0.021892685908824205,0.013279931543216314,-0.093254640774979983,-0.016575871367160589,-0.165150788650937269,-0.008719323585702949,0.104107420023990010,-0.066836935251134710,0.029101752255060901,0.054695386847812832,-0.170397714903093356,0.068566877994533273,-0.041355249816424224,-0.011198207302248641,-0.050091226853124081,0.003209890287420521,-0.167870841205936594,0.013414158141368057,0.195810210725216011,-0.173894898430125344,0.209027648584483416,0.148095596632728838,-0.002430942394349673,0.108607627655545325,0.104645559334591645,-0.000891418157987399,-0.010652360263956736,-0.056609439115001728,-0.107959950572415572,-0.110250698479071055,0.006248872140294885,-0.000047991616804510,0.123192842896670512,0.069981447229646651', 30.1, 32.5, 'walk.mp4');

-- --------------------------------------------------------

--
-- 資料表結構 `input`
--

CREATE TABLE `input` (
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `input`
--

INSERT INTO `input` (`features`) VALUES
('[-0.190069109201431274,0.151533827185630798,0.003008414059877396,-0.072615124285221100,-0.078594781458377838,0.006033082492649555,-0.065295681357383728,-0.094892777502536774,0.126588553190231323,-0.074107304215431213,0.165005236864089966,-0.005219841375946999,-0.217546582221984863,-0.006320141255855560,0.005481389351189137,0.149960741400718689,-0.202037662267684937,-0.177247375249862671,-0.138180017471313477,-0.135767698287963867,-0.006268719211220741,0.028577407822012901,-0.026246160268783569,0.112387597560882568,-0.246754333376884460,-0.269641190767288208,-0.042736228555440903,-0.121108703315258026,0.141972795128822327,-0.091818310320377350,-0.016242805868387222,-0.041750650852918625,-0.184884011745452881,-0.030989315360784531,0.043629176914691925,0.074418544769287109,-0.053582143038511276,-0.062856703996658325,0.257651984691619873,0.060872912406921387,-0.190664112567901611,0.007871339097619057,0.078469775617122650,0.343777567148208618,0.173609882593154907,0.041290141642093658,0.103050999343395233,-0.067074604332447052,0.141109630465507507,-0.234214857220649719,0.128998070955276489,0.157110333442687988,0.103137105703353882,0.079448603093624115,0.090369291603565216,-0.178901076316833496,0.037816893309354782,0.213701888918876648,-0.197673663496971130,0.153062880039215088,0.131176769733428955,-0.058272264897823334,-0.046356275677680969,-0.011755932122468948,0.217712685465812683,0.088758610188961029,-0.108936719596385956,-0.148699149489402771,0.189832314848899841,-0.151136964559555054,-0.075313180685043335,0.084442406892776489,-0.082740433514118195,-0.151330769062042236,-0.373870670795440674,0.054784670472145081,0.393652915954589844,0.190231263637542725,-0.111656904220581055,0.049140211194753647,-0.006002187728881836,-0.008237163536250591,0.119959637522697449,0.090952038764953613,-0.175468146800994873,-0.055956989526748657,-0.028472296893596649,0.063401319086551666,0.233148008584976196,0.106087759137153625,-0.026869360357522964,0.156598836183547974,0.068083748221397400,-0.081599220633506775,0.024403166025876999,0.076727390289306641,-0.151282772421836853,-0.096324197947978973,-0.045723449438810349,-0.015314268879592419,0.046120956540107727,-0.052372843027114868,0.045110065490007401,0.154154285788536072,-0.233102172613143921,0.160284698009490967,-0.014116981998085976,-0.039835963398218155,-0.033973414450883865,0.095303893089294434,-0.102060191333293915,-0.043590921908617020,0.136052295565605164,-0.270937412977218628,0.159015059471130371,0.247379645705223083,0.046356409788131714,0.077544175088405609,0.105342060327529907,0.010705213993787766,0.019095096737146378,0.061411786824464798,-0.166057765483856201,-0.103882014751434326,0.063106238842010498,-0.079631090164184570,0.101845189929008484,0.059099905192852020]');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `faces`
--
ALTER TABLE `faces`
  ADD PRIMARY KEY (`id`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `faces`
--
ALTER TABLE `faces`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
