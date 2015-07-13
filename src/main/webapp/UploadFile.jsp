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

  /* START PPT INTEGRATION */
//  XMLSlideShow ppt = new XMLSlideShow();
//
//  // XSLFSlide#createSlide() with no arguments creates a blank slide
//	        /*XSLFSlide blankSlide =*/ ppt.createSlide();
//
//
//  XSLFSlideMaster master = ppt.getSlideMasters()[0];
//
//  XSLFSlideLayout layout1 = master.getLayout(SlideLayout.TITLE);
//  XSLFSlide slide1 = ppt.createSlide(layout1) ;
//  XSLFTextShape[] ph1 = slide1.getPlaceholders();
//  XSLFTextShape titlePlaceholder1 = ph1[0];
//  titlePlaceholder1.setText("This is a test");
//  XSLFTextShape subtitlePlaceholder1 = ph1[1];
//  subtitlePlaceholder1.setText("this is an image of an alarm clock");



//  File img = new File(System.getProperty("POI.testdata.path"), "slideshow/clock.jpg");
//  byte[] data;
//  try {
//    data = IOUtils.toByteArray(new FileInputStream(img));
//
//    int pictureIndex = ppt.addPicture(data, XSLFPictureData.PICTURE_TYPE_PNG);
//
//	        /*XSLFPictureShape shape =*/ slide1.createPicture(pictureIndex);
//    FileOutputStream out;

//
//    out = new FileOutputStream("slides.pptx");
//    ppt.write(out);
//    out.close();

  /* end PPT integration */

  // Verify the content type

  String contentType = request.getContentType();
  if ((contentType.indexOf("multipart/form-data") >= 0)) {




    DiskFileItemFactory factory = new DiskFileItemFactory();
    // maximum size that will be stored in memory
    factory.setSizeThreshold(maxMemSize);
    // Location to save data that is larger than maxMemSize.
    factory.setRepository(new File("/Users/PMW3/temp"));

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
    </head>
    <body>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <%
    //  String caption = "Generic Caption";
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
            file = new File( filePath +
                    fileName.substring( fileName.lastIndexOf("\\"))) ;
          }else{
            file = new File( filePath +
                    fileName.substring(fileName.lastIndexOf("\\")+1)) ;
          }

          fi.write(file) ;
          %>
    <h1>Image check</h1>
    <h2> Please confirm the image you've uploaded</h2>
    <img src="<%=imagePath+fileName%>"/>

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
    </head>
    <body>
    <p>No file uploaded</p>
    </body>
    </html>
    <%
  }
%>