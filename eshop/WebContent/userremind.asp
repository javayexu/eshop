<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="Connections/conneshop.asp" -->
<%
Dim remindpass__MMColParam
remindpass__MMColParam = "1"
if (Request.QueryString("useremail") <> "") then remindpass__MMColParam = Request.QueryString("useremail")
%>
<%
set remindpass = Server.CreateObject("ADODB.Recordset")
remindpass.ActiveConnection = MM_conneshop_STRING
remindpass.Source = "SELECT Email, Password, PassQuestion, PassAnswer FROM Customers WHERE Email = '" + Replace(remindpass__MMColParam, "'", "''") + "'"
remindpass.CursorType = 0
remindpass.CursorLocation = 2
remindpass.LockType = 3
remindpass.Open()
remindpass_numRows = 0
Dim var_done
var_done = "0"
If Not remindpass.EOF Or Not remindpass.BOF Then
If (Request.QueryString("answer") <> "") AND ( Request.QueryString("answer") = remindpass.Fields.Item("PassAnswer").Value) Then
Set JMail = Server.CreateObject("JMail.SMTPMail") 
JMail.ServerAddress = "mail.yourserver.com:25"
JMail.Sender = "you@yourserver.com" 
JMail.Subject = "����Email������"
JMail.AddRecipient (remindpass.Fields.Item("Email").Value)
JMail.Body = "����ע����Ϣ���£�." & vbCrLf & vbCrLf
JMail.Body = JMail.Body & "Email�� " &(remindpass.Fields.Item("Email").Value)& vbCrLf
JMail.Body = JMail.Body & "���룺 " &(remindpass.Fields.Item("Password").Value) & vbCrLf 
JMail.Body = JMail.Body & "����������Email�������¼Fans8�����̳ǡ�"
JMail.Priority = 3
JMail.AddHeader "Originating-IP", Request.ServerVariables("REMOTE_ADDR")
JMail.Execute
var_done = "1"
End If
End If
%>
<html>
<head>
<title>�����̳�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="style.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" topmargin="2">
<table width="760" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td background="images/topback.gif" width="130"><img src="images/sitelogo.gif" height="88"></td>
    <td background="images/topback.gif" width="500" align="center" valign="middle"><a href="http://www.fans8.com" target="_blank"><img src="images/fans8.gif" width="468" height="60" border="0"></a> 
    </td>
    <td background="images/topback.gif" width="130"> <!-- #BeginLibraryItem "/Library/custm.lbi" --><table width="100%" border="0" cellspacing="2" cellpadding="2">
        <tr> 
          <td valign="middle" align="center"><a href="cart.asp"><img src="images/button_cart.gif" width="87" height="18" border="0"></a></td>
        </tr>
        <tr> 
          <td valign="middle" align="center"><a href="checkorder_login.asp"><img src="images/button_ddcx.gif" width="87" height="18" border="0"></a></td>
        </tr>
        <tr> 
          
    <td valign="middle" align="center"><a href="customer_register.asp"><img src="images/button_regist.gif" width="87" height="18" border="0"></a></td>
        </tr>
      </table><!-- #EndLibraryItem --></td>
  </tr>
</table>
<table width="760" border="0" cellspacing="1" cellpadding="0" align="center" bgcolor="#000000">
  <tr> 
    <td bgcolor="#FF9900" height="22" valign="middle" align="center"> <!-- #BeginLibraryItem "/Library/nav.lbi" --><table width="80%" border="0" cellspacing="2" cellpadding="2">
          <tr align="center" valign="middle"> 
            <td><a href="newproduct.asp" class="white">��Ʒ���</a></td>
            
    <td><a href="commend.asp" class="white">�ص��Ƽ�</a></td>
            
    <td><a href="bestsell.asp" class="white">��������</a></td>
            
    <td><a href="bestprice.asp" class="white">�ؼ���Ʒ</a></td>
          </tr>
        </table><!-- #EndLibraryItem --></td>
  </tr>
  <tr> 
    <td bgcolor="#FFCC66" height="22"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr> 
          <td>��<a href="default.asp" class="red">��ҳ</a> &gt; ȡ������</td>
          <td>&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="760" border="0" cellspacing="1" cellpadding="0" align="center" bgcolor="#000000">
  <tr> 
    <td bgcolor="#FFFFFF"> 
      <p>������<img src="images/remindpass.gif" width="190" height="30"></p>
      <form name="form1" method="get" action="userremind.asp">
        <div align="center" class="productName"> 
          <% If remindpass.EOF And remindpass.BOF Then %>
          <%If (Request.QueryString("useremail") <> "") then %>
		  <p>��Email�����ڣ����ٴ����룡 </p>
          <% End If %>
          <% End If ' end remindpass.EOF And remindpass.BOF %>
		  <p>���������Email�� 
            <input type="text" name="useremail" value="<% = Request.QueryString("useremail") %>">
          </p>
          <% If Not remindpass.EOF Or Not remindpass.BOF Then %>
          <p>��������ǣ�<%=(remindpass.Fields.Item("PassQuestion").Value)%></p>
          <p>�𰸣� 
            <input type="text" name="answer" value="<% = Request.QueryString("answer") %>">
		  </p>
          <% If (Request.QueryString("answer") <> remindpass.Fields.Item("PassAnswer").Value) AND (Request.QueryString("answer") <> "") Then %>
          <p>����Ļش���ȷ�Ϻ��ٴλش�</p>
		  <% End If %>
          <% End If ' end Not remindpass.EOF Or NOT remindpass.BOF %>
          <p> 
         <% If var_done <> "1" Then %>
          <input type="submit" value="�ش�">
            �� 
            <input type="submit" value="���">
         <% End If %>
          </p>
		  
          <% If var_done = "1" Then %>
����������<p>���������Ѿ����͵����ĵ��������У���鿴���䲢���µ�¼</p>
����������<% End If %>

        </div>
      </form>
      <p>&nbsp;</p>
    </td>
  </tr>
</table>
<br>
<!-- #BeginLibraryItem "/Library/bottm.lbi" --><table width="760" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td background="images/topback.gif" align="center" height="16"><font color="#FFFFFF">copyright 
      2001 Powered by Peter.HJ</font></td>
  </tr>
</table><!-- #EndLibraryItem --></body>
</html>
<%
remindpass.Close()
%>
