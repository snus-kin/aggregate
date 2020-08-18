const postForm = document.querySelector("#post");
const loginForm = document.querySelector("#loginForm");
const contentElem = document.querySelector("#content");

var HttpClient = function() {
    this.get = function(aUrl, aCallback) {
        var anHttpRequest = new XMLHttpRequest();
        anHttpRequest.onreadystatechange = function() { 
            if (anHttpRequest.readyState == 4 && anHttpRequest.status == 200)
                aCallback(anHttpRequest.responseText);
        }
        anHttpRequest.open( "GET", aUrl, true );            
        anHttpRequest.responseType = "application/json";
        anHttpRequest.send( null );
    }
}

function logIn(event) {
    console.log(event)
    event.preventDefault();
}

loginForm.addEventListener('submit', logIn);

var client = new HttpClient();
client.get("http://0.0.0.0:5000/posts/list.json", function(response) {
    var content = JSON.parse(response);
    var contentHtml = "";
    for(var i = 0; i < content.posts.length; i++) {
        var obj = content.posts[i];
        contentHtml += "<h1>" + obj.title + "</h1>\n";
        contentHtml += "<h2>" + obj.link + "</h2>\n";
        contentHtml += "<h3>" + obj.username + "</h3>\n";
        contentHtml += "<hr>\n";
    }
    contentElem.innerHTML = contentHtml;
})
