<!doctype html>
<html>
<head>
<title>Untitled Document</title>
<link rel="stylesheet" href="custom.css">
</head>

<body>
<div class="top-nav"><div class="mmwr"><img src="mmwr-logo.png" width="179" height="49"></div><div class="cdc-logo"><img src="cdc.png"></div></div>
<div class="container">
<h2>Step 1: File Upload</h2>
<i>Please select a file to upload.</i> <br /><br />
<form action="UploadFile.jsp" method="post"
      enctype="multipart/form-data">
    <input type="file" name="file" size="50" class="custom-file-input" required/>
    <br />
    <br />
    <input type="submit" value="Upload File" class="upload-file"/>
</form>
</div>


</body>
</html>
