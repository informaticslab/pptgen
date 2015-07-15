<%--
  Created by IntelliJ IDEA.
  User: PMW3
  Date: 7/8/15
  Time: 3:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="org.apache.commons.fileupload.*,org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@ page import="org.apache.poi.util.*" %>
<%@ page import="org.apache.poi.xslf.usermodel.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.FileInputStream" %>



<%
  File file ;
  int maxFileSize = 5000 * 1024;
  int maxMemSize = 5000 * 1024;
  ServletContext context = pageContext.getServletContext();
  String filePath = context.getInitParameter("file-upload");
  String imagePath = context.getInitParameter("image-home");
  String tempPath = context.getInitParameter("file-upload-temp");

  // Verify the content type

  String contentType = request.getContentType();
  if (contentType != null && (contentType.indexOf("multipart/form-data") >= 0)) {

    DiskFileItemFactory factory = new DiskFileItemFactory();
    // maximum size that will be stored in memory
    factory.setSizeThreshold(maxMemSize);
    // Location to save data that is larger than maxMemSize.
    factory.setRepository(new File(tempPath));

    // Create a new file upload handler
    ServletFileUpload upload = new ServletFileUpload(factory);
    // maximum file size to be uploaded.
    upload.setSizeMax( maxFileSize );
    try{
      // Parse the request to get file items.
      List fileItems = upload.parseRequest(request);

      // Process the uploaded file items
      Iterator i = fileItems.iterator(); %>

    <html>
    <head>
    <title>File Preview</title>
      <link rel="stylesheet" href="custom.css">
    </head>

    <body>
    <div class="top-nav"><div class="mmwr"><img src="mmwr-logo.png" width="179" height="49"></div>
      <div class="cdc-logo"><img src="cdc.png"></div></div>
    <div class="container">
    <%
      while ( i.hasNext () )
      {
        FileItem fi = (FileItem)i.next();
        if ( !fi.isFormField () )
        {
          // Get the uploaded file parameters
          String fieldName = fi.getFieldName();
          String fileName = fi.getName();
          boolean isInMemory = fi.isInMemory();
          long sizeInBytes = fi.getSize();
          // Write the file
          if( fileName.lastIndexOf("\\") >= 0 ){
            fileName = fileName.substring( fileName.lastIndexOf("\\")+1);
            file = new File( filePath + fileName) ;
          }else{
            file = new File( filePath +
                    fileName.substring(fileName.lastIndexOf("\\")+1)) ;
          }

          fi.write(file) ;
          %>
    <h1>Image check</h1>
    <h2> Please confirm the image you've uploaded</h2>
    <img src="<%=imagePath+fileName%>"/>
    <h2> Please enter an image caption to get your PPT file</h2>
    <form action="UploadCaption.jsp" method="post">
      <input type="hidden" name="file" value="<%=fileName%>" />
      Caption: <input type="text" name="caption" value ="Caption"/>
      <br />
      <input type="submit" value="Generate PPTX" class="upload-file"/>
    </form>

      <%
          //byte[] data;
         // FileInputStream fis = new FileInputStream(file);
        //  data = IOUtils.toByteArray(fis);
          //int pictureIndex = ppt.addPicture(data, XSLFPictureData.PICTURE_TYPE_PNG);
        //  slide1.createPicture(pictureIndex);
          //out.println("added picture <br>");
         // fis.close();
        }
//        else if (fi.isFormField()) {
//          // Process regular form field (input type="text|radio|checkbox|etc", select, etc).
//          String fieldName = fi.getFieldName();
//          String fieldValue = fi.getString();
//            caption = fieldValue;
//            out.println("caption: " + caption + "<br>");
//         // subtitlePlaceholder1.setText(caption);
//
//
//          // ... (do your job here)
//        }


      }
      //File pptFile;
      //pptFile = new File(filePath + "slides.pptx");
     // FileOutputStream pptOutput = new FileOutputStream(pptFile);
      //ppt.write(pptOutput);
      //pptOutput.close();
      //out.println("Slides available At <a href=\"/data/slides.pptx\">slides.pptx</a> <br>");
      %>
      </div>
      </body>
      </html>
<%
    }catch(Exception ex) {
      System.out.println(ex);
    }
  }else{ %>
    <html>
    <head>
    <title>Image Check</title>
      <link rel="stylesheet" href="custom.css">
    </head>
    <body>
    <div class="top-nav"><div class="mmwr"><img src="mmwr-logo.png" width="179" height="49"></div><div class="cdc-logo"><img src="cdc.png"></div></div>
    <div class="container">
    <p>No file uploaded. Please try again from <a href="<%=imagePath%>/pptgen">the beginning.</a></p>
    </div>
    </body>
    </html>
    <%
  }
%>