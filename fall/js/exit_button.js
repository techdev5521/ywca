window.onload = function() { // once everything on the page loads
	document.getElementById("exit-button").onclick = function() { // make the exit button do something when it's clicked
		// when the button is clicked...
		// start the chain of redirects to hide your page in the browser history
		window.location = "https://www.yoururl.com"; // redirects the current tab to another url
		// go straight to the end of the chain in a new tab so there's no white screen
		window.open("https://www.weather.com", "_blank"); // open this url in a new tab. _blank means new tab.
	};
};
/*
document.onkeydown = function(event) { // when any key is pressed
	if (event.keyCode == 27) { // if that key is ESC (Unicode key code for ESC is 27)
		window.location = "https://www.google.com"; // Do the same redirect as above.
		window.open("https://www.weather.com", "_blank");
	}
};
*/
