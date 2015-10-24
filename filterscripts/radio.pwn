    /*

                    e amiwo, me roba' credito te dozeeo la pese, soy morris.. Te sigo a donde sea.



                    Script creado únicamente para: www.pawnoscripting.com, no aprendes si te encontras conmigo.




    :::::::Creditos:
    Morris
    Calgone


    */
    #include <a_samp>
    #include <ZCMD>
    #include <foreach>
    
    new CocheEstacion[MAX_VEHICLES] = 0;
    new ListaTrackId[MAX_PLAYERS][50];

    #define         DIALOG_1118             (2118) // WA
    #define         DIALOG_1119             (2119) // CHI
    #define         DIALOG_1120             (2120) // TU
    #define         DIALOG_1121             (2121) // RRO
    #define         DIALOG_1122             (2122) // Quedó solo este xD
    public OnFilterScriptInit()
    {
            print("\n--------------------------------------");
            print(" Logeando m_Music bay m0rr1.. Arre n3ptun0");
            print("--------------------------------------\n");
            return 1;
    }
    enum VradioEnum
    {
            NombreRadio[32],
            RadioURL[128],
            ListaTurra
    }
    //
    //
    new ListaCocheRadio[220][VradioEnum] = {
    // Alternative (0-9)
    {"Idobi Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=21585"},
    {"181.FM The Buzz","http://yp.shoutcast.com/sbin/tunein-station.pls?id=37586"},
    {"RauteMusik.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1275071"},
    {"FM4","http://yp.shoutcast.com/sbin/tunein-station.pls?id=581319"},
    {"ChroniX Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377260"},
    {"Pinguin Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=199753"},
    {"KEXP","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1272835"},
    {"KCRW Simulcas","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1269598"},
    {"Metal Only","http://yp.shoutcast.com/sbin/tunein-station.pls?id=477309"},
    {"1.FM Channel X","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1274225"},

    // Blues 10-19)
    {"1.FM - Blues","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1270282"},
    {"BellyUp4Blues","http://yp.shoutcast.com/sbin/tunein-station.pls?id=11408"},
    {"CALMRADIO - BLUES","http://yp.shoutcast.com/sbin/tunein-station.pls?id=205177"},
    {"KOQX Blues Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1271824"},
    {"GotRadio - Bit 'O Blues","http://yp.shoutcast.com/sbin/tunein-station.pls?id=533805"},
    {"radioio blues","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1278494"},
    {"Polskie Radio - Blues","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1044755"},
    {"Big Blue Swing","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377377"},
    {"City Sounds Radio Blues","http://yp.shoutcast.com/sbin/tunein-station.pls?id=20151"},
    {"Calm Radio Blues","http://yp.shoutcast.com/sbin/tunein-station.pls?id=205177"},

    // Classical (20-29)
    {"CLASSICAL 102","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1676910"},
    {"Iowa Public Radio Classical","http://yp.shoutcast.com/sbin/tunein-station.pls?id=177883"},
    {"181.FM Classic Hits","http://yp.shoutcast.com/sbin/tunein-station.pls?id=213419"},
    {"Cinemix","http://yp.shoutcast.com/sbin/tunein-station.pls?id=614375"},
    {"Venice Classic Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1704166"},
    {"Solo Piano SKY.FM.","http://yp.shoutcast.com/sbin/tunein-station.pls?id=600682"},
    {"Mostly Classical - SKY.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=744232"},
    {"Adagio.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=212505"},
    {"Classical 96.3FM CFMZ","http://yp.shoutcast.com/sbin/tunein-station.pls?id=2271823"},
    {"Abacus.fm Mozart Piano","http://yp.shoutcast.com/sbin/tunein-station.pls?id=119965"},

    // Country (30-39)
    {"181.FM Kickin' Country","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1283687"},
    {"Always Country","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1274260"},
    {"COUNTRY 108","http://yp.shoutcast.com/sbin/tunein-station.pls?id=668943"},
    {"181.FM Highway 181","http://yp.shoutcast.com/sbin/tunein-station.pls?id=147942"},
    {"HPR1","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1270526"},
    {"Radio Positiva Sertaneja","http://yp.shoutcast.com/sbin/tunein-station.pls?id=2890335"},
    {"1.FM Country","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1274603"},
    {"Boot Liquor","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377561"},
    {"Absolute COUNTRY Hits","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1268458"},
    {"181.FM Real Country","http://yp.shoutcast.com/sbin/tunein-station.pls?id=163622"},

    // Decades (40-49)
    {"Big R Radio Warm 101.6","http://yp.shoutcast.com/sbin/tunein-station.pls?id=33097"},
    {"Big R Radio The Hawk","http://yp.shoutcast.com/sbin/tunein-station.pls?id=211531"},
    {"Big R Radio 100.7 The Mix","http://yp.shoutcast.com/sbin/tunein-station.pls?id=61826"},
    {"Abacus.fm Vintage Jazz","http://yp.shoutcast.com/sbin/tunein-station.pls?id=242774"},
    {"Oldies104","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1271826"},
    {"1.FM 50s and 60s","http://yp.shoutcast.com/sbin/tunein-station.pls?id=37833"},
    {"The Doo-Wop Express","http://yp.shoutcast.com/sbin/tunein-station.pls?id=727560"},
    {"Beatles Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1273220"},
    {"1.FM 80s Channel","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1274599"},
    {"SKY.FM 80s","http://yp.shoutcast.com/sbin/tunein-station.pls?id=737152"},

    // Easy Listening (50-59)
    {"Slow Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1658657"},
    {"MUSIK.LOUNGE","http://yp.shoutcast.com/sbin/tunein-station.pls?id=130940"},
    {"Blue FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=48138"},
    {"SKY.FM Mostly Classical","http://yp.shoutcast.com/sbin/tunein-station.pls?id=744232"},
    {"Radio227 Easy Listening","http://yp.shoutcast.com/sbin/tunein-station.pls?id=2313198"},
    {"COOL93","http://yp.shoutcast.com/sbin/tunein-station.pls?id=63135"},
    {"KLUX 89.5HD -","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1697"},
    {"AbidingRadio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=470854"},
    {"Lounge Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1288934"},
    {"1.FM The Chillout Loung","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1268725"},

    // Electronic (60-69)
    {"TechnoBase.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377200"},
    {"Vocal Trance","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1177953"},
    {"MUSIK.HOUSE Funky","http://yp.shoutcast.com/sbin/tunein-station.pls?id=2128868"},
    {"Trance Channel","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1193516"},
    {"HouseTime.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377360"},
    {"dubstep.fm","http://yp.shoutcast.com/sbin/tunein-station.pls?id=7225"},
    {"54House.FM.","http://yp.shoutcast.com/sbin/tunein-station.pls?id=2808203"},
    {"#MUSIK.DRUMSTEP","http://yp.shoutcast.com/sbin/tunein-station.pls?id=46883"},
    {"HardBase.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377430"},
    {"Techno4Ever Main","http://yp.shoutcast.com/sbin/tunein-station.pls?id=226769"},

    // Folk (70-79)
    {"Radio Free Vermont","http://yp.shoutcast.com/sbin/tunein-station.pls?id=168942"},
    {"Pink Narodna Muzika","http://yp.shoutcast.com/sbin/tunein-station.pls?id=883729"},
    {"Dzungla Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1279638"},
    {"Folk Alley","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1273365"},
    {"Radio BN","http://yp.shoutcast.com/sbin/tunein-station.pls?id=29949"},
    {"Radio Glas Drine","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1841408"},
    {"COOL radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=550002"},
    {"AM 1710 Antioch OT","http://yp.shoutcast.com/sbin/tunein-station.pls?id=2699"},
    {"A&P Radio Network","http://yp.shoutcast.com/sbin/tunein-station.pls?id=563824"},
    {"New Age SKY.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=412093"},

    // Inspirational (80-89)
    {"Russian Christian Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1280598"},
    {"AbidingRadio INSTRUMENTAL","http://yp.shoutcast.com/sbin/tunein-station.pls?id=470854"},
    {"1-ONE NATION FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1988533"},
    {"XL Radio Gurbani Kirtan","http://yp.shoutcast.com/sbin/tunein-station.pls?id=272693"},
    {"Radio Lumiere Miami","http://yp.shoutcast.com/sbin/tunein-station.pls?id=341387"},
    {"Ancient Faith Music","http://yp.shoutcast.com/sbin/tunein-station.pls?id=2010550"},
    {"Bautista Radio 89.7 FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=347942"},
    {"Radio Nueva Vida","http://yp.shoutcast.com/sbin/tunein-station.pls?id=208506"},
    {"ChristianRock","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1266649"},
    {"FBC Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=95154"},

    // International (90-99)
    {"Arabic Music Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=326370"},
    {"SEOULFM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=246183"},
    {"Radio CARERA NUMBER ONE","http://yp.shoutcast.com/sbin/tunein-station.pls?id=289391"},
    {"Schlagerhoelle","http://yp.shoutcast.com/sbin/tunein-station.pls?id=702040"},
    {"Ballermann-Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=63072"},
    {"RADIONL","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1281197"},
    {"RaDioTEENTAAL","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1268068"},
    {"Tutku Fm","http://yp.shoutcast.com/sbin/tunein-station.pls?id=21994"},
    {"Radio Jacaro","http://yp.shoutcast.com/sbin/tunein-station.pls?id=228698"},
    {"BeirutNights","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1168254"},

    // Jazz (100-109)
    {"SMOOTHJAZZ","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1339789"},
    {"Absolutely Smooth Jazz SKY.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=496891"},
    {"SwissGroove","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1269641"},
    {"Dinner Jazz Excursion","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1272149"},
    {"181.fm The Breeze","http://yp.shoutcast.com/sbin/tunein-station.pls?id=133405"},
    {"A1Smooth","http://yp.shoutcast.com/sbin/tunein-station.pls?id=348116"},
    {"SmoothLounge","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1339960"},
    {"1.FM Bay Smooth Jazz","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1271416"},
    {"CROOZE","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1269135"},
    {"Jazz Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1256018"},

    // Latin (110-119)
    {"Salsa SKY.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=835183"},
    {"La X Estereo 100 Pura Salsa","http://yp.shoutcast.com/sbin/tunein-station.pls?id=96644"},
    {"Reggaeton 24/7","http://yp.shoutcast.com/sbin/tunein-station.pls?id=56349"},
    {"LATINO FM EN DIRECTO","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1280049"},
    {"Suave 107.3 FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1593716"},
    {"LA PACHANGUERA FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=2147665"},
    {"MovidaMix","http://yp.shoutcast.com/sbin/tunein-station.pls?id=181367"},
    {"Latin.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=381441"},
    {"MKM CARAIBE","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1818724"},
    {"FUSION","http://yp.shoutcast.com/sbin/tunein-station.pls?id=2919730"},

    // Metal (120-129)
    {"MUSIK.ROCK","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1275071"},
    {"RockRadio1","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1105299"},
    {"METAL ONLY","http://yp.shoutcast.com/sbin/tunein-station.pls?id=477309"},
    {"RockRadio1","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1105299"},
    {"ChroniX GRIT Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=2187022"},
    {"MUSIK.METAL","http://yp.shoutcast.com/sbin/tunein-station.pls?id=141469"},
    {"Hard Rock Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=625229"},
    {"Death.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=2885733"},
    {"Big R Radio 80s Metal FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=278974"},
    {"1.FM High Voltage","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1272098"},

    // Misc (130-139)
    {"TOP100","http://yp.shoutcast.com/sbin/tunein-station.pls?id=239589"},
    {"TOP 100 ReaLCasT","http://yp.shoutcast.com/sbin/tunein-station.pls?id=242423"},
    {"NeoFM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=548973"},
    {"radioparty.pl","http://yp.shoutcast.com/sbin/tunein-station.pls?id=97678"},
    {"Desetka Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377246"},
    {"Adom 106.3FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=292951"},
    {"Joy FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=3730"},
    {"RADIO INFERNO MANELE","http://yp.shoutcast.com/sbin/tunein-station.pls?id=293251"},
    {"Narodni radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=31307"},
    {"RaDYO DoGu MiX","http://yp.shoutcast.com/sbin/tunein-station.pls?id=245201"},

    // New Age (140-149)
    {"Nirvana Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1272871"},
    {"Radio Art","http://yp.shoutcast.com/sbin/tunein-station.pls?id=411208"},
    {"Trancemission.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1272865"},
    {"Pianorama","http://yp.shoutcast.com/sbin/tunein-station.pls?id=27717"},
    {"RADIO GAIA","http://yp.shoutcast.com/sbin/tunein-station.pls?id=187880"},
    {"M2 CHILLOUT","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1279147"},
    {"Underground Eighties","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377340"},
    {"Digital Relax","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1254140"},
    {"meditation.fm","http://yp.shoutcast.com/sbin/tunein-station.pls?id=2269332"},
    {"1.FM Flashback Alternatives","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1268764"},

    // Pop (150-159)
    {"181.FM - POWER 181","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1283896"},
    {"Radio Paloma","http://yp.shoutcast.com/sbin/tunein-station.pls?id=710507"},
    {"MUSIK.MAIN","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1275878"},
    {".977 The Hitz Channel","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1280356"},
    {"Lux FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=967434"},
    {"Radio VHR","http://yp.shoutcast.com/sbin/tunein-station.pls?id=117838"},
    {"Radio Paloma","http://yp.shoutcast.com/sbin/tunein-station.pls?id=710507"},
    {"ChartHits.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=43280"},
    {"Top Hits Music SKY.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=728272"},
    {"Pop Radio One","http://yp.shoutcast.com/sbin/tunein-station.pls?id=128879"},

    // Public Radio (160-169)
    {"WUNC FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1271964"},
    {"KPBS","http://yp.shoutcast.com/sbin/tunein-station.pls?id=632915"},
    {"89.7 WUWM HD","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1278952"},
    {"WHRO","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1544465"},
    {"KCRW ECLECTIC24","http://yp.shoutcast.com/sbin/tunein-station.pls?id=56697"},
    {"SomaFM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377771"},
    {"WKCR","http://yp.shoutcast.com/sbin/tunein-station.pls?id=2100812"},
    {"Rete Sport","http://yp.shoutcast.com/sbin/tunein-station.pls?id=3090344"},
    {"North Country Public Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=857520"},
    {"RIPR","http://yp.shoutcast.com/sbin/tunein-station.pls?id=232368"},

    // R&B/Urban (170-179)
    {"DEFJAY.DE","http://yp.shoutcast.com/sbin/tunein-station.pls?id=65456"},
    {"Amped FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=178297"},
    {"HIT104","http://yp.shoutcast.com/sbin/tunein-station.pls?id=663859"},
    {"BreakZ.us","http://yp.shoutcast.com/sbin/tunein-station.pls?id=127014"},
    {"181.fm True R&B","http://yp.shoutcast.com/sbin/tunein-station.pls?id=83968"},
    {"1POWER","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1283516"},
    {"BlackBeats.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1543115"},
    {"Lenz Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1273477"},
    {"DEFJAY.COM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=616366"},
    {"Spin 1038","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1328653"},

    // Rap (180-189)
    {"HOT 108 JAMZ","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1281016"},
    {"MUSIK.JAM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1269742"},
    {"181.FM The BEAT","http://yp.shoutcast.com/sbin/tunein-station.pls?id=166078"},
    {"Smoothbeats","http://yp.shoutcast.com/sbin/tunein-station.pls?id=9054"},
    {"108.FM THE HITLIST","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1282490"},
    {"TrueHipHop","http://yp.shoutcast.com/sbin/tunein-station.pls?id=3083251"},
    {"A1Jamz","http://yp.shoutcast.com/sbin/tunein-station.pls?id=49567"},
    {"True Beats","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1267461"},
    {"MKM URBAN","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1818926"},
    {"G'D UP RADIO","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1504548"},

    // Reggae (190-199)
    {"Roots Reggae SKY.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=695657"},
    {"La Grosse Radio Reggae","http://yp.shoutcast.com/sbin/tunein-station.pls?id=5661"},
    {"BigUpRadio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1269793"},
    {"Raggakings","http://yp.shoutcast.com/sbin/tunein-station.pls?id=123431"},
    {"PONdENDS","http://yp.shoutcast.com/sbin/tunein-station.pls?id=221874"},
    {"Reggae141","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1280855"},
    {"Reggae Radio Rasta","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1266989"},
    {"1.FM ReggaeTrade","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1272779"},
    {"Raggakings","http://yp.shoutcast.com/sbin/tunein-station.pls?id=123431"},
    {"Black Roots Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=231554"},

    // Rock (200-209)
    {"181.FM - The Buzz","http://yp.shoutcast.com/sbin/tunein-station.pls?id=37586"},
    {"NOISEfm.pl","http://yp.shoutcast.com/sbin/tunein-station.pls?id=3121111"},
    {"Radio Paradise","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1354805"},
    {"MUSIK.ROCK","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1275071"},
    {"181.FM Good Time Oldies","http://yp.shoutcast.com/sbin/tunein-station.pls?id=25287"},
    {"181.fm Rock 181","http://yp.shoutcast.com/sbin/tunein-station.pls?id=302754"},
    {"ROCKY FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=684390"},
    {"ChroniX Aggression","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1377260"},
    {"Rockenfolie","http://yp.shoutcast.com/sbin/tunein-station.pls?id=2865"},
    {"80s SKY.FM","http://yp.shoutcast.com/sbin/tunein-station.pls?id=737152"},

    // Talk (210-219)
    {"Alex Jones","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1026951"},
    {"AM 1710 Antioch","http://yp.shoutcast.com/sbin/tunein-station.pls?id=2699"},
    {"89.3 KPCC","http://yp.shoutcast.com/sbin/tunein-station.pls?id=179361"},
    {"The Very Best Of Art Bell","http://yp.shoutcast.com/sbin/tunein-station.pls?id=47835"},
    {"KCRW ALL NEWS","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1279013"},
    {"2GB Sydney Talk","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1346749"},
    {"Broadband Comedy Network","http://yp.shoutcast.com/sbin/tunein-station.pls?id=3095781"},
    {"181.FM Comedy Club","http://yp.shoutcast.com/sbin/tunein-station.pls?id=52807"},
    {"Social Crime Radio","http://yp.shoutcast.com/sbin/tunein-station.pls?id=179709"},
    {"Radio Carlin","http://yp.shoutcast.com/sbin/tunein-station.pls?id=1495362"}
    };


    CMD:radioturra(playerid, params[]) {
            if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            ShowPlayerDialog(playerid, DIALOG_1118, DIALOG_STYLE_LIST, "Radio", "Apagar radio\nBuscar por nombre\nBuscar por genero", "Buscar", "Cancelar");
        else SendClientMessage(playerid, -1, "No estás en un vehículo.");

        return 1;
    }


public OnPlayerExitVehicle(playerid, vehicleid)
{
	StopAudioStreamForPlayer(playerid);
	return 1;
}
 	public OnPlayerStateChange(playerid, newstate, oldstate)
    {
            if(newstate == PLAYER_STATE_DRIVER)
            {
                    if(CocheEstacion[GetPlayerVehicleID(playerid)] != 0)
                    {
                            new DaleRadio = CocheEstacion[GetPlayerVehicleID(playerid)]-1;
                            PlayAudioStreamForPlayer(playerid, ListaCocheRadio[DaleRadio][RadioURL]);

                            new Genero[18];
                            if(DaleRadio >= 0 && DaleRadio <= 9) Genero = "Alternativo";
                            else if(DaleRadio >= 10 && DaleRadio <= 19) Genero = "Blues";
                            else if(DaleRadio >= 20 && DaleRadio <= 29) Genero = "Clasicos";
                            else if(DaleRadio >= 30 && DaleRadio <= 39) Genero = "Country";
                            else if(DaleRadio >= 40 && DaleRadio <= 49) Genero = "Decadas";
                            else if(DaleRadio >= 50 && DaleRadio <= 59) Genero = "Easy Listening";
                            else if(DaleRadio >= 60 && DaleRadio <= 69) Genero = "Electronica";
                            else if(DaleRadio >= 70 && DaleRadio <= 79) Genero = "Folk";
                            else if(DaleRadio >= 80 && DaleRadio <= 89) Genero = "Inspirational";
                            else if(DaleRadio >= 90 && DaleRadio <= 99) Genero = "International";
                            else if(DaleRadio >= 100 && DaleRadio <= 109) Genero = "Jazz";
                            else if(DaleRadio >= 110 && DaleRadio <= 119) Genero = "Latino";
                            else if(DaleRadio >= 120 && DaleRadio <= 129) Genero = "Metal";
                            else if(DaleRadio >= 130 && DaleRadio <= 139) Genero = "Misc";
                            else if(DaleRadio >= 140 && DaleRadio <= 149) Genero = "New Age";
                            else if(DaleRadio >= 150 && DaleRadio <= 159) Genero = "Pop";
                            else if(DaleRadio >= 160 && DaleRadio <= 169) Genero = "Public Radio";
                            else if(DaleRadio >= 170 && DaleRadio <= 179) Genero = "R&B/Urban";
                            else if(DaleRadio >= 180 && DaleRadio <= 189) Genero = "Rap";
                            else if(DaleRadio >= 190 && DaleRadio <= 199) Genero = "Reggae";
                            else if(DaleRadio >= 200 && DaleRadio <= 209) Genero = "Rock";
                            else if(DaleRadio >= 210 && DaleRadio <= 219) Genero = "Talk";

                            new string[128];
                            format(string, sizeof(string), "{FFA500}Estación del vehículo:{FFFFFF} %s - {FFA500}Genero:{FFFFFF} %s {FFA500} (Use /Emisoras)", ListaCocheRadio[DaleRadio][NombreRadio], Genero);
                            SendClientMessage(playerid, -1, string);
                                    }
                            }
            return 1;
    }


    public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
    {
            if(dialogid == DIALOG_1118)
            {
                    if(response)switch(listitem)
                    {
                            case 0:
                            {
                                    new RadioCoche = GetPlayerVehicleID(playerid);

                                    if(CocheEstacion[RadioCoche] == 0)
                                    {
                                        SendClientMessage(playerid, -1, "La radio del vehículo está apagada.");
                                            return 1;
                                    }

                                    SendClientMessage(playerid, -1, "Cambiaste de radio :3.");
                                    CocheEstacion[RadioCoche] = 0;
                            		StopAudioStreamForPlayer(playerid);

                            		foreach(Player, i)
                                    {
                                        if(GetPlayerVehicleID(i) == RadioCoche && IsPlayerInAnyVehicle(i) && GetPlayerState(i) == PLAYER_STATE_PASSENGER && i != playerid)
                                        {
                                            StopAudioStreamForPlayer(i);
                                        }
                                    }
                            }
                            case 1:
                            {
                                    ShowPlayerDialog(playerid, DIALOG_1119, DIALOG_STYLE_INPUT, "Buscar radio", "Escribe la estación que deseas sintonizar.", "Buscar", "Cancelar");
                            }
                            case 2:
                            {
                                    ShowPlayerDialog(playerid, DIALOG_1121, DIALOG_STYLE_LIST, "Buscar genero", "Alternativo\nBlues\nClasicos\nCountry\nDecadas\nEasy Listening\nElectronica\nFolk\nInspirational\nInternational\nJazz\nLatina\nMetal\nMisc\nNew Age\nPop\nPublic Radio\nR&B/Urban\nRap\nReggae\nRock\nTalk", "Escuchar", "Cancelar");
                            }
                    }
            }
            if(dialogid == DIALOG_1119)
            {
                    if(response)
                    {
                            if(strlen(inputtext) < 3)
                    {
                            ShowPlayerDialog(playerid, DIALOG_1119, DIALOG_STYLE_INPUT, "Buscar radio", "La búsqueda debe ser al menos de 3 caracteres de longitud.\n\nEscribe la estación que deseas buscar.", "Buscar", "Cancelar");
                    }
                    else
                    {
                        for(new x; x < 50; ++x) ListaTrackId[playerid][x] = -1;

                            new stringg[512], name[32], search[128], iCount;

                            strcat(search, inputtext, sizeof(search));

                                    for (new i=0; i<220; i++)
                                    {
                                            if(strfind(ListaCocheRadio[i][NombreRadio], search, true) != -1 && iCount < 50)
                                            {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[i][NombreRadio]);
                                                    format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                                    ListaTrackId[playerid][iCount++] = i;
                                            }
                                    }
                                    if(iCount == 0)
                                    {
                                        ShowPlayerDialog(playerid, DIALOG_1119, DIALOG_STYLE_INPUT, "Emisoras - Buscar radio", "Busqueda fallada: No se encontraron radios con ese nombre.\n\nIntente de nuevo.", "Buscar", "Cancelar");
                                    }
                                    else
                                    {
                                            ShowPlayerDialog(playerid, DIALOG_1120, DIALOG_STYLE_LIST, "Emisoras - Resultados", stringg, "Escuchar", "Cancelar");
                                    }
                            }
                }
            }
            if(dialogid == DIALOG_1120)
            {
                    if(response)
                    {
                            new t = ListaTrackId[playerid][listitem];
                            new radiovehicle = GetPlayerVehicleID(playerid);

                            if(CocheEstacion[radiovehicle] == t+1)
                            {
                                    SendClientMessage(playerid, -1, "Ya estás sintonizando esa estación.");
                                    return 1;
                            }

                            SendClientMessage(playerid, -1, "Cambiaste de radio :3.");
                            CocheEstacion[radiovehicle] = t+1;
                            PlayAudioStreamForPlayer(playerid, ListaCocheRadio[t][RadioURL]);

                            foreach(Player, i)
                            {
                                    if(GetPlayerVehicleID(i) == radiovehicle && IsPlayerInAnyVehicle(i) && GetPlayerState(i) == PLAYER_STATE_PASSENGER && i != playerid)
                            {
                                    PlayAudioStreamForPlayer(i, ListaCocheRadio[t][RadioURL]);
                            }
                            }
                    }
            }
            if(dialogid == DIALOG_1121)
            {
                    if(response)
                    {
                            new stringg[321], name[32], iCount;

                            for(new x; x < 50; ++x) ListaTrackId[playerid][x] = -1;

                            if(listitem == 0)
                            {
                                for(new r = 0; r < 10; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Alternativo", stringg, "Escuchar", "Cancelar");
                            }
                            if(listitem == 1)
                            {
                                    for(new r = 10; r < 20; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Blues", stringg, "Escuchar", "Cancelar");
                            }
                            if(listitem == 2)
                            {
                                    for(new r = 20; r < 30; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Clasicos", stringg, "Escuchar", "Cancelar");
                            }
                            if(listitem == 3)
                            {
                                    for(new r = 30; r < 40; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Country", stringg, "Play", "Cancel");
                            }
                            if(listitem == 4)
                            {
                                    for(new r = 40; r < 50; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Decadas", stringg, "Play", "Cancel");
                            }
                            if(listitem == 5)
                            {
                                    for(new r = 50; r < 60; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Easy Listening", stringg, "Play", "Cancel");
                            }
                            if(listitem == 6)
                            {
                                    for(new r = 60; r < 70; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Electronica", stringg, "Play", "Cancel");
                            }
                            if(listitem == 7)
                            {
                                    for(new r = 70; r < 80; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Folk", stringg, "Play", "Cancel");
                            }
                            if(listitem == 8)
                            {
                                    for(new r = 80; r < 90; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Inspirational", stringg, "Play", "Cancel");
                            }
                            if(listitem == 9)
                            {
                                    for(new r = 90; r < 100; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - International", stringg, "Play", "Cancel");
                            }
                            if(listitem == 10)
                            {
                                    for(new r = 100; r < 110; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Jazz", stringg, "Play", "Cancel");
                            }
                            if(listitem == 11)
                            {
                                    for(new r = 110; r < 120; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Latina", stringg, "Play", "Cancel");
                            }
                            if(listitem == 12)
                            {
                                    for(new r = 120; r < 130; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Metal", stringg, "Play", "Cancel");
                            }
                            if(listitem == 13)
                            {
                                    for(new r = 130; r < 140; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Misc", stringg, "Play", "Cancel");
                            }
                            if(listitem == 14)
                            {
                                    for(new r = 140; r < 150; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - New Age", stringg, "Play", "Cancel");
                            }
                            if(listitem == 15)
                            {
                                    for(new r = 150; r < 160; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Pop", stringg, "Play", "Cancel");
                            }
                            if(listitem == 16)
                            {
                                    for(new r = 160; r < 170; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Public Radio", stringg, "Play", "Cancel");
                            }
                            if(listitem == 17)
                            {
                                    for(new r = 170; r < 180; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - R&B/Urban", stringg, "Play", "Cancel");
                            }
                            if(listitem == 18)
                            {
                                    for(new r = 180; r < 190; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Rap", stringg, "Play", "Cancel");
                            }
                            if(listitem == 19)
                            {
                                    for(new r = 190; r < 200; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Reggae", stringg, "Play", "Cancel");
                            }
                            if(listitem == 20)
                            {
                                    for(new r = 200; r < 210; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Rock", stringg, "Play", "Cancel");
                            }
                            if(listitem == 21)
                            {
                                    for(new r = 210; r < 220; ++r)
                                {
                                    format(name, sizeof(name), "%s", ListaCocheRadio[r][NombreRadio]);
                                            format(stringg, sizeof(stringg), "%s %s\n", stringg, name);
                                            ListaTrackId[playerid][iCount++] = r;
                                }
                    ShowPlayerDialog(playerid, DIALOG_1122, DIALOG_STYLE_LIST, "Estaciones - Talk", stringg, "Play", "Cancel");
                            }
					}
            }
            else if(dialogid == DIALOG_1122)
            {
                    if(response)
                    {
                        new t = ListaTrackId[playerid][listitem];
                            new radiovehicle = GetPlayerVehicleID(playerid);

                            if(CocheEstacion[radiovehicle] == t+1)
                            {
                                    SendClientMessage(playerid, -1, "Ya estás sintonizando esa estación.");
                                    return 1;
                            }

                			SendClientMessage(playerid, -1, "Cambiaste de radio :3.");
                            CocheEstacion[radiovehicle] = t+1;
                            PlayAudioStreamForPlayer(playerid, ListaCocheRadio[t][RadioURL]);

                            foreach(Player, i)
                            {
                                    if(GetPlayerVehicleID(i) == radiovehicle && IsPlayerInAnyVehicle(i) && GetPlayerState(i) == PLAYER_STATE_PASSENGER && i != playerid)
                            {
                                    PlayAudioStreamForPlayer(i, ListaCocheRadio[t][RadioURL]);
                            }
                            }
                    }
            }
            return 1;
    }
