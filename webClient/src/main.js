let webSocket;
let db;
let activeChat;

$(window).on('click', function (e){
    const obj = e.target
    if(obj.classList.contains('openSignField')){
        $('.loginField').hide();
        $(".signUpField").show();
    }
    if(obj.classList.contains('openLoginField')){
        $('.signUpField').hide();
        $('.loginField').show();
    }
    if(obj.classList.contains('loginUser')){
        funcAuthUser();
    }
    if(obj.classList.contains('registerUser')){
        funcRegisterUser();
    }
    if(obj.classList.contains('list-group-item-action')){
        $('#default').hide();
    }
    if(obj.classList.contains('changeAvatar')){
        $('.windowChangeAvatar').show();
    }
    if(obj.id === "isVisibleUser"){
        changeVisible(obj)
    }
    let container = $(".newNOU");
    if (container.has(e.target).length === 0 && container.is(':visible')){
        $('.newNameUser').val("");
        container.hide();
        $('#nameOfUser').show();
        $('.editName').show();
    }
    if(obj.classList.contains('editName')){
        $('#nameOfUser').hide();
        $('.editName').hide();
        $('.newNOU').show();
    }
    if(obj.classList.contains('changeName')){
        changeName()
    }
    if(obj.parentElement.id === "myList"){
        clearAndHideInputImgMsg();
        $('.inputMsg').show();
        activeChat = obj;
        recoveryMsg(obj);
    }
    if(obj.classList.contains('sendMsg')){
        sendMsg();
    }
    if(obj.classList.contains('button-addImg')){
        $('#fileImgMsg').trigger('click');
    }
    if(obj.classList.contains('peopleTab')){
        printFriendsList();
    }
    if(obj.id === 'people-tab-1'){
        printFriendsList();
    }
    if(obj.classList.contains('acceptFriend')){
        acceptAddFriend(obj);
    }
    if(obj.classList.contains('denyFriend')){
        denyAddFriend(obj);
    }
    if(obj.classList.contains('actionsFriend') || obj.parentNode.classList.contains('actionsFriend')){
        addFriend(obj);
    }
    if(obj.classList.contains('deleteAvatar')){
        deleteAvatar();
    }
    if(obj.classList.contains('goToChatUser')){
        addChat(obj);
    }
    if( obj.classList.contains('elementFriends') ||
        obj.classList.contains('elementUsers') ||
        obj.classList.contains('elementRequests')){
        onUserClick(obj);
    }
    if(obj.classList.contains('actWithFriends')){
        actWithFriends(obj);
    }
});



$(document).ready(function (){
    if (typeof webSocket === "undefined" )
    {
        connectToServer();
    }

    let f = $('#fileImgMsg');
    f.change(function()
    {
        if (f[0].value.length)
        {
            $('.msgWindow').css({"height" : "74vh"});
            $('.blockImgMsg').show();
            $('.textAreaMsg').prop('disabled', true);
        }
        else
        {
            clearAndHideInputImgMsg();
        }
    });

});

function connectToServer(){
    try
    {
        webSocket = new WebSocket("ws:servchat.ddns.net:9001");
        webSocket.onopen = () => onOpen();
        webSocket.onmessage = ({data}) => onMessage(data);
        webSocket.onclose = (event) => onClose(event);
        webSocket.onerror = () => onError(error);
        workWithDB();
    }
    catch (e)
    {
        alert(e.message);
    }
}
function onMessage(data){
    parseMessage(data);
}
function onOpen(){
    $('.startScreen').hide();
    let myToken =  localStorage.getItem('token');
    if(myToken === null || myToken.trim() === '') {
        $('.authUser').show();
    }else{
        let data = {
            type : "AUTHTOKEN::",
            token : myToken
        };
        let jsonString = JSON.stringify(data);
        if(webSocket.readyState === WebSocket.OPEN){
            webSocket.send(jsonString);
        }
    }
}
function onClose(event){
    if (event.wasClean)
    {
        alert('Соединение закрыто чисто');
    }
    else
    {
        alert('Обрыв соединения'); // например, "убит" процесс сервера
    }
    $('.startScreen').hide();
    $('.authUser').hide();
    $('.mainContent').hide();
    $('.userProfile').hide();
    $('.errorScreen').show();
}
function onError(error){
    alert("Ошибка " + error.message);
    $('.startScreen').hide();
    $('.authUser').hide();
    $('.mainContent').hide();
    $('.userProfile').hide();
    $('.errorScreen').show();
}


function parseMessage(data) {
    let posTypeMsg = data.indexOf('::');
    let typeMsg = data.substring(0,posTypeMsg);
    switch (typeMsg){
        case 'RESULTDB':
        {
            let typeOperWithMsg = data.slice(posTypeMsg + 2);
            let posTypeOper = typeOperWithMsg.indexOf('::');
            let typeOper = typeOperWithMsg.substring(0, posTypeOper);
            let statusWithMsg = typeOperWithMsg.slice(posTypeOper + 2);
            let posStatus = statusWithMsg.indexOf('::');
            let status = statusWithMsg.substring(0, posStatus);
            let msg = statusWithMsg.slice(posStatus + 2);
            if (typeOper === "AUTH")
            {
                if(status === "SUCCESS")
                {
                    let dataFS = JSON.parse(msg);
                    authorization(dataFS);
                }
                if(status === "ERROR")
                {
                    alert("Ошибка авторизации");
                }
            }
            if (typeOper === "AUTHTOKEN")
            {
                if (status === "SUCCESS")
                {
                    let dataFS = JSON.parse(msg);
                    deviceAuth(dataFS);
                }
                if (status === "ERROR"){
                    $('.authUser').show();
                }
            }
            if (typeOper === "UPDATE")
            {
                let posOper = msg.indexOf('::');
                let oper = msg.substring(0, posOper);
                msg = msg.slice(posOper + 2);
                if (status === "SUCCESS")
                {
                    if (oper === "VISIBLE")
                    {
                        let isVisible = (msg === 'true');
                        localStorage.setItem('isVisible', isVisible);
                        try
                        {
                            let data =
                            {
                                type : "VISIBLE::",
                                confirmUpVisible : true,
                                isVisible : isVisible
                            };
                            let jsonString = JSON.stringify(data);
                            webSocket.send(jsonString);
                            $('#isVisibleUser').prop('checked', isVisible);
                            if(isVisible){
                                $('#visibleStatus').text("(Виден всем)");
                            }else{
                                $('#visibleStatus').text("(Включен режим призрака)");
                            }
                        }
                        catch (e)
                        {
                            alert("Ошибка авторизации");
                        }
                    }
                    if (oper === "SETAVATAR")
                    {
                        localStorage.setItem('isAvatar', true);
                        $('#imageOfUser')
                            .attr(
                                "src",
                                `http://imagerc.ddns.net:80/avatar/avatarImg/${localStorage.getItem('tagUser')}.jpg?time=${Date.now()}`
                            );
                    }
                    if (oper === "DELETEAVATAR")
                    {
                        localStorage.setItem('isAvatar', false);
                        $('#imageOfUser')
                            .attr(
                                "src",
                                `./img/user_photo.png`
                            );
                    }
                    if (oper === "NEWNAME")
                    {
                        localStorage.setItem('nickname', msg);
                        $('#nameOfUser').text(msg);
                        try
                        {
                            let data =
                            {
                                type : "SETNAME::",
                                confirmSetname : true,
                                newUserName : msg
                            };
                            let jsonString = JSON.stringify(data);
                            webSocket.send(jsonString);
                        }
                        catch (e)
                        {
                            alert("Ошибка изменения имени");
                        }
                    }
                }
                if (status === "ERROR")
                {
                    if (oper === "NEWNAME")
                    {
                        alert("Ошибка изменения имени. Попробуйте позже.");
                    }
                    if (oper === "VISIBLE")
                    {
                        alert("Ошибка изменения статуса. Попробуйте позже.");
                    }
                }
            }
            if (typeOper === "DOWNLOAD")
            {
                let posOper = msg.indexOf('::');
                let oper = msg.substring(0, posOper);
                msg = msg.slice(posOper + 2);
                if (status === "SUCCESS")
                {
                    if (oper === "ALLDLG")
                    {
                        let parseMsg = JSON.parse(msg);
                        if (parseMsg.token !== localStorage.getItem('tokenQuery')) return;
                        let listOfData = parseMsg.listOfData;
                        $.each(listOfData, function ()
                        {
                            let dialog_id = this.dialog_id;
                            let tagUser = this.tagUser;
                            let enteredTime = this.enteredTime;
                            db.transaction(function(tx)
                            {
                                tx.executeSql
                                (
                                    "INSERT INTO UserDlgTable values(?, ?, ?)",
                                    [dialog_id, tagUser, enteredTime],
                                    null,
                                    null
                                );
                            });
                        });
                        getAllData();

                    }
                    if (oper === "ALLTAGNAME")
                    {
                        let parseMsg = JSON.parse(msg);
                        if (parseMsg.token !== localStorage.getItem('tokenQuery')) return;
                        let listOfData = parseMsg.listOfData;
                        $.each(listOfData, function ()
                        {
                            let tagUser = this.tagUser;
                            let nickUser = this.nickUser;

                            db.transaction(function(tx)
                            {
                                tx.executeSql
                                (
                                    "INSERT INTO ListUsersChat values(?, ?)",
                                    [tagUser, nickUser],
                                    null,
                                    null
                                );
                                addChatInWindow();
                            });
                        });
                    }
                    if (oper === "ALLFRND")
                    {
                        let parseMsg = JSON.parse(msg);
                        if (parseMsg.token !== localStorage.getItem('tokenQuery')) return;
                        let listOfData = parseMsg.listOfData;
                        $.each(listOfData, function ()
                        {
                            let tagSenderFriend = this.tagSenderFrnd;
                            let tagReceiverFriend = this.tagReceiverFrnd;
                            let nameFriend = this.nameFrnd;
                            let status = this.status;
                            db.transaction(function(tx)
                            {
                                tx.executeSql
                                (
                                    "INSERT INTO FriendsTable values(?, ?, ?, ?)",
                                    [tagSenderFriend, tagReceiverFriend, nameFriend, status],
                                    null,
                                    null
                                );
                            });
                            if(tagSenderFriend === localStorage.getItem('tagUser'))
                            {
                                if(status === 0)
                                {
                                    addRequestsUser(tagReceiverFriend, nameFriend);
                                }
                            }
                        });
                    }
                    if (oper === "ALLMSG")
                    {
                        let parseMsg = JSON.parse(msg);
                        if (parseMsg.token !== localStorage.getItem('tokenQuery')) return;
                        let listOfData = parseMsg.listOfData;
                        $.each(listOfData, function ()
                        {
                            let dialog_id = this.dialog_id;
                            let sender = this.sender;
                            let typeMsg = this.typeMsg;
                            let textMsg = this.textMsg;
                            let timeCreated = this.timeCreated;
                            db.transaction(function(tx)
                            {
                                tx.executeSql
                                (
                                    "INSERT INTO MsgDlgTable values(?, ?, ?, ? ,?)",
                                    [dialog_id, sender, typeMsg, textMsg, timeCreated],
                                    null,
                                    null
                                );
                            });
                        });
                    }
                }
            }
            if (typeOper === "INSERT")
            {
                let posOper = msg.indexOf('::');
                let oper = msg.substring(0, posOper);
                msg = msg.slice(posOper + 2);
                if (status === "SUCCESS")
                {
                    if (oper === "NEWMSGDLG")
                    {
                        let dataMsg = JSON.parse(msg);
                        messageTo(dataMsg);
                    }
                    if (oper === "NEWUSERDLG")
                    {
                        let dataMsg = JSON.parse(msg);
                        let dialog_id = dataMsg.dialog_id;
                        let enteredTime = dataMsg.enteredTime;
                        if (dataMsg.Icreater)
                        {
                            let tagUser = dataMsg.userCompanion;
                            db.transaction(function(tx)
                            {
                                tx.executeSql
                                (
                                    "INSERT INTO UserDlgTable values(?, ?, ?)",
                                    [dialog_id, tagUser, enteredTime],
                                    null,
                                    null
                                );
                            });
                        }
                        else
                        {
                            let tagUser = dataMsg.userManager;
                            db.transaction(function(tx)
                            {
                                tx.executeSql
                                (
                                    "INSERT INTO UserDlgTable values(?, ?, ?)",
                                    [dialog_id, tagUser, enteredTime],
                                    null,
                                    null
                                );
                            });
                        }
                        let allDlg = [`${dialog_id}`];
                        let data =
                            {
                                type : "DOWNLOAD::",
                                table : "ALLTAGNAME::",
                                dialog_ids : allDlg
                            };
                        let jsonString = JSON.stringify(data);
                        if(webSocket.readyState === WebSocket.OPEN)
                        {
                            webSocket.send(jsonString);
                        }
                    }
                }
            }
            if (typeOper === "FRND")
            {
                let posOper = msg.indexOf('::');
                let oper = msg.substring(0, posOper);
                msg = msg.slice(posOper + 2);
                if (status === "SUCCESS")
                {
                    if (oper === "ADD")
                    {
                        let dataMsg = JSON.parse(msg);
                        addUserInFriend(dataMsg);
                        let tagUser = $('.userProfile').find($('#user_tagOfUser'))[0].textContent;
                        let user = $('#user_ActionsFriends');
                        if (localStorage.getItem('tagUser') === dataMsg.tagUserSender)
                        {
                            if (tagUser === dataMsg.tagUserReceiver)
                            {
                                $('#user_statusFriends')[0].textContent = "Запрос отправлен";
                                user[0].textContent = "Ожидание";
                                user.removeClass('add');
                                user.removeClass('confirm');
                                user.removeClass('delete');
                                user.addClass('wait');
                            }
                            alert("Заявка на добавление в друзья успешно отправлена");
                            $(`#user_${dataMsg.tagUserReceiver}`).find('.actionsFriend')
                                 .html('<i class="fa-solid fa-user-clock"></i>')
                        }
                        else
                        {
                            addRequestsUser(dataMsg.tagUserSender, dataMsg.nameUserSender);
                            if (tagUser === dataMsg.tagUserSender)
                            {
                                $('#user_statusFriends')[0].textContent = "Не подтверждено";
                                user[0].textContent = "Принять запрос";
                                user.removeClass('add');
                                user.removeClass('wait');
                                user.removeClass('delete');
                                user.addClass('confirm');
                            }
                        }

                    }
                    if (oper === "DELETE")
                    {
                        let dataMsg = JSON.parse(msg);
                        deleteUserFromFriend(dataMsg);
                        let user = $('#user_ActionsFriends');
                        let tagUser = $('.userProfile').find($('#user_tagOfUser'))[0].textContent;
                        if (tagUser === dataMsg.tagUserFriend || tagUser === dataMsg.tagUserOur)
                        {
                            $('#user_statusFriends')[0].textContent = "Не в друзьях";
                            user[0].textContent = "Добавить в друзья";
                            user.removeClass('confirm');
                            user.removeClass('wait');
                            user.removeClass('delete');
                            user.addClass('add');
                        }
                        if (dataMsg.typeDelete === "DELFROMFRND")
                        {
                            let id = (localStorage.getItem('tagUser') === dataMsg.tagUserOur) ?
                                dataMsg.tagUserFriend : dataMsg.tagUserOur;
                            $(`#frnd_${id}`).remove();
                            $(`#user_${id}`).find('.actionsFriend')
                                .html('<i class="fa-solid fa-user-plus"></i>')
                            //обновить статус открытых друзей(открытый профиль друга)
                        }
                        if (dataMsg.typeDelete === "DELFROMREQ")
                        {
                            let id = (localStorage.getItem('tagUser') === dataMsg.tagUserOur) ?
                                dataMsg.tagUserFriend : dataMsg.tagUserOur;
                            $(`#requests_${id}`).remove();
                            $(`#user_${id}`).find('.actionsFriend')
                                .html('<i class="fa-solid fa-user-plus"></i>')
                        }
                        if (localStorage.getItem('tagUser') === dataMsg.tagUserOur)
                        {
                            alert("Удалено");
                        }
                    }
                    if (oper === "CNFRMADD")
                    {
                        let dataMsg = JSON.parse(msg);
                        updateUserFriends(dataMsg);
                        let user = $('#user_ActionsFriends');
                        let tagUser = $('.userProfile').find($('#user_tagOfUser'))[0].textContent;
                        if (tagUser === dataMsg.tagUserFriend || tagUser === dataMsg.tagUserOur)
                        {
                            $('#user_statusFriends')[0].textContent = "В друзьях";
                            user[0].textContent = "Удалить из друзей";
                            user.removeClass('add');
                            user.removeClass('confirm');
                            user.removeClass('wait');
                            user.addClass('delete');
                        }
                        let id = (localStorage.getItem('tagUser') === dataMsg.tagUserOur) ?
                            dataMsg.tagUserFriend : dataMsg.tagUserOur;
                        $(`#requests_${id}`).remove();
                        $(`#user_${id}`).find('.actionsFriend').html('<i class="fa-solid fa-user-check"></i>')
                        if (localStorage.getItem('tagUser') === dataMsg.tagUserOur)
                        {
                            alert("Пользователь добавлен в список друзей");
                        }
                    }
                    if (oper === "FIND")
                    {
                        let dataMsg = JSON.parse(msg);
                        addSearchedPeople(dataMsg);
                    }
                }
            }
            break;
        }
        case 'ONLINE':
        {
            let idWithName = data.slice(posTypeMsg + 2);
            let posOper = idWithName.indexOf('::');
            let id = idWithName.substring(0, posOper);
            let name = idWithName.slice(posOper + 2);
            if (name !== "UNNAMED" && id !== localStorage.getItem('tagUser'))
            {
                addUserInOnline(id, name);
                updateNameInUserChat(id, name);
                updateNameInFriends(id, name);
                updateAddUsersList(id, name);
            }
            break;
        }
        case 'OFFLINE':
        {
            let idWithName = data.slice(posTypeMsg + 2);
            let posOper = idWithName.indexOf('::');
            let id = idWithName.substring(0, posOper);
            let name = idWithName.slice(posOper + 2);
            deleteUserFromOnline(id);
            updateDeleteUsersList(id);
            break;
        }
        case 'MESSAGE_FROM':
        {
            let msg = data.slice(posTypeMsg + 2);
            let dataMsg = JSON.parse(msg);
            messagePrint(dataMsg);
            break;
        }
        default:{
            break;
        }
    }
}



function funcRegisterUser(){
    try{
        let login = $("#inputSignLogin").val().trim();
        let name = $("#inputSignName").val().trim();
        let pass1 = $("#inputPassSign1").val().trim();
        let pass2 = $("#inputPassSign2").val().trim();
        if(!login || !name || !pass1 || !pass2){
            alert("Необходимо заполнить все поля!");
            return;
        }
        if(pass1 !== pass2){
            alert("Пароли не совпадают!");
            return;
        }
        if(!$("#checkBoxSign").is(":checked")){
            alert("Вы не дали согласия на обработку!");
            return;
        }
        let data = {
            type : "SIGNUP::",
            loginSignUp : login,
            passSignUp : pass1,
            userNameSignUp : name
        };
        let jsonString = JSON.stringify(data);
        $(':input','.signUpField').val("");
        webSocket.send(jsonString);
    }catch (e){
        alert("Ошибка регистрации: "+ e);
    }
}
function funcAuthUser() {
    try{
        let login = $("#inputLoginUser").val().trim();
        let pass = $("#inputPassLogin").val().trim();
        if(!login || !pass) return;
        let data = {
            type : "AUTH::",
            confirmAuth : false,
            loginAuth : login,
            passAuth : pass
        };
        let jsonString = JSON.stringify(data);
        $(':input','.loginField').val("");
        webSocket.send(jsonString);
    }catch (e){
        alert("Ошибка авторизации");
    }
}

function deviceAuth(dataFS) {
    $('.authUser').hide();
    localStorage.setItem('isAvatar', dataFS.isAvatar);
    localStorage.setItem('nickname', dataFS.nickname);
    localStorage.setItem('tagUser', dataFS.tagUser);
    localStorage.setItem('isVisible', dataFS.isAvatar);
    localStorage.setItem('isAuth', true);
    $('.mainContent').show();
    if(dataFS.isAvatar){
        $('#imageOfUser').attr("src",`http://imagerc.ddns.net:80/avatar/avatarImg/${dataFS.tagUser}.jpg?time=${Date.now()}`);
    }
    $('#nameOfUser').text(dataFS.nickname);
    $('#tagOfUser').text(dataFS.tagUser);
    $('#visibleStatus').text("(Включен режим призрака)");
    if(dataFS.isVisible){
        $('#isVisibleUser').prop('checked', true);
        $('#visibleStatus').text("(Виден всем)");
    }

    let time = Date.now().toString();
    let platform = "Web";
    let tagUser = localStorage.getItem('tagUser');
    $.post('src/jwt.php', {platform: platform, tagUser: tagUser, time : time}, function(data){
        if(data === '') return;
        localStorage.setItem('tokenQuery', data);
        let dataDB = {
            type : "AUTH::",
            confirmAuth : true,
            nickname : dataFS.nickname,
            tagUser : dataFS.tagUser,
            isVisible : dataFS.isAvatar,
            token : data
        };
        let jsonString = JSON.stringify(dataDB);
        if(webSocket.readyState === WebSocket.OPEN){
            webSocket.send(jsonString);
            downloadChat();
        }
    });
}
function authorization(dataFS){
    $('.authUser').hide();
    localStorage.setItem('isAvatar', dataFS.isAvatar);
    localStorage.setItem('nickname', dataFS.nickname);
    localStorage.setItem('tagUser', dataFS.tagUser);
    localStorage.setItem('token', dataFS.token);
    localStorage.setItem('isVisible', dataFS.isVisible);
    localStorage.setItem('isAuth', true);
    $('.mainContent').show();

    if(dataFS.isAvatar){
        $('#imageOfUser').attr("src",`http://imagerc.ddns.net:80/avatar/avatarImg/${dataFS.tagUser}.jpg?time=${Date.now()}`);
    }
    $('#nameOfUser').text(dataFS.nickname);
    $('#tagOfUser').text(dataFS.tagUser);
    $('#visibleStatus').text("(Включен режим призрака)");
    if(dataFS.isVisible){
        $('#isVisibleUser').prop('checked', true);
        $('#visibleStatus').text("(Виден всем)");
    }
    let time = Date.now().toString();
    let platform = "Web";
    let tagUser = localStorage.getItem('tagUser');
    $.post('src/jwt.php', {platform: platform, tagUser: tagUser, time : time}, function(data){
        if(data === '') return;
        localStorage.setItem('tokenQuery', data);
        let dataDB = {
            type : "AUTH::",
            confirmAuth : true,
            nickname : dataFS.nickname,
            tagUser : dataFS.tagUser,
            isVisible : dataFS.isAvatar,
            token : data
        };
        let jsonString = JSON.stringify(dataDB);
        if(webSocket.readyState === WebSocket.OPEN){
            webSocket.send(jsonString);
            downloadChat();
        }
    });
}

function saveNewAvatar ()  {
    let f = newAvatar.files[0];
    if (f) {
        let formData = new FormData();
        formData.append('typeOperation', 'SETAVATAR');
        formData.append('user_id', localStorage.getItem("tagUser"));
        formData.append('image', f);
        jQuery.ajax({
            url: 'src/server.php',
            data: formData,
            contentType: false,
            processData: false,
            method: 'POST',
            type: 'POST',
            success: function(data){
                $('#formLoadAvatar')[0].reset();
                let dataMsg = {
                    type : "SETAVATAR::",
                    successSet : true
                };
                let jsonString = JSON.stringify(dataMsg);
                if(webSocket.readyState === WebSocket.OPEN){
                    webSocket.send(jsonString);
                }
            } ,
            error: function (data) {
                alert("Ошибка смены аватара");
            }
        });
    }
}
function changeName() {
    try{
        let newName = $(".newNameUser").val().trim();
        if(!newName) return;
        let data = {
            type : "SETNAME::",
            confirmSetname : false,
            newUserName : newName
        };
        let jsonString = JSON.stringify(data);
        webSocket.send(jsonString);
        $('.newNOU').hide();
        $('#nameOfUser').show();
        $('.editName').show();
        $('.newNameUser').val("");
    }catch (e){}
}
function changeVisible(obj) {
    try{
        let data = {
            type : "VISIBLE::",
            confirmUpVisible : false,
            isVisible : obj.checked
        };
        let jsonString = JSON.stringify(data);
        webSocket.send(jsonString);
    }catch (e){
        $('#isVisibleUser').prop('checked', !obj.checked);
    }
}
function workWithDB() {
    db = openDatabase
    (
        "ChatUsers",
        "0.1",
        "A list of chat by users.",
        200000
    );
    if(!db){alert("Failed to connect to database.");}

    db.transaction(function(tx)
    {
        tx.executeSql
        (
            "CREATE TABLE UserDlgTable (dialog_id TEXT UNIQUE, tagUser TEXT, enteredTime TEXT)",
            [],
            null,
            null
        );
    });
    db.transaction(function(tx)
    {
        tx.executeSql
        (
            "CREATE TABLE ListUsersChat (tagUser TEXT PRIMARY KEY, nameUser TEXT)",
            [],
            null,
            null
        );
    });
    db.transaction(function(tx)
    {
        tx.executeSql
        (
            "CREATE TABLE FriendsTable (tagSenderFriend TEXT, tagReceiverFriend TEXT, friendName TEXT, status INTEGER)",
            [],
            null,
            null
        );
    });
    db.transaction(function(tx)
    {
        tx.executeSql
        (
            "CREATE TABLE MsgDlgTable (dialog_id TEXT, sender TEXT, typeMsg TEXT, textMsg TEXT, timeCreated INTEGER)",
            [],
            null,
            null
        );
    });
    db.transaction(function(tx)
    {
        tx.executeSql
        (
            "CREATE TABLE OnlineUsers (tagUser TEXT PRIMARY KEY, nameUser TEXT)",
            [],
            null,
            null
        );
    });
}
function downloadChat() {
    db.transaction(function(tx) {
        tx.executeSql("DELETE FROM UserDlgTable", [], function(result){}, function(tx, error){});
    });
    db.transaction(function(tx) {
        tx.executeSql("DELETE FROM ListUsersChat", [], null, null);
    });
    db.transaction(function(tx) {
        tx.executeSql("DELETE FROM FriendsTable", [], null, null);
    });
    db.transaction(function(tx) {
        tx.executeSql("DELETE FROM MsgDlgTable", [], null, null);
    });
    db.transaction(function(tx) {
        tx.executeSql("DELETE FROM OnlineUsers", [], null, null);
    });
    let tagUser = localStorage.getItem("tagUser");
    let data = {
        type : "DOWNLOAD::",
        table : "ALLDLG::",
        tagUser : tagUser,
        token : localStorage.getItem('tokenQuery')
    };
    let jsonString = JSON.stringify(data);
    webSocket.send(jsonString);
}

function addChatInWindow() {
    db.transaction(function(tx)
    {
        tx.executeSql
        (
            "SELECT dialog_id, nameUser, L.tagUser FROM ListUsersChat as L INNER JOIN UserDlgTable as U on L.tagUser = U.tagUser",
            [],
            function(tx, result)
            {
                let newBlockChat = "";
                let newBlockMsg = `<div class="tab-pane fade active show" id="default" role="tabpanel">Выберите чат для общения</div>`;
                for(let i = 0; i < result.rows.length; i++)
                {
                    let tagUser = result.rows.item(i)['tagUser'];
                    let dialog_id = "id-" + result.rows.item(i)['dialog_id'].replace('::', '--').replace('#','-');
                    let nameUser = result.rows.item(i)['nameUser'];
                    newBlockChat += `<a class="list-group-item list-group-item-action" data-mdb-toggle="list" href="#${dialog_id}" role="tab" id="${tagUser}">${nameUser}</a>`;
                    newBlockMsg += `<div class="blockMsgScroll tab-pane fade" id="${dialog_id}" role="tabpanel"><ul class="chatWindow list-group"></div>`;
                }
                $('.chatChannel').html(newBlockChat);
                $('.msgWindow').html(newBlockMsg);
            },
            null
        )
    });
}
function getAllData() {
    db.transaction(function(tx)
    {
        tx.executeSql(
            "SELECT dialog_id FROM UserDlgTable",
            [],
            function(tx, result)
            {
                let allDlg = [];
                for(let i = 0; i < result.rows.length; i++)
                {
                    allDlg.push(result.rows.item(i)['dialog_id']);
                }
                let data =
                {
                    type : "DOWNLOAD::",
                    table : "ALLTAGNAME::",
                    dialog_ids : allDlg,
                    token : localStorage.getItem('tokenQuery')
                };
                let jsonString = JSON.stringify(data);
                webSocket.send(jsonString);

                data =
                {
                    type : "DOWNLOAD::",
                    table : "ALLFRND::",
                    token : localStorage.getItem('tokenQuery')
                };
                jsonString = JSON.stringify(data);
                webSocket.send(jsonString);

                data =
                {
                    type : "DOWNLOAD::",
                    table : "ALLMSG::",
                    dialog_ids : allDlg,
                    token : localStorage.getItem('tokenQuery')
                };
                jsonString = JSON.stringify(data);
                webSocket.send(jsonString);
            },
            null
        )
    });
}

function recoveryMsg(obj) {
    let idChat = obj.hash.slice(4);
    let idDB = idChat.replace('-','#').replace('--','::');
    let idChatImg = idDB.replace('#','%23').replace('::','--');
    db.transaction(function(tx) {
        tx.executeSql(
            "SELECT * FROM MsgDlgTable WHERE dialog_id = ? ORDER BY timeCreated",
            [idDB],
            async function(tx, result) {
            let addMsg = "";
            let localSender = localStorage.getItem('tagUser');
            for(let i = 0; i < result.rows.length; i++) {
                let typeMsg = result.rows.item(i)['typeMsg'];
                let textMsg = result.rows.item(i)['textMsg'];
                let sender = result.rows.item(i)['sender'];
                if(sender === localSender)
                {
                    if (typeMsg === "TEXT")
                    {
                        addMsg += `<li class="list-group-item we"><div class="textMsg bg-light shadow-2">${textMsg}</div></li>`;
                    }
                    if (typeMsg === "IMAGE")
                    {
                        addMsg += `<li class="list-group-item we">
                                        <div class="textMsg bg-light shadow-2">
                                            <img    class="imgMsg"
                                                    src="http://imagerc.ddns.net:80/userImgMsg/${idChatImg}/${textMsg}.jpg?time=${Date.now()}"
                                                    alt="No Found"/>
                                        </div>
                                    </li>`;
                    }
                }
                else
                {
                    if (typeMsg === "TEXT")
                    {
                        addMsg += `<li class="list-group-item fr"><div class="textMsg bg-light shadow-2">${textMsg}</div></li>`;
                    }
                    if (typeMsg === "IMAGE")
                    {
                        addMsg += `<li class="list-group-item fr">
                                        <div class="textMsg bg-light shadow-2">
                                            <img    class="img-fluid imgMsg"
                                                    src="http://imagerc.ddns.net:80/userImgMsg/${idChatImg}/${textMsg}.jpg?time=${Date.now()}"
                                                    alt="No Found"/>
                                        </div>
                                    </li>`;
                    }
                }
            }
            let complete = await $('#id-'+`${idChat} .chatWindow`).html(addMsg);
                if(complete.length){
                    autoScrollDown();
                }
        }, null)
    });
}

function sendMsg() {
    let f = $('#fileImgMsg')[0].files[0];
    if (f) {
        let time = Date.now().toString();
        let dialog_id = activeChat.hash.slice(4).replace('-','#').replace('--','::');
        let id = activeChat.id;
        let formData = new FormData();
        formData.append('typeOperation', 'IMGMSG');
        formData.append('photoName', time);
        formData.append('nameChat', dialog_id)
        formData.append('image', f);
        jQuery.ajax({
            url: 'src/server.php',
            data: formData,
            contentType: false,
            processData: false,
            method: 'POST',
            type: 'POST',
            success: function(data){
                clearAndHideInputImgMsg()
                let dataSend = {
                    type : "MESSAGE_TO::",
                    dialog_id : dialog_id,
                    typeMsg : "IMAGE",
                    id : id,
                    text : time
                };
                let jsonString = JSON.stringify(dataSend);
                if(webSocket.readyState === WebSocket.OPEN){
                    webSocket.send(jsonString);
                }
            } ,
            error: function (data) {
                alert("Ошибка отправки сообщения");
            }
        });
    }else{
        let textAreaMsg = $('.textAreaMsg');
        let msg = textAreaMsg.val().trim();
        if(!msg) return;
        let dialog_id = activeChat.hash.slice(4).replace('-','#').replace('--','::');
        let id = activeChat.id;
        let data = {
            type : "MESSAGE_TO::",
            dialog_id : dialog_id,
            typeMsg : "TEXT",
            id : id,
            text : msg
        };
        let jsonString = JSON.stringify(data);
        textAreaMsg.val("");
        if(webSocket.readyState === WebSocket.OPEN){
            webSocket.send(jsonString);
        }
    }
}
function messageTo(msg) {
    db.transaction(function(tx) {
        tx.executeSql("INSERT INTO MsgDlgTable values(?, ?, ?, ? ,?)", [msg.dialog_id, msg.sender, msg.typeMsg, msg.textMsg, msg.timeCreated], null, null);
        let idChat = msg.dialog_id.replace('#','-').replace('::','--');
        let addedBlock = "";
        if (msg.typeMsg === "TEXT"){
            addedBlock = `<li class="list-group-item we"><div class="textMsg bg-light shadow-2">${msg.textMsg}</div></li>`;
        }
        if (msg.typeMsg === "IMAGE"){
            let idChatImg = msg.dialog_id.replace('#','%23').replace('::','--');
            addedBlock = `<li class="list-group-item we">
                                <div class="textMsg bg-light shadow-2">
                                    <img    class="img-fluid imgMsg"
                                            src="http://imagerc.ddns.net:80/userImgMsg/${idChatImg}/${msg.textMsg}.jpg?time=${Date.now()}"
                                            alt="No Found"/>
                                </div>
                            </li>`;
        }
        $('#id-'+`${idChat} .chatWindow`).append(addedBlock);
        autoScrollDown();
    });
}
function messagePrint(msg) {
    let dialog_id = msg.dialog_id;
    let pos = dialog_id.indexOf('#');
    let typeDialog = dialog_id.substring(0,pos);
    if (typeDialog === "GROUP"){
        if (msg.sender === localStorage.getItem('tagUser')) return;
    }
    db.transaction(function(tx) {
        tx.executeSql("INSERT INTO MsgDlgTable values(?, ?, ?, ? ,?)", [msg.dialog_id, msg.sender, msg.typeMsg, msg.textMsg, msg.timeCreated], null, null);
        let idChat = dialog_id.replace('#','-').replace('::','--');
        let addedBlock = "";
        if (msg.typeMsg === "TEXT"){
            addedBlock = `<li class="list-group-item fr"><div class="textMsg bg-light shadow-2">${msg.textMsg}</div></li>`;
        }
        if (msg.typeMsg === "IMAGE"){
            let idChatImg = msg.dialog_id.replace('#','%23').replace('::','--');
            addedBlock = `<li class="list-group-item fr">
                                <div class="textMsg bg-light shadow-2">
                                    <img    class="img-fluid imgMsg"
                                            src="http://imagerc.ddns.net:80/userImgMsg/${idChatImg}/${msg.textMsg}.jpg?time=${Date.now()}"
                                            alt="No Found"/>
                                </div>
                            </li>`;
        }
        $('#id-'+`${idChat} .chatWindow`).append(addedBlock);
        autoScrollDown();
    });
}
function clearAndHideInputImgMsg() {
    $('.blockImgMsg').hide();
    $('.msgWindow').css({"height" : "79vh"});
    $('#fileImgMsg').val(null);
    $('.textAreaMsg').prop('disabled', false);
}
function autoScrollDown() {
    $('.blockMsgScroll').animate({
        scrollTop: 1000000
    }, 800);
}
function printFriendsList() {
    let ourTag = localStorage.getItem("tagUser");
    db.transaction(function(tx) {
        tx.executeSql(
            "SELECT * FROM FriendsTable WHERE tagReceiverFriend <> ? AND status = ?",
            [ourTag, 2],
            function(tx, result) {
                let addFriends = "";
                for(let i = 0; i < result.rows.length; i++) {
                    let tagUser = result.rows.item(i)['tagReceiverFriend'];
                    let nameOfUser = result.rows.item(i)['friendName'];
                    addFriends += `<div class="elementFriends list-group-item list-group-item-action" role="tab" id="frnd_${tagUser}">
                                        <div class="blockFriendsInfo">
                                            <img    id="frndImg_${tagUser}"
                                                    height="60px"
                                                    width="60px"
                                                    src="http://imagerc.ddns.net:80/avatar/avatarImg/${tagUser}.jpg?time=${Date.now()}"
                                                    class="img-fluid rounded-circle"
                                                    alt="Avatar"
                                                    onerror="this.onerror=null; this.src='./img/user_photo.png'">
                                            <div class="nameFriends" id="nameUser">${nameOfUser}</div>
                                        </div>
                                        <div class="blockActionsFriends">
                                            <button type="button" class="goToChatUser btn btn-light"> Создать чат </button>
                                        </div>
                                    </div>`;
                }
                $('.friendsList').html(addFriends);
            }, null)
    });
}
function addUserInOnline(id, name) {
    db.transaction(function(tx) {
        tx.executeSql
        (
            "INSERT INTO OnlineUsers values(?, ?)",
            [id, name],
            null,
            null
        );
    });
}
function updateNameInUserChat(id, name) {
    db.transaction(function(tx) {
        tx.executeSql
        (
            "UPDATE ListUsersChat SET nameUser = ? WHERE tagUser = ?",
            [name, id],
            null,
            null
        );
    });
}
function updateNameInFriends(id, name) {
    db.transaction(function(tx) {
        tx.executeSql
        (
            "UPDATE FriendsTable SET friendName = ? WHERE tagReceiverFriend = ?",
            [name, id],
            null,
            null
        );
    });
}
function deleteUserFromOnline(id) {
    db.transaction(function(tx) {
        tx.executeSql
        (
            "DELETE FROM OnlineUsers WHERE tagUser = ?",
            [id],
            null,
            null
        );
    });
}
function updateAddUsersList(id,name) {
    let status = -1;
    db.transaction(function(tx) {
        tx.executeSql(
"SELECT status FROM FriendsTable WHERE tagReceiverFriend = ?",
    [id],
            function(tx, result) {
                for(let i = 0; i < result.rows.length; i++) {
                    status = result.rows.item(i)['status'];
                }
                let icon = "";
                switch (status){
                    case -1:
                    {
                        icon = '<i class="fa-solid fa-user-plus"></i>';
                        break;
                    }
                    case 0:
                    {
                        icon = '<i class="fa-solid fa-user-plus"></i>';
                        break;
                    }
                    case 1:
                    {
                        icon = '<i class="fa-solid fa-user-clock"></i>';
                        break;
                    }
                    case 2:
                    {
                        icon = '<i class="fa-solid fa-user-check"></i>';
                        break;
                    }
                }

                let addUsers = `<div class="elementUsers list-group-item list-group-item-action" role="tab" id="user_${id}">
                                    <div class="blockUsersInfo">
                                        <img    id="userImg_${id}"
                                                height="60px"
                                                width="60px"
                                                src="http://imagerc.ddns.net:80/avatar/avatarImg/${id}.jpg?time=${Date.now()}"
                                                class="img-fluid rounded-circle"
                                                alt="Avatar"
                                                onerror="this.onerror=null; this.src='./img/user_photo.png'">
                                        <div class="nameUsers" id="nameUser">${name}</div>
                                    </div>
                                    <div class="blockActionsUsers">
                                        <button type="button" class="actionsFriend btn btn-light btn-floating">${icon}</button>
                                        <button type="button" class="goToChatUser btn btn-light"> Создать чат </button>
                                    </div>
                                </div>`;
                $('.usersList').append(addUsers);
            }, null)
    });


}
function updateDeleteUsersList(id) {
    $(`#user_${id}`).remove();
}
function addRequestsUser(tagUser, nameOfUser) {
    let addRequests = `<div class="elementRequests list-group-item list-group-item-action" role="tab" id="requests_${tagUser}">
                            <div class="blockRequestsInfo">
                                <img    id="requestsImg_${tagUser}"
                                        height="60px"
                                        width="60px"
                                        src="http://imagerc.ddns.net:80/avatar/avatarImg/${tagUser}.jpg?time=${Date.now()}"
                                        class="img-fluid rounded-circle"
                                        alt="Avatar"
                                        onerror="this.onerror=null; this.src='./img/user_photo.png'">
                                <div class="nameUsers" id="nameUser">${nameOfUser}</div>
                            </div>
                            <div class="blockActionsUsers">
                                <button type="button" class="acceptFriend btn btn-success btn-rounded" data-mdb-ripple-color="#ffffff"> ✓ </button>
                                <button type="button" class="denyFriend btn btn-danger btn-rounded" data-mdb-ripple-color="#ffffff"> ✖ </button>
                            </div>
                        </div>`;
    $('.requestsList').append(addRequests);
}
function acceptAddFriend(obj) {
    let id = obj.parentNode.parentNode.id;
    let tagUser = id.slice(id.indexOf('_') + 1)
    let data =
        {
            type : "FRND::",
            typeAction : "CNFRMADD::",
            tagUserFriend : tagUser
        };
    let jsonString = JSON.stringify(data);
    webSocket.send(jsonString);
}
function denyAddFriend(obj) {
    let id = obj.parentNode.parentNode.id;
    let tagUser = id.slice(id.indexOf('_') + 1)
    let data =
        {
            type : "FRND::",
            typeAction : "DELETE::",
            tagUserFriend : tagUser,
            typeDelete : "DELFROMREQ"
        };
    let jsonString = JSON.stringify(data);
    webSocket.send(jsonString);
}
function addUserInFriend(obj) {
    db.transaction(function(tx) {
        tx.executeSql
        (
            "INSERT INTO FriendsTable values(?, ?, ?, ?), (?, ?, ?, ?)",
            [
                obj.tagUserSender,
                obj.tagUserReceiver,
                obj.nameUserReceiver,
                1,
                obj.tagUserReceiver,
                obj.tagUserSender,
                obj.nameUserSender,
                0
                    ],
            null,
            null
        );
    });
}
function deleteUserFromFriend(obj) {
    db.transaction(function(tx) {
        tx.executeSql
        (
            "DELETE FROM FriendsTable WHERE tagSenderFriend = ? AND tagReceiverFriend = ?",
            [obj.tagUserFriend, obj.tagUserOur],
            null,
            null
        );
        tx.executeSql
        (
            "DELETE FROM FriendsTable WHERE tagSenderFriend = ? AND tagReceiverFriend = ?",
            [obj.tagUserOur, obj.tagUserFriend],
            null,
            null
        );
    });
}
function updateUserFriends(obj) {
    db.transaction(function(tx) {
        tx.executeSql
        (
            "UPDATE FriendsTable SET status = 2 WHERE tagSenderFriend = ? AND tagReceiverFriend = ?",
            [obj.tagUserFriend, obj.tagUserOur],
            null,
            null
        );
        tx.executeSql
        (
            "UPDATE FriendsTable SET status = 2 WHERE tagSenderFriend = ? AND tagReceiverFriend = ?",
            [obj.tagUserOur, obj.tagUserFriend],
            null,
            null
        );
    });
}
function addFriend(obj) {
    let idElem = (obj.classList.contains('actionsFriend')) ?
        obj.parentNode.parentNode : obj.parentNode.parentNode.parentNode;
    let id = idElem.id;
    let tagUser = id.slice(id.indexOf('_') + 1);
    db.transaction(function(tx) {
        tx.executeSql(
            "SELECT status FROM FriendsTable WHERE tagReceiverFriend = ?",
            [tagUser],
            function(tx, result) {
                if (!result.rows.length)
                {
                    let nameUser = idElem.childNodes[1].childNodes[3].textContent;
                    let data =
                        {
                            type : "FRND::",
                            typeAction : "ADD::",
                            tagUserReceiver : tagUser,
                            nameUserReceiver : nameUser
                        };
                    let jsonString = JSON.stringify(data);
                    webSocket.send(jsonString);
                }
            }, null)
    });
}
function hoverAvatar(obj) {
    obj.setAttribute('src', './img/delete.png');
    $(obj).addClass("deleteAvatar");
}
function unHoverAvatar(obj) {
    if (localStorage.getItem('isAvatar') === "true")
    {
        let tagUser = localStorage.getItem('tagUser');
        obj.setAttribute('src', `http://imagerc.ddns.net:80/avatar/avatarImg/${tagUser}.jpg?time=${Date.now()}`);
    }
    else
    {
        obj.setAttribute('src', `./img/user_photo.png`);
    }
    $(obj).removeClass("deleteAvatar");
}
function deleteAvatar() {
    if (localStorage.getItem('isAvatar'))
    {
        let formData = new FormData();
        formData.append('typeOperation', 'DELETEAVATAR');
        formData.append('user_id', localStorage.getItem("tagUser"));
        jQuery.ajax({
            url: 'src/server.php',
            data: formData,
            contentType: false,
            processData: false,
            method: 'POST',
            type: 'POST',
            success: function(data)
            {
                let dataMsg = {
                    type : "DELETEAVATAR::"
                };
                let jsonString = JSON.stringify(dataMsg);
                if(webSocket.readyState === WebSocket.OPEN)
                {
                   webSocket.send(jsonString);
                }
            } ,
            error: function (data)
            {
                alert("Ошибка удаления аватара");
            }
        });
    }
}
function addChat(obj) {
    let id = obj.parentNode.parentNode.id;
    let tagUser = id.slice(id.indexOf('_') + 1);
    db.transaction(function(tx) {
        tx.executeSql(
            "SELECT * FROM ListUsersChat WHERE tagUser = ?",
            [tagUser],
            function(tx, result) {
                if (!result.rows.length)
                {
                    // чата нет надо создать
                    let dataMsg = {
                        type : "NEWUSERDLG::",
                        tagUser : tagUser
                    };
                    let jsonString = JSON.stringify(dataMsg);
                    if(webSocket.readyState === WebSocket.OPEN)
                    {
                       webSocket.send(jsonString);
                    }
                }
            }, null)
    });
}
function onUserClick(obj) {
    let id = obj.id;
    let tagUser = id.slice(id.indexOf('_') + 1);
    let nameOfUser = $(obj).find('#nameUser')[0].textContent;
    let status = -1;
    if (tagUser !== localStorage.getItem('tagUser'))
    {
        db.transaction(function(tx) {
            tx.executeSql(
            "SELECT status FROM FriendsTable WHERE tagReceiverFriend = ?",
            [tagUser],
            function(tx, result) {
                for(let i = 0; i < result.rows.length; i++) {
                    status = result.rows.item(i)['status'];
                }
                let statusFriend = "";
                let user = $('#user_ActionsFriends');
                switch (status){
                    case -1:
                    {
                        statusFriend = 'Не в друзьях';
                        user[0].textContent = "Добавить в друзья"
                        user.addClass('add');
                        break;
                    }
                    case 0:
                    {
                        statusFriend = 'Не подтверждено';
                        user[0].textContent = "Принять запрос"
                        user.addClass('confirm');
                        break;
                    }
                    case 1:
                    {
                        statusFriend = 'Запрос отправлен';
                        user[0].textContent = "Ожидание"
                        user.addClass('wait');
                        break;
                    }
                    case 2:
                    {
                        statusFriend = 'В друзьях';
                        user[0].textContent = "Удалить из друзей"
                        user.addClass('delete');
                        break;
                    }
                }
                $('#user_tagOfUser')[0].textContent = tagUser;
                $('#user_nameOfUser')[0].textContent = nameOfUser;
                $('#user_imageOfUser').attr("src", `http://imagerc.ddns.net:80/avatar/avatarImg/${tagUser}.jpg?time=${Date.now()}`)
                $('#user_statusFriends')[0].textContent = statusFriend;
                $('.userProfile').show();
            }, null)
        });
    }
}
function closeUserClick() {
    $('.userProfile').hide();
    let user = $('#user_ActionsFriends');
    user.removeClass('add');
    user.removeClass('confirm');
    user.removeClass('delete');
    user.removeClass('wait');
}
function actWithFriends(obj) {
    if (obj.classList.contains('add'))
    {
        let tagUser = $('.userProfile').find($('#user_tagOfUser'))[0].textContent;
        let nameUser = $('.userProfile').find($('#user_nameOfUser'))[0].textContent;
        db.transaction(function(tx) {
            tx.executeSql(
                "SELECT status FROM FriendsTable WHERE tagReceiverFriend = ?",
                [tagUser],
                function(tx, result) {
                    if (!result.rows.length)
                    {
                        let data =
                            {
                                type : "FRND::",
                                typeAction : "ADD::",
                                tagUserReceiver : tagUser,
                                nameUserReceiver : nameUser
                            };
                        let jsonString = JSON.stringify(data);
                        webSocket.send(jsonString);
                    }
                }, null)
        });
    }
    if (obj.classList.contains('confirm'))
    {
        let tagUser = $('.userProfile').find($('#user_tagOfUser'))[0].textContent;
        let data =
            {
                type : "FRND::",
                typeAction : "CNFRMADD::",
                tagUserFriend : tagUser
            };
        let jsonString = JSON.stringify(data);
        webSocket.send(jsonString);
    }
    if (obj.classList.contains('wait'))
    {

    }
    if (obj.classList.contains('delete'))
    {
        let tagUser = $('.userProfile').find($('#user_tagOfUser'))[0].textContent;
        let data =
            {
                type : "FRND::",
                typeAction : "DELETE::",
                tagUserFriend : tagUser,
                typeDelete : "DELFROMFRND"
            };
        let jsonString = JSON.stringify(data);
        webSocket.send(jsonString);
    }
}
function searchPeople() {
    let searchQuery = $('#searchPeople')[0].value;
    if (searchQuery.length > 7)
    {
        searchQuery = searchQuery.slice(0, 8)
        let data =
            {
                type : "FRND::",
                typeAction : "FIND::",
                tagUserFriend : searchQuery
            };
        let jsonString = JSON.stringify(data);
        webSocket.send(jsonString);
    }

}
function addSearchedPeople(obj) {
    let tagUser = obj.tagUserFriend;
    let nameUser = obj.nameUserFriend;
    let status = -1;
    db.transaction(function(tx) {
        tx.executeSql(
        "SELECT status FROM FriendsTable WHERE tagReceiverFriend = ?",
        [tagUser],
        function(tx, result) {
            for (let i = 0; i < result.rows.length; i++) {
                status = result.rows.item(i)['status'];
            }
            let icon = "";
            switch (status){
                case -1:
                {
                    icon = '<i class="fa-solid fa-user-plus"></i>';
                    break;
                }
                case 0:
                {
                    icon = '<i class="fa-solid fa-user-plus"></i>';
                    break;
                }
                case 1:
                {
                    icon = '<i class="fa-solid fa-user-clock"></i>';
                    break;
                }
                case 2:
                {
                    icon = '<i class="fa-solid fa-user-check"></i>';
                    break;
                }
            }
            let addSearch = `<div class="elementUsers list-group-item list-group-item-action" role="tab" id="user_${tagUser}">
                                <div class="blockUsersInfo">
                                    <img    id="userImg_${tagUser}"
                                            height="60px"
                                            width="60px"
                                            src="http://imagerc.ddns.net:80/avatar/avatarImg/${tagUser}.jpg?time=${Date.now()}"
                                            class="img-fluid rounded-circle"
                                            alt="Avatar"
                                            onerror="this.onerror=null; this.src='./img/user_photo.png'">
                                    <div class="nameUsers" id="nameUser">${nameUser}</div>
                                </div>
                                <div class="blockActionsUsers">
                                    <button type="button" class="actionsFriend btn btn-light btn-floating">${icon}</button>
                                    <button type="button" class="goToChatUser btn btn-light"> Создать чат </button>
                                </div>
                            </div>`;
            $('.searchList').html(addSearch);
        }, null)
    });
}
function onTextChangedSearched(obj) {
    let value = obj.value;
    if (value.length > 0)
    {
        $('.searchList').empty();
        $('.usersList').hide();
        $('.searchList').show();
    }
    else
    {
        $('.searchList').hide();
        $('.usersList').show();
    }
}
function exitFromAcc() {
    localStorage.clear();
    db.transaction(function(tx) {
        tx.executeSql("DROP TABLE IF EXISTS UserDlgTable", [], null, null);
        tx.executeSql("DROP TABLE IF EXISTS ListUsersChat", [], null, null);
        tx.executeSql("DROP TABLE IF EXISTS FriendsTable", [], null, null);
        tx.executeSql("DROP TABLE IF EXISTS MsgDlgTable", [], null, null);
        tx.executeSql("DROP TABLE IF EXISTS OnlineUsers", [], null, null);
        location.reload();
    });
}