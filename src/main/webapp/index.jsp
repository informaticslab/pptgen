<html>
<head>
    <title>File Uploading Form</title>
</head>
<body>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<h3>File Upload:</h3>
Select a file to upload: <br />
<form action="UploadFile.jsp" method="post"
      enctype="multipart/form-data">
    <input type="file" name="file" size="50" />
    <input type="text" id="caption" name="caption" value="What Caption for your File?"/>
    <br />
    <input type="submit" value="Upload File" />
</form>
</body>
</html>
