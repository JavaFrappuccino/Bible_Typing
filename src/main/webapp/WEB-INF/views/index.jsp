<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 
<link href="/resources/css/index.css" rel="stylesheet" type="text/css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<link rel="shortcut icon" href="/resources/favicon.ico">
<script src="/resources/js/index.js"></script> 
<meta charset="UTF-8">
<title>Bible Typing</title>
</head>
<script>
	$(function() {
		console.log('hi');
	});
</script>
<body>
	<div class="container">
	  <div class="welcome">
	    <div class="pinkbox">
	      <div class="signup nodisplay">
	        <h1>register</h1>
	        <form autocomplete="off">
	          <input type="text" placeholder="username" style="background-color: #F6E3CE">
	          <input type="email" placeholder="email" style="background-color: #F6E3CE">
	          <input type="password" placeholder="password" style="background-color: #F6E3CE">
	          <input type="password" placeholder="confirm password" style="background-color: #F6E3CE">
	          <button class="button submit">create account </button>
	        </form>
	      </div>
	      <div class="signin">
	        <h1>sign in</h1>
	        <form class="more-padding" autocomplete="off">
	          <input type="text" placeholder="username" style="background-color: #F6E3CE">
	          <input type="password" placeholder="password" style="background-color: #F6E3CE">
	          <div class="checkbox">
	            <input type="checkbox" id="remember" /><label for="remember">remember me</label>
	          </div>
	          <button class="button submit">login</button>
	        </form>
	      </div>
	    </div>
	    <div class="leftbox">
	      <h2 class="title"><span>BIBLE</span><br>TYPING</h2>
	      <p class="desc">내게 능력 주시는 자 안에서 <br>내가 모든것을 할 수 있느니라 <br><span>빌립보서 4:13</span></p>
	      <img class="flower smaller" src="/resources/images/bible3.png" alt="1357d638624297b" border="0">
	      <p class="account">have an account?</p>
	      <button class="button" id="signin" style="margin-left:125px;">login</button>
	    </div>
	    <div class="rightbox">
	      <h2 class="title"><span>BIBLE</span><br>TYPING</h2>
	      <p class="desc">주의 말씀은 내 발의 등이요<br>내 길의 빛이니이다 <br><span>시편 119:105</span></p>
	      <img class="flower" src="/resources/images/bible2.png"/>
	      <p class="account">Don't have an account?</p>
	      <button class="button" id="signup" style="margin-left:110px;">sign up</button>
	    </div>
	  </div>
	 </div>
</body>
</html>