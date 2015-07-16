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
  ServletContext context = pageContext.getServletContext();
  String filePath = context.getInitParameter("file-upload");
  String fileName = request.getParameter("file");
  String caption = request.getParameter("caption");
  String downloadPath = context.getInitParameter("image-home");
 %>

    <html>
    <head>
    <title>File Preview</title>
        <link rel="stylesheet" href="custom.css">
    </head>
    <body>
    <div class="top-nav"><div class="mmwr"><img src="mmwr-logo.png" width="179" height="49"></div><div class="cdc-logo"><img src="cdc.png"></div></div>
    <div class="container">
    <%
    //  String caption = "Generic Caption";
     if(fileName != null)
     {
       XMLSlideShow ppt = new XMLSlideShow();
       ppt.createSlide();
       XSLFSlideMaster master = ppt.getSlideMasters()[0];

       XSLFSlideLayout layout1 = master.getLayout(SlideLayout.TITLE);
       XSLFSlide slide1 = ppt.createSlide(layout1) ;
       XSLFTextShape[] ph1 = slide1.getPlaceholders();
       XSLFTextShape titlePlaceholder1 = ph1[0];
       titlePlaceholder1.setText("This is a test");
       XSLFTextShape subtitlePlaceholder1 = ph1[1];
       subtitlePlaceholder1.setText("this is an image of an alarm clock");



       File img = new File(filePath, fileName);
       byte[] data;
       try {
         FileInputStream fis = new FileInputStream(img);
         data = IOUtils.toByteArray(fis);

         int pictureIndex = ppt.addPicture(data, XSLFPictureData.PICTURE_TYPE_PNG);

	        /*XSLFPictureShape shape =*/ slide1.createPicture(pictureIndex);
           java.util.Date today = new java.util.Date();
         subtitlePlaceholder1.setText(caption);

         File pptFile;
         pptFile = new File(filePath + "slides"+today.toString()+".pptx");
         FileOutputStream pptOutput = new FileOutputStream(pptFile);
         ppt.write(pptOutput);
         pptOutput.close();
         fis.close();
          %>
    <h2>PowerPoint Download</h2>
    <a href="<%=downloadPath + "slides" + today.toString()+".pptx"%>">Click here</a> to download your slides. <br>
      <%

        }catch(Exception ex) {
        System.out.println(ex);
        }



  }else{ %>
    <p>No filename or caption detected.  Please try again from <a href="<%=downloadPath%>/pptgen">the beginning</a></p>

    <%
  }
%>
        </div>
</body>
</html>