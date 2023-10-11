// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.
/*<script src="https://cdnjs.cloudflare.com/ajax/libs/microsoft-signalr/6.0.1/signalr.js"></script>*/

    var connection = new signalR.HubConncectionBuilder().withUrl("/chat").build();

    connection.start().catch(function (err){
        return console.error(err.toString());
    });

    document.getElementById("sendmessage").addEventListener("click",function(event){
        var user = document.getElementById("displayName").value;
        var message = document.getElementById("message").value;

        connection.invoke("SendMessage",user,message).catch(function(err){
            return console.error(err.toString());

        });
        event.preventDefault();
    });

    connection.on("ReceiveMessage",function(user,message){

        var encodeMsg = user +" : " + message;
        var li = document.createElement("li");

        li.textContent = encodeMsg;
        document.getElementById("discussion").appendCHild(li);
    });


