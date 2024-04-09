<%@ page import="com.javarush.sopyraev.Location" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="header.jsp" %>
<!DOCTYPE>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Плащ и кинжал</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body class="bg-dark text-warning ">

<c:set var="STREET" value="<%=Location.STREET%>"/>
<c:set var="SLUMS" value="<%=Location.SLUMS%>"/>
<c:set var="APARTMENTS" value="<%=Location.APARTMENTS%>"/>
<c:set var="BACKSTREET" value="<%=Location.BACKSTREET%>"/>

<c:if test="${location == STREET && sessionScope.get('visited') == false}">
    <h1>Локация: Улицы</h1>
    <p>Ты, бывщий полицейский Адам Дженсен, встретил на улицах Детроита свою бывшую коллегу детектива Дженни Алекзендер,
        которая работает под прикрытием с целью вывести на чистую воду продажного полицейского Джека О'Мелли.</p>
    <p>О'Мелли подозревается в продаже оружия, наркотиков и связях с местными бандами. Ты согласился помочь своей
        подруге в этом деле.</p>
    <p>Дженни рассказала, что О'Мелли поставляет местным бандам оружие. Если ты найдёшь это оружие, она выяснит откуда
        оно взялось и заведёт дело. Банда находится в Трущобах.</p>
    <p>Также есть информация о том что О'Мелли нанял киллера чтобы устранить свидетеля. Необходимо встретиться с
        О'Мелли, притворившись тем самым киллером.</p>
    <p>В квартире продажного полицейского также должны быть доказательства его грязных делишек. Надо бы туда
        наведаться.</p>
</c:if>
<c:if test="${location == SLUMS}">
    <h1>Локация: Трущобы</h1>
    <p>Ты решил отправиться в Трущобы для поиска груза оружия который банды получили от О'Мелли.</p>
    <p>Незаметно пробравшись мимо банд ты обнаруживаешь тайник в котором находится груз с оружием, по
        описанию напоминающий тот самый о котором говорила Дженни.</p>
</c:if>
<c:if test="${location == BACKSTREET}">
    <h1>Локация: Улицы около полицейского участка</h1>
    <p>Ты добираешься до места встречи с коррумпированым полицейским. В разговоре с ним тебе удаётся притвориться тем
        самым наёмным убийцей, которого заказал коп.</p>
    <p>О'Мелли рассказал что ему необходимо устранить свидетеля убийства, подстроив его так, словно его убила банда из
        Трущоб, используя особое оружие.</p>
    <p>Благодаря этому он смог бы начать местную войну банд, под которую могли бы попасть и невинные люди.</p>
    <p>Выведав у него всю информацию, а также расположение этого "особого" оружия ты закончил разговор и отправился
        дальше.</p>
</c:if>
<c:if test="${location == APARTMENTS && sessionScope.get('omelliTalkFinal') == false}">
    <h1>Локация: Квартира О'Мелли</h1>
    <p>Информация от Дженни ясно дала понять что самые важные улики находятся в квартире О'Мелли. Ты отправился туда
        чтобы найти то, что поможет закрыть за решёткой этого мерзавца.</p>
    <p>На входной двери стоял электронный замок преграждающий путь, но твои навыки помогают тебе без труда взломать
        замок и оказаться внутри.</p>
    <p>Ты оказываешься в главном зале квартиры, с виду слишком чистой чтобы иметь хоть какие-нибудь зацепки. Но висящий
        электронный замок в другое помещение дал понять, что то что ты ищешь находится именно там.</p>
    <p>Оказавшись там ты видишь перед собой множество ящиков с неизвестным содержимым. Среди них оказывается груз
        оружия. А также пакет с наркотиками. Это уж точно поможет прижать О'Мелли к стенке. </p>
</c:if>
<c:if test="${location == STREET && sessionScope.get('foundWeapon') == true && sessionScope.get('foundWeaponCargoSlums') == true && sessionScope.get('foundWeaponCargoApartments') == true && sessionScope.get('stunnedOmelli') == false && sessionScope.get('bribed') == false}">
    <h1>Локация: Улицы</h1>
    <p>Вернувшись к Дженни с собранными уликами, детектив просит тебя об последней услуге. Необходимо отправиться в
        квартиру О'Мелли, в которую тот только вернулся и задержать до прихода полицейских.</p>
    <p>Осталось последнее дело</p>
</c:if>
<c:if test="${location == STREET && sessionScope.get('visited') == true && (sessionScope.get('foundWeapon') == false || sessionScope.get('foundWeaponCargoSlums') == false || sessionScope.get('foundWeaponCargoApartments') == false)}">
    <h1>Локация: Улицы</h1>
    <p>Ты вернулся на улицы к Дженни. К сожалению тебе пока недостаточно улик для того, чтобы разоблачить О'Мелли. Надо
        продолжать поиски.</p>
</c:if>
<c:if test="${location == APARTMENTS  && sessionScope.get('foundWeapon') == true && sessionScope.get('foundWeaponCargoSlums') == true && sessionScope.get('foundWeaponCargoApartments') == true && sessionScope.get('omelliTalkFinal') == true}">
    <h1>Локация: Квартира О'Мелли</h1>
    <p>Оказавшись снова в квартире мы видим О'Мелли, которому выкладываем, что с минуты на минуту он будет задержан.</p>
    <p>Коп, понимая что прижат к стенке, предлагает нам взятку, в обмен на его побег. Перед тобой стоит выбор: дать
        О'Мелли уйти, заработав деньги, либо оглушить его для задержания.</p>
</c:if>
<c:if test="${location == STREET && sessionScope.get('stunnedOmelli') == true}">
    <h1>Локация: Улицы</h1>
    <p>Вернувшись к Дженни ты сообщаешь ей об своём успехе. Девушка радостно благодарит тебя. Правосудие
        восторжествовало.</p>
    <p>Квест выполнен.</p>
</c:if>
<c:if test="${location == STREET && sessionScope.get('bribed') == true}">
    <h1>Локация: Улицы</h1>
    <p>Вернувшись к Дженни ты сообщаешь ей что О'Мелли удалось сбежать. Теперь поимать его получится не скоро.
        Разочарованная девушка благодарит тебя за помощь.</p>
    <p>Квест выполнен.</p>
</c:if>
<div class="container-fluid">
    <form>
        <c:if test="${location == STREET}">
            <c:if test="${sessionScope.get('foundWeaponCargoSlums') == false}">
                <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('goToSlums')">Отправиться в Трущобы</button>
            </c:if>
            <c:if test="${sessionScope.get('foundWeaponCargoApartments') == false}">
                <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('goToApartments')">Отправиться в квартиру
                    О'Мелли
                </button>
            </c:if>
            <c:if test="${sessionScope.get('foundWeapon') == false}">
                <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('goToMeeting')">Отправиться на встречу с
                    О'Мелли
                </button>
            </c:if>
            <c:if test="${sessionScope.get('foundWeaponCargoApartments') == true && sessionScope.get('foundWeaponCargoSlums') == true && sessionScope.get('foundWeapon') == true && sessionScope.get('win') == false}">
                <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('goToApartments')">Отправиться на задержание
                    О'Мелли
                </button>
            </c:if>
            <c:if test="${sessionScope.get('bribed') == true || sessionScope.get('stunnedOmelli') == true}">
                <button class="btn btn-outline-warning" type="button" class="button" onclick=restart()>Новая игра</button>
            </c:if>
        </c:if>
        <c:if test="${location == SLUMS}">
            <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('goToJenny')">Вернуться в Дженни</button>
            <c:if test="${sessionScope.get('foundWeaponCargoSlums') == false}">
                <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('takeCargo')">Забрать груз</button>
            </c:if>
            <c:if test="${sessionScope.get('foundWeaponCargoApartments') == false}">
                <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('goToApartments')">Отправиться в Квартиру
                    О'Мелли
                </button>
            </c:if>
        </c:if>
        <c:if test="${location == APARTMENTS}">
            <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('goToJenny')">Вернуться в Дженни</button>
            <c:if test="${sessionScope.get('foundWeaponCargoApartments') == false}">
                <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('takeWeaponCargoAndDrugs')">Забрать оружие и
                    наркотики
                </button>
            </c:if>
            <c:if test="${sessionScope.get('foundWeaponCargoSlums') == false}">
                <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('goToSlums')">Отправиться в Трущобы</button>
            </c:if>
            <c:if test="${sessionScope.get('foundWeapon') == false}">
                <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('goToMeeting')">Отправиться на встречу с
                    О'Мелли
                </button>
            </c:if>
            <c:if test="${sessionScope.get('omelliTalkFinal') == true && sessionScope.get('bribed') == false && sessionScope.get('stunnedOmelli') == false}">
                <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('takeBribe')">Взять деньги и дать О'Мелли
                    уйти
                </button>
            </c:if>
            <c:if test="${sessionScope.get('omelliTalkFinal') == true && sessionScope.get('stunnedOmelli') == false && sessionScope.get('bribed') == false}">
                <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('stunOmelli')">Оглушить полицейского</button>
            </c:if>
        </c:if>
        <c:if test="${location == BACKSTREET}">
            <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('goToJenny')">Вернуться в Дженни</button>
            <c:if test="${sessionScope.get('foundWeaponCargoSlums') == false}">
                <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('goToSlums')">Отправиться в Трущобы</button>
            </c:if>
            <c:if test="${sessionScope.get('foundWeaponCargoApartments') == false}">
                <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('goToApartments')">Отправиться в Квартиру
                    О'Мелли
                </button>
            </c:if>
            <c:if test="${sessionScope.get('foundWeapon') == false}">
                <button class="btn btn-outline-warning" type="button" class="button" onclick="selectOption('weaponSearch')">Найти орудие убийства
                </button>
            </c:if>

        </c:if>
    </form>
</div>
<div class="">
    <c:if test="${sessionScope.get('foundWeapon') == true}">
        <p>Обыскав переулок, на который тебе указал О'Мелли вы нашли оружие. Им оказался арбалет. </p>
    </c:if>
    <c:if test="${sessionScope.get('foundWeaponCargoSlums') == true}">
        <p>Ты забрал груз из тайника.</p>
    </c:if>
    <c:if test="${sessionScope.get('foundWeaponCargoApartments') == true}">
        <p>Оружие и наркотики. То что необходиво Дженни в деле против О'Мелли.</p>
    </c:if>
    <c:if test="${sessionScope.get('bribed') == true}">
        <p>Ты решил отпустить копа. Деньги дороже совести.</p>
    </c:if>
    <c:if test="${sessionScope.get('stunnedOmelli') == true}">
        <p>Ты оглушил О'Мелли. Никакие деньги не помогут копу вылезти сухим.</p>
    </c:if>
</div>
<script>
    function restart() {
        $.ajax({
            type: 'POST',
            url: '/mainMenu',
            async: false,
            success: function () {
                location.reload()
            }
        })
    }

    function selectOption(action) {
        $.ajax({
            type: 'POST',
            url: '/start',
            data: {action: action},
            success: function () {
                location.reload();
            }
        });
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>

