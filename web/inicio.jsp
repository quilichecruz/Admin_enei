<%-- 
    Document   : inicio
    Created on : 11/12/2017, 10:22:36 AM
    Author     : prac-enei5
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%  
    String hostname=(String)session.getAttribute("hostname");
    String ip=(String)session.getAttribute("ip");
    String dnipro= request.getParameter("dnipro");
    String nombrepro= request.getParameter("nombrepro");
    String id=request.getParameter("id");
    String nombrecur= request.getParameter("nombrecur");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inicio</title>
        <script type="text/javascript"  src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script type="text/javascript"  src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
        <!--<link rel="icon" type="image/png" href="media/inei.png"/!-->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
        <link rel="stylesheet" href="assets/css/custom/inicio-admin.css">
        <link rel="stylesheet" href="assets/css/custom/admin-popup.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
        <link href="https://fonts.googleapis.com/css?family=Dosis" rel="stylesheet">
        <script type="text/javascript"> 
        $(function () {
        $('[data-toggle="tooltip"]').tooltip();
        }); 
        </script>
    </head>
    
    
    <body style="font-family: 'Dosis', sans-serif;">
        <nav class="nav nav-tabs" id="myTab">
            <a class="nav-item nav-link" id="nav-home-tab" data-toggle="tab" href="#nav-report" role="tab" aria-controls="nav-report" aria-selected="false" style="color: #000;font-size: 13px;"><img src="media/logocolor.png" alt="" style="width: 45px;height: auto;text-align: center;"></a>
            <a class="nav-item nav-link" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true" style="color: #000;font-size: 13px;font-weight: 600;"><i class="material-icons" style="font-size: 18px">school</i> Docentes</a>
            <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false" style="color: #000;font-size: 13px;font-weight: 600;"><i class="material-icons" style="font-size: 18px">local_library</i> Cursos</a>
            <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false" style="color: #000;font-size: 13px;font-weight: 600;"><i class="material-icons" style="font-size: 18px">dashboard</i> Reportes</a>
        </nav>
        
        <div class="tab-content" id="nav-tabContent">
            <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
        <br>
        <div class="container">
            <!--Menu-->
            <div class="row">
                    
                            
                    <%--<div class="col-md-6">
                        <form>
                            <select style="font-size: 12px;width: 70%">
                                <option>Lista de cursos</option>
<%
try {
    Class.forName("com.mysql.jdbc.Driver");
    cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
    sta=cnx.createStatement();
    rs=sta.executeQuery("select * from cursos");
    while (rs.next()){
%>
                                <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<% 
    }
    sta.close();
    rs.close();
    cnx.close();
    } catch (Exception e) {
           }
%> 
                            </select>
                            <button style="background: transparent;border: 0px;"><i class="material-icons" style="font-size: 18px;">search</i></button>
                        </form>
                    </div>--%>
                            
                    <div class="col-md-6">
                        <a style="text-decoration: none;color: #000;font-size: 13px;" href="#popup" class="popup-link" onclick = "document.getElementById('light').style.display='block';">
                        <i data-toggle="tooltip" data-placement="right" title="Registrar docente" class="material-icons" style="text-decoration: none;color: #000;margin-left: 50%">account_circle</i></a>
                    </div>
                    <div class="col-md-6">
                        <form action="teacher_search" method="post">
                            <select name="dnipro" style="font-size: 12px;width: 70%">
                                <option>Docentes con cursos</option>
<%
    Connection cnx=null;
    Statement sta=null;
    ResultSet rs=null;
try {
    Class.forName("com.mysql.jdbc.Driver");
    cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
    sta=cnx.createStatement();
    rs=sta.executeQuery("select count(T1.id_registro),T2.apellidos_pro,T2.nombre_pro,T2.dni_pro from registro T1 inner join profesores T2 ON T1.dni_pro=T2.dni_pro and T1.esta != 'Finalizo' WHERE T1.dni_pro=T1.dni_pro  group by T2.apellidos_pro order by T2.apellidos_pro;");
    while (rs.next()){
%>
                        <option value="<%=rs.getString(4)%>"><%=rs.getString(1)%> - <%=rs.getString(2)%>, <%=rs.getString(3)%></option>
<% 
    }
    sta.close();
    rs.close();
    cnx.close();
    } catch (Exception e) {
           }
%> 
                            </select>
                            <button style="background: transparent;border: 0px;"><i class="material-icons" style="font-size: 18px;">search</i></button>
                        </form>
                    </div>
            </div>
            <!--Contenido-->
            <div class="row">
                <%--<div class="col-md-12">
                    <div class="col-md-12" style="margin-top: 3%;">
                        <div class="table-responsive" style="max-height: 300px;font-size: 12px;">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th></th>                                        
                                    <th style="text-align: center">Docente</th>
                                    <th style="text-align: center">Sede</th>
                                    <th style="text-align: center">Profesión</th>
                                    <th style="text-align: center">Grado</th>
                                    <th style="text-align: center">Opción</th>
                                </tr>
                            </thead>
<%
    try {
    Class.forName("com.mysql.jdbc.Driver");
    cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
    sta=cnx.createStatement();
    rs=sta.executeQuery("select * from profesores order by apellidos_pro");
    while (rs.next()){
%>
                            <tbody>
                                <tr>
                                    <td style="text-align: center;padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"><a><img src="media/usuario.png"></a></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"><a style="text-decoration: none;color: #000;" href="inicio.jsp?dnipro=<%=rs.getString(1)%>#popup2" onclick = "document.getElementById('light2').style.display='block';"><%=rs.getString(3)%>, <%=rs.getString(2)%></a></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"><%=rs.getString(15)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"><%=rs.getString(9)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"><%=rs.getString(8)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center;">
                                        <a style="text-decoration: none;color: #000;" href="editpro.jsp?dnipro=<%=rs.getString(1)%>">
                                            <img src="media/editar.png" alt="Editar"></a>
                                        <a style="text-decoration: none;color: #000;" href="eliminarpro.jsp?dnipro=<%=rs.getString(1)%>" onclick="return eliminar()">
                                            <img src="media/eliminar.png" alt="Eliminar"></a>
                                    </td>
                                </tr>                      
<% 
    }
    sta.close();
    rs.close();
    cnx.close();
    } catch (Exception e) {
    }
%>
                            </tbody>
                        </table>
                        </div>
                    </div>
                </div>--%>  
                <div class="col-md-12">
                    <div class="col-md-12" style="margin-top: 0%;">
                        <div class="table-responsive" style="max-height: 340px;font-size: 14px;">
                        <!--<table class="table table-hover">-->
                        <table id="example" class="display" style="border: 1px solid #000;" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th></th>                                        
                                    <th style="text-align: center">Docente</th>
                                    <th style="text-align: center">Sede</th>
                                    <th style="text-align: center">Profesión</th>
                                    <th style="text-align: center">Grado</th>
                                    <th style="text-align: center">Opción</th>
                                </tr>
                            </thead>
                            <tbody>
<%
    try {
    Class.forName("com.mysql.jdbc.Driver");
    cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
    sta=cnx.createStatement();
    rs=sta.executeQuery("select * from profesores order by apellidos_pro");
    while (rs.next()){
%>
                                <tr>
                                    <td style="text-align: center;padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"><a href="assign.jsp?dnipro=<%=rs.getString(1)%>&nombrepro=<%=rs.getString(2)%>&apellidospro=<%=rs.getString(3)%>" style="text-decoration: none;color:#000;"><i data-toggle="tooltip" data-placement="right" title="Asignar curso a <%=rs.getString(3)%>, <%=rs.getString(2)%>" class="material-icons" style="font-size: 15px;">account_circle</i></a></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"><a style="text-decoration: none;color: #000;" href="inicio.jsp?dnipro=<%=rs.getString(1)%>#popup2" onclick = "document.getElementById('light2').style.display='block';"><%=rs.getString(3)%>, <%=rs.getString(2)%></a></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"><%=rs.getString(15)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"><%=rs.getString(9)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"><%=rs.getString(8)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center;">
                                        <a style="text-decoration: none;color: #000;" href="inicio.jsp?dnipro=<%=rs.getString(1)%>#popup2" onclick = "document.getElementById('light2').style.display='block';">
                                            <i class="material-icons" data-toggle="tooltip" data-placement="left" style="font-size: 15px" title="Detalle">zoom_in</i></a>
                                        <a style="text-decoration: none;color: #000;" href="edit.jsp?dnipro=<%=rs.getString(1)%>">
                                            <i class="material-icons" data-toggle="tooltip" data-placement="top" style="font-size: 15px;" title="Editar">edit</i></a>
                                        <a style="text-decoration: none;color: #000;" href="eliminarpro.jsp?dnipro=<%=rs.getString(1)%>" onclick="return eliminar()">
                                            <i class="material-icons" data-toggle="tooltip" data-placement="right" style="font-size: 15px" title="Eliminar">highlight_off</i></a>
                                    </td>
                                </tr>                      
<% 
    }
    sta.close();
    rs.close();
    cnx.close();
    } catch (Exception e) {
    }
%>
                            </tbody>
                        </table>
                        </div>
                    </div>
                </div>
            </div>    
                            
          <div class="row">
                         <div class="col-md-12">
                            <div class="col-md-12" style="margin-top: 3%;">
                        <div class="table-responsive" style="font-size: 14px;">
                        <!--<table class="table table-hover">-->
                        <table id="example1" class="display" style="border: 1px solid #000" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th style="text-align: center">Curso</th>
                                    <th style="text-align: center">Inscritos</th>
                                    <th style="text-align: center">Vacantes</th>
                                    <th style="text-align: center">Disponibles</th>
                                    <th style="text-align: center">Frecuencia</th>
                                    <th style="text-align: center">Fecha Inicio</th>
                                    <th style="text-align: center">Fecha Término</th>
                                    <th style="text-align: center">Estado</th>
                                    <th style="text-align: center">Lab</th>
                                    <th style="text-align: center">Docente</th>
                                    <th style="text-align: center">Opción</th>
                                </tr>
                            </thead>
                            <tbody>
<%
try {
        Class.forName("com.mysql.jdbc.Driver");
        cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
        sta=cnx.createStatement();
        rs=sta.executeQuery("select T1.id_registro,T1.cod_cur,T3.nombre_cur,T1.paga,T1.dni_pro,T2.nombre_pro,T2.apellidos_pro,T1.fechatini,T1.fechatfin,T1.esta,T1.labo,T3.vaca_cur,-sum(paga-vaca_cur),T1.frec FROM registro T1 INNER JOIN profesores T2 INNER JOIN cursos T3  ON T1.dni_pro = T2.dni_pro AND T1.cod_cur = T3.cod_cur where T1.dni_pro="+dnipro+" group by T1.id_registro");
        while (rs.next()){
%>
                                <tr>
                                    <td style="text-align: center;"><a style="color: #000"><i class="material-icons" style="font-size: 15px">description</i></a></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><a href="assign.jsp?codcur=<%=rs.getString(2)%>&nombrecur=<%=rs.getString(3)%>" style="text-decoration: none;color:#000;" title="Asignar <%=rs.getString(3)%> a otro docente" data-toggle="tooltip" data-placement="right"><%=rs.getString(3)%></a></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getInt(4)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getInt(12)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center;color: red"><%=rs.getInt(13)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center;"><%=rs.getString(14)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(8)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(9)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(10)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(11)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><a href="assign.jsp?dnipro=<%=rs.getString(5)%>&apellidospro=<%=rs.getString(7)%>&nombrepro=<%=rs.getString(6)%>" style="text-decoration: none;color:#000;" title="Asignar otro curso a este docente" data-toggle="tooltip" data-placement="left"><%=rs.getString(7)%>, <%=rs.getString(6)%></a></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center">
                                        <a href="session.jsp?id=<%=rs.getString(1)%>&dnipro=<%=rs.getString(5)%>">
                                            <i data-toggle="tooltip" data-placement="left" class="material-icons" style="font-size: 15px; color: #000" title="Agregar sesión">timer</i></a>
                                            <a href="edit_rela.jsp?id=<%=rs.getString(1)%>">
                                            <i data-toggle="tooltip" data-placement="top" class="material-icons" style="font-size: 15px; color: #000" title="Editar">edit</i></a>
                                        <a href="eliminarrela.jsp?id=<%=rs.getString(1)%>" onclick="return eliminar()">
                                            <i data-toggle="tooltip" data-placement="right" class="material-icons" style="font-size: 15px;color: #000" title="Eliminar">highlight_off</i></a>
                                    </td>
                                </tr>                      
<% 
    }
    sta.close();
    rs.close();
    cnx.close();
    } catch (Exception e) {
    }
%>
                            </tbody>
                        </table>
                        </div>
                    </div>
                        </div>
   
                    </div> 

        </div>
    </div>
    
            <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                <br>
                <div class="container">
                <!--Menú-->
                    <div class="row">
                        <div class="col-md-6">
                        <a style="text-decoration: none;color: #000;font-size: 13px;" href="#popup4" class="popup-link" onclick = "document.getElementById('light4').style.display='block';">
                            <i data-toggle="tooltip" data-placement="right" title="Registrar curso" class="material-icons" style="text-decoration: none;color: #000;margin-left: 50%">description</i></a>
                    </div>
                       
                </div>
                <!--Contenido-->
                    <div class="row">
                         <div class="col-md-12">
                            <div class="col-md-12" style="margin-top: 0%;">
                        <div class="table-responsive" style="max-height: 340px;font-size: 14px;">
                        <!--<table class="table table-hover">-->
                        <table id="example2" class="display" style="border: 1px solid #000" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th></th>                                 
                                    <th style="text-align: center">Curso</th>
                                    <th style="text-align: center">Vacantes</th>
                                    <th style="text-align: center">Costo</th>
                                    <th style="text-align: center">Opción</th>
                                </tr>
                            </thead>
                            <tbody>
<%
    try {
    Class.forName("com.mysql.jdbc.Driver");
    cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
    sta=cnx.createStatement();
    rs=sta.executeQuery("select * from cursos");
    while (rs.next()){
%>
                                <tr>
                                    <td style="text-align: center;padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"><a href="assign.jsp?codcur=<%=rs.getInt(1)%>&nombrecur=<%=rs.getString(2)%>" style="text-decoration: none;color:#000;"><i class="material-icons" style="font-size: 15px"  data-toggle="tooltip" data-placement="right" title="Asignar docente">description</i></a></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"><a href="assign.jsp?codcur=<%=rs.getInt(1)%>&nombrecur=<%=rs.getString(2)%>" style="text-decoration: none;color:#000;"><%=rs.getString(2)%></a></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"><%=rs.getString(3)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"><%=rs.getString(4)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center;">
                                        <a style="text-decoration: none;color: #000;" href="#">
                                            <i class="material-icons" style="font-size: 15px"  data-toggle="tooltip" data-placement="left" title="Detalle">zoom_in</i></a>
                                            <a style="text-decoration: none;color: #000;" href="edit_curso.jsp?codcur=<%=rs.getInt(1)%>">
                                            <i class="material-icons" style="font-size: 15px;"  data-toggle="tooltip" data-placement="top" title="Editar">edit</i></a>
                                        <a style="text-decoration: none;color: #000;" href="eliminarpro.jsp?dnipro=<%=rs.getString(1)%>" onclick="return eliminar()">
                                            <i class="material-icons" style="font-size: 15px"  data-toggle="tooltip" data-placement="right" title="Eliminar">highlight_off</i></a>
                                    </td>
                                </tr>                      
<% 
    }
    sta.close();
    rs.close();
    cnx.close();
    } catch (Exception e) {
    }
%>
                            </tbody>
                        </table>
                        </div>
                    </div>
                        </div>
   
                    </div>       
                            
                            <div class="row">
                         <div class="col-md-12">
                            <div class="col-md-12" style="margin-top: 3%;">
                        <div class="table-responsive" style="font-size: 14px;">
                        <!--<table class="table table-hover">-->
                        <table id="example5" class="display" style="border: 1px solid #000" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th></th>                                 
                                    <th style="text-align: center">Curso</th>
                                    <th style="text-align: center">Inscritos</th>
                                    <th style="text-align: center">Vacantes</th>
                                    <th style="text-align: center">Disponibles</th>
                                    <th style="text-align: center">Frecuencia</th>
                                    <th style="text-align: center">Fecha Inicio</th>
                                    <th style="text-align: center">Fecha Término</th>
                                    <th style="text-align: center">Estado</th>
                                    <th style="text-align: center">Lab</th>
                                    <th style="text-align: center">Docente</th>
                                    <th style="text-align: center">Opción</th>
                                </tr>
                            </thead>
                            <tbody>
<%
try {
        Class.forName("com.mysql.jdbc.Driver");
        cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
        sta=cnx.createStatement();
        rs=sta.executeQuery("select T1.id_registro,T1.cod_cur,T3.nombre_cur,T1.paga,T1.dni_pro,T2.nombre_pro,T2.apellidos_pro,T1.fechatini,T1.fechatfin,T1.esta,T1.labo,T3.vaca_cur,-sum(paga-vaca_cur),T1.frec FROM registro T1 INNER JOIN profesores T2 INNER JOIN cursos T3  ON T1.dni_pro = T2.dni_pro AND T1.cod_cur = T3.cod_cur group by T1.id_registro");
        while (rs.next()){
%>
                                <tr>
                                    <td style="text-align: center;padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;"><a style="color: #000"><i class="material-icons" style="font-size: 15px">description</i></a></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><a href="assign.jsp?codcur=<%=rs.getString(2)%>&nombrecur=<%=rs.getString(3)%>" style="text-decoration: none;color:#000;" title="Asignar <%=rs.getString(3)%> a otro docente" data-toggle="tooltip" data-placement="right"><%=rs.getString(3)%></a></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center;"><%=rs.getInt(4)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getInt(12)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center;color: red"><%=rs.getInt(13)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(14)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(8)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(9)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(10)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(11)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><a href="assign.jsp?dnipro=<%=rs.getString(5)%>&apellidospro=<%=rs.getString(7)%>&nombrepro=<%=rs.getString(6)%>" style="text-decoration: none;color:#000;" title="Asignar otro curso a este docente" data-toggle="tooltip" data-placement="left"><%=rs.getString(7)%>, <%=rs.getString(6)%></a></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center">
                                        <a href="session.jsp?id=<%=rs.getString(1)%>&dnipro=<%=rs.getString(5)%>">
                                            <i data-toggle="tooltip" data-placement="left" class="material-icons" style="font-size: 15px; color: #000" title="Agregar sesión">timer</i></a>
                                        <a href="edit_rela.jsp?id=<%=rs.getString(1)%>">
                                            <i data-toggle="tooltip" data-placement="top" class="material-icons" style="font-size: 15px; color: #000" title="Editar">edit</i></a>
                                        <a href="eliminarrela.jsp?id=<%=rs.getString(1)%>" onclick="return eliminar()">
                                            <i data-toggle="tooltip" data-placement="right" class="material-icons" style="font-size: 15px;color: #000" title="Eliminar">highlight_off</i></a>
                                    </td>
                                </tr>                      
<% 
    }
    sta.close();
    rs.close();
    cnx.close();
    } catch (Exception e) {
    }
%>
                            </tbody>
                        </table>
                        </div>
                    </div>
                        </div>
   
                    </div> 
     
                </div>

            </div>
            <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">

                <div class="row">
                         <div class="col-md-12">
                            <div class="col-md-12" style="margin-top: 3%;">
                        <div class="table-responsive" style="max-height: 450px;font-size: 14px;">
                        <!--<table class="table table-hover">-->
                        <table id="example3" class="display" style="border: 1px solid #000" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th style="text-align: center">Docente</th>
                                    <th style="text-align: center">Curso</th>
                                    <th style="text-align: center">Hora Programada</th>
                                    <th style="text-align: center">Hora Ingreso - Salida</th>
                                    <th style="text-align: center">Dia</th>
                                    <th style="text-align: center">Estado</th>
                                </tr>
                            </thead>
                            <tbody>
<%
    try {
    Class.forName("com.mysql.jdbc.Driver");
    cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
    sta=cnx.createStatement();
    rs=sta.executeQuery("select P.apellidos_pro,P.nombre_pro,C.nombre_cur,substring(I.horaingreso,1,11),substring(I.horaingreso,13,50),substring(S.horasalida,1,11),substring(S.horasalida,13,50),Se.horasini,Se.horasfin "
            + "from ingreso I "
            + "inner join salida S "
            + "inner join sesion Se "
            + "inner join registro R "
            + "inner join cursos C "
            + "inner join profesores P "
            + "on I.id_ingreso=S.id_ingreso "
            + "and Se.id_sesion=I.id_sesion "
            + "and R.id_registro=Se.id_registro "
            + "and R.dni_pro=P.dni_pro "
            + "and R.cod_cur=C.cod_cur "
            + "group by I.id_ingreso");
    while (rs.next()){
%>
                                <tr>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(1)%>, <%=rs.getString(2)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(3)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(8)%> - <%=rs.getString(9)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(4)%> - <%=rs.getString(6)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(5)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><label style="color: blue">Asistió</label></td>

                                </tr>                      
<% 
    }
    sta.close();
    rs.close();
    cnx.close();
    } catch (Exception e) {
    }
%>
                            </tbody>
                        </table>
                        </div>
                    </div>
                        </div>
                </div>
                            
                            <div class="row">
                         <div class="col-md-12">
                            <div class="col-md-12" style="margin-top: 3%;">
                        <div class="table-responsive" style="max-height: 450px;font-size: 14px;">
                        <!--<table class="table table-hover">-->
                        <table id="example4" class="display" style="border: 1px solid #000" cellspacing="0" width="100%">
                            <thead>
                                <tr>
                                    <th style="text-align: center">Fecha</th>
                                    <th style="text-align: center">Hora Programada</th>
                                    <th style="text-align: center">Curso</th>
                                    <th style="text-align: center">Docente</th>
                                    <th style="text-align: center">Estado</th>

                                </tr>
                            </thead>
                            <tbody>
<%
    try {
    Class.forName("com.mysql.jdbc.Driver");
    cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
    sta=cnx.createStatement();
    rs=sta.executeQuery("select S.id_sesion,S.fecha,S.horasini,S.horasfin,C.nombre_cur,P.nombre_pro,P.apellidos_pro "
            + "from sesion S "
            + "inner join registro R "
            + "inner join profesores P "
            + "inner join cursos C "
            + "on S.id_registro=R.id_registro "
            + "and R.dni_pro=P.dni_pro "
            + "and R.cod_cur=C.cod_cur "
            + "where S.id_sesion "
            + "not in (select I.id_sesion from ingreso I)");
    while (rs.next()){
%>
                                <tr>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(2)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(3)%> - <%=rs.getString(4)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(5)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><%=rs.getString(7)%>, <%=rs.getString(6)%></td>
                                    <td style="padding: 0px 0px 0px 0px;margin: 0px 0px 0px 0px;text-align: center"><label style="color: red">Faltó</label></td>
                                </tr>                        
<% 
    }
    sta.close();
    rs.close();
    cnx.close();
    } catch (Exception e) {
    }
%>
                            </tbody>
                        </table>
                        </div>
                    </div>
                        </div>
                </div>

            </div>
</div>

<div class="modal-wrapper" id="popup">
    <div style="position: relative;margin:10% auto;padding:30px 30px;background-color: #fafafa;color:#333;border-radius: 3px;width:90%;">
        <div class="row" id="light" style="display: none;">
            <div class="col-md-12">
                <form action="docentes_admin" name="holapro">
                    <div class="row">
                        <div class="col-md-2 mb-2">
                            <input type="text" name="dnipro" placeholder="DNI" required maxlength="12" style="width: 100%;padding-left: 3px;font-size: 13px;outline-color: #007AFF;">
                        </div>
                        <div class="col-md-4 mb-2">
                            <input type="text" name="nombrepro" placeholder="Nombre" required style="width: 100%;padding-left: 3px;font-size: 13px;outline-color: #007AFF">
                        </div>
                        <div class="col-md-6 mb-2">
                            <input type="text" name="apellidospro" placeholder="Apellidos" required style="width: 100%;padding-left: 3px;font-size: 13px;outline-color: #007AFF">
                        </div>
                        <div class="col-md-2 mb-2">
                            <input type="text" name="sede" placeholder="Sede"  style="width: 100%;padding-left: 3px;font-size: 13px;outline-color: #007AFF">
                        </div>
                        <div class="col-md-10 mb-2">
                            <input type="text" name="dire" placeholder="Dirección"  style="width: 100%;padding-left: 3px;font-size: 13px;outline-color: #007AFF">
                        </div>
                        <div class="col-md-6 mb-2">
                            <input type="text" name="tele" placeholder="Teléfono"  style="width: 100%;padding-left: 3px;font-size: 13px;outline-color: #007AFF">
                        </div>
                        <div class="col-md-6 mb-2">
                            <input type="text" name="corr" placeholder="Email"  style="width: 100%;padding-left: 3px;font-size: 13px;outline-color: #007AFF">
                        </div>
                        <div class="col-md-8 mb-2">
                            <input type="text" name="prof" placeholder="Profesión"  style="width: 100%;padding-left: 3px;font-size: 13px;outline-color: #007AFF">
                        </div>
                        <div class="col-md-4 mb-2">
                            <input type="text" name="grad" placeholder="Grado"  style="width: 100%;padding-left: 3px;font-size: 13px;outline-color: #2196F3">
                        </div>
                        <div class="col-md-12 mb-2">
                            <textarea name="espe" style="width: 100%;padding-left: 3px;font-size: 13px;outline-color: #007AFF" placeholder="Especialidad"></textarea>
                        </div>
                        <div class="col-md-12 mb-2">
                            <textarea name="expe" style="width: 100%;padding-left: 3px;font-size: 13px;outline-color: #007AFF" placeholder="Experiencia"></textarea>
                        </div>
        
                        <label style="width: 100%;font-size: 10px;margin-left: 15px;">Agregar cursos de referencia + 
                        <input type="checkbox" name="c33" onclick="showMe('j1', this),showMe('j2', 'none'),showMe('s2', this),showMe('s3', this),showMe('s4', this),showMe('s5', 'none'),showMe('s6', 'none'),showMe('s7', 'none'),showMe('s8', 'none'),showMe('s9', 'none'),showMe('s10', 'none'),showMe('s11', 'none'),showMe('s12', 'none')">
                        </label>

                        <select name="c1" id="s1" style="display: block;font-size: 13px;margin-left: 15px;width: 40%">
                        <option value="null">Curso 1</option>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
                        sta=cnx.createStatement();
                        rs=sta.executeQuery("select * from cursos");
                        while (rs.next()){
                %>
                        <option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option>
                <% 
                }
                sta.close();
                rs.close();
                cnx.close();
                    } catch (Exception e) {
                           }
                %>  
                        </select>
                        <select name="c2" id="s2" style="display: none;font-size: 13px;margin-left: 15px;width: 40%">
                        <option value="null">Curso 2</option>
                <%
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
                        sta=cnx.createStatement();
                        rs=sta.executeQuery("select * from cursos");
                        while (rs.next()){
                %>
                        <option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option>
                <% 
                }
                sta.close();
                rs.close();
                cnx.close();
                    } catch (Exception e) {
                           }
                %>  
                    </select>
                        <select name="c3" id="s3" style="display: none;font-size: 13px;margin-left: 15px;width: 40%">
                        <option value="null">Curso 3</option>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
                            sta=cnx.createStatement();
                            rs=sta.executeQuery("select * from cursos");
                            while (rs.next()){
                    %>
                    <option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option>
                                          <% 
                    }
                    sta.close();
                    rs.close();
                    cnx.close();
                        } catch (Exception e) {
                               }
                    %>
                    </select>
                        <select name="c4" id="s4" style="display: none;font-size: 13px;margin-left: 15px;width: 40%">
                        <option value="null">Curso 4</option>
                    <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
                            sta=cnx.createStatement();
                            rs=sta.executeQuery("select * from cursos");
                            while (rs.next()){
                    %>
                    <option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option>
                    <% 
                    }
                    sta.close();
                    rs.close();
                    cnx.close();
                        } catch (Exception e) {
                               }
                    %>  
                    </select>

                        <label style="margin-top: 10px;display: none;width: 100%;font-size: 10px;margin-left: 15px;" id="j1">Agregar cursos de referencia + <input type="checkbox" name="c4"  onclick="showMe('j2', this),showMe('s5', this),showMe('s6', this),showMe('s7', this),showMe('s8', this)"><br></label>

                        <select name="c5" id="s5" style="display: none;font-size: 13px;margin-left: 15px;width: 40%">
                            <option value="null">Curso 5</option>
                        <%
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
                                sta=cnx.createStatement();
                                rs=sta.executeQuery("select * from cursos");
                                while (rs.next()){
                        %>
                        <option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option>
                                              <% 
                        }
                        sta.close();
                        rs.close();
                        cnx.close();
                            } catch (Exception e) {
                                   }
                        %>  
                        </select>
                        <select name="c6" id="s6" style="display: none;font-size: 13px;margin-left: 15px;width: 40%">
                            <option value="null">Curso 6</option>
                        <%
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
                                sta=cnx.createStatement();
                                rs=sta.executeQuery("select * from cursos");
                                while (rs.next()){
                        %>
                        <option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option>
                                              <% 
                        }
                        sta.close();
                        rs.close();
                        cnx.close();
                            } catch (Exception e) {
                                   }
                        %>  
                        </select>
                        <select name="c7" id="s7" style="display: none;font-size: 13px;margin-left: 15px;width: 40%">
                            <option value="null">Curso 7</option>
                        <%
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
                                sta=cnx.createStatement();
                                rs=sta.executeQuery("select * from cursos");
                                while (rs.next()){
                        %>
                        <option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option>
                                              <% 
                        }
                        sta.close();
                        rs.close();
                        cnx.close();
                            } catch (Exception e) {
                                   }
                        %>  
                        </select>
                        <select name="c8" id="s8" style="display: none;font-size: 13px;margin-left: 15px;width: 40%">
                            <option value="null">Curso 8</option>
                        <%
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
                                sta=cnx.createStatement();
                                rs=sta.executeQuery("select * from cursos");
                                while (rs.next()){
                        %>
                        <option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option>
                                              <% 
                        }
                        sta.close();
                        rs.close();
                        cnx.close();
                            } catch (Exception e) {
                                   }
                        %>  
                        </select>

                        <label style="margin-top: 10px;display: none;width: 100%;font-size: 10px;margin-left: 15px;" id="j2">Agregar cursos de referencia + <input type="checkbox" name="c4"  onclick="showMe('s9', this),showMe('s10', this),showMe('s11', this),showMe('s12', this)"><br></label>

                        <select name="c9" id="s9" style="display: none;font-size: 13px;margin-left: 15px;width: 40%">
                            <option value="null">Curso 9</option>
                        <%
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
                                sta=cnx.createStatement();
                                rs=sta.executeQuery("select * from cursos");
                                while (rs.next()){
                        %>
                        <option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option>
                                              <% 
                        }
                        sta.close();
                        rs.close();
                        cnx.close();
                            } catch (Exception e) {
                                   }
                        %>  
                        </select>
                        <select name="c10" id="s10" style="display: none;font-size: 13px;margin-left: 15px;width: 40%">
                            <option value="null">Curso 10</option>
                        <%
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
                                sta=cnx.createStatement();
                                rs=sta.executeQuery("select * from cursos");
                                while (rs.next()){
                        %>
                        <option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option>
                                              <% 
                        }
                        sta.close();
                        rs.close();
                        cnx.close();
                            } catch (Exception e) {
                                   }
                        %>  
                        </select>
                        <select name="c11" id="s11" style="display: none;font-size: 13px;margin-left: 15px;width: 40%">
                            <option value="null">Curso 11</option>
                        <%
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
                                sta=cnx.createStatement();
                                rs=sta.executeQuery("select * from cursos");
                                while (rs.next()){
                        %>
                        <option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option>
                                              <% 
                        }
                        sta.close();
                        rs.close();
                        cnx.close();
                            } catch (Exception e) {
                                   }
                        %>  
                        </select>
                        <select name="c12" id="s12" style="display: none;font-size: 13px;margin-left: 15px;width: 40%">
                            <option value="null">Curso 12</option>
                        <%
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
                                sta=cnx.createStatement();
                                rs=sta.executeQuery("select * from cursos");
                                while (rs.next()){
                        %>
                        <option value="<%=rs.getString(2)%>"><%=rs.getString(2)%></option>
                                              <% 
                        }
                        sta.close();
                        rs.close();
                        cnx.close();
                            } catch (Exception e) {
                                   }
                        %>  
                        </select>

                        <button onclick="return registrar()" style="margin-top: 10px;margin-left: 92%;color: #fafafa;background: #007AFF;border: 0px;border-radius: 3px;">Grabar</button>
                    </div>  
                </form>
            </div>
        </div>
                        <a class="popup-cerrar" href="#" title="Cerrar" onclick = "document.getElementById('light').style.display='none';">x</a>
    </div>
</div>                             
                                                  
<div class="modal-wrapper" id="popup2">
    <div class="popup-contenedor2"> 
        <div class="row" id="light2" style="display: block;">
            <div class="col-m12">
                <div class="table-responsive">
                    <table class="table table-hover" style="font-size: 14px;">    
                        <thead>
                            <tr>
                                <th style="text-align: center;">DNI</th>
                                <th style="text-align: center;">Apellidos y Nombres</th>
                                <th style="text-align: center;">Profesión</th>
                                <th style="text-align: center;">Grado</th>
                                <th style="text-align: center;">Opción</th>
                            </tr>
                        </thead>
<%
try {
    Class.forName("com.mysql.jdbc.Driver");
    cnx = DriverManager.getConnection("jdbc:mysql://localhost:3306/bdenei?user=root&password=root");
    sta=cnx.createStatement();
    rs=sta.executeQuery("SELECT dni_pro,nombre_pro,apellidos_pro,tele_pro,dire_pro,corr_pro,"
            + "cpre_pro,grad_pro,prof_pro,tipo_pro,cpos_pro,espe_pro,dipl_pro,expe_pro,sede_pro,"
            + "if(c1 !='null',c1,''), if(c2 !='null',c2,''),"
            + "if(c3 !='null',c3,''), if(c4 !='null',c4,''),"
            + "if(c5 !='null',c5,''), if(c6 !='null',c6,''),"
            + "if(c7 !='null',c7,''), if(c8 !='null',c8,''),"
            + "if(c9 !='null',c9,''), if(c10 !='null',c10,''),"
            + "if(c11 !='null',c11,''), if(c12 !='null',c12,'')"
            + "FROM profesores "
            + "WHERE dni_pro="+dnipro);
    while (rs.next()){
%>
                        <tbody>
                            <tr>
                                <td style="text-align: center;padding: 10px 5px 5px 5px;margin: 10px 5px 5px 5px;"><%=rs.getString(1)%></td>
                                <td style="text-align: center;padding: 10px 5px 5px 5px;margin: 10px 5px 5px 5px;"><%=rs.getString(3)%> <%=rs.getString(2)%></td>
                                <td style="text-align: center;padding: 10px 5px 5px 5px;margin: 10px 5px 5px 5px;"><%=rs.getString(9)%></td>
                                <td style="text-align: center;padding: 10px 5px 5px 5px;margin: 10px 5px 5px 5px;"><%=rs.getString(8)%></td>
                                <td style="text-align: center;padding: 10px 5px 5px 5px;margin: 10px 5px 5px 5px;">
                                    <a href="edit.jsp?dnipro=<%=rs.getString(1)%>" style="text-decoration: none; color: #000;"><i class="material-icons">edit</i></a>
                                    <a href="#" style="text-decoration: none; color: #000;"><i class="material-icons">highlight_off</i></a>
                                </td>
                            </tr>
                            <tr class="">
                                <td style="text-align: center;padding: 10px 5px 5px 5px;margin: 10px 5px 5px 5px;" class="" title="Cursos de referencia"><i class="material-icons">import_contacts</i>
                                </td>
                                <td colspan="4" class="" title="Cursos de referencia" style="padding: 10px 5px 5px 5px;margin: 10px 5px 5px 5px;">
                                    <ul style="list-style-type: none; padding: 0px 0px;color: #0069B4">
                                       <li><%=rs.getString(16)%></li>
                                       <li><%=rs.getString(17)%></li>
                                       <li><%=rs.getString(18)%></li>
                                       <li><%=rs.getString(19)%></li>
                                       <li><%=rs.getString(20)%></li>
                                       <li><%=rs.getString(21)%></li>
                                       <li><%=rs.getString(22)%></li>
                                       <li><%=rs.getString(23)%></li>
                                       <li><%=rs.getString(24)%></li>
                                       <li><%=rs.getString(25)%></li>
                                       <li><%=rs.getString(26)%></li>
                                       <li><%=rs.getString(27)%></li>
                                    </ul>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: center;padding: 10px 5px 5px 5px;margin: 10px 5px 5px 5px;" class="" title="Especialidad"><i class="material-icons">school</i></td>
                                <td style="padding: 10px 5px 5px 5px;margin: 10px 5px 5px 5px;" colspan="4" class="" title="Especialidad"><%=rs.getString(12)%></td>
                            </tr>
                            <tr class="">
                                <td style="text-align: center;padding: 10px 5px 5px 5px;margin: 10px 5px 5px 5px;" class="" title="Experiencia"><i class="material-icons">school</i></td>
                                <td style="padding: 10px 5px 5px 5px;margin: 10px 5px 5px 5px;" colspan="4" class="" title="Experiencia"><%=rs.getString(14)%></td>
                            </tr>
                            <tr class="">
                                <td style="text-align: center;padding: 10px 5px 5px 5px;margin: 10px 5px 5px 5px;" class=""><i class="material-icons">phone</i></td>
                                <td style="padding: 10px 5px 5px 5px;margin: 10px 5px 5px 5px;" colspan="4" class=""><%=rs.getString(4)%> - <%=rs.getString(6)%></td>
                            </tr>
                            <tr class="">
                                <td style="text-align: center;padding: 10px 5px 5px 5px;margin: 10px 5px 5px 5px;" class=""><i class="material-icons">location_on</i></td>
                                <td style="padding: 10px 5px 5px 5px;margin: 10px 5px 5px 5px;" colspan="4" class=""><%=rs.getString(5)%>
                            </tr>
                        </tbody>
<% 
}
sta.close();
rs.close();
cnx.close();
} catch (Exception e) {
       }
%>
                    </table>
                </div> 
            </div>
        </div>
                        <a class="popup-cerrar2" href="#" title="Cerrar" onclick = "document.getElementById('light2').style.display='none';">x</a>
    </div>
</div>

<div class="modal-wrapper" id="popup4">
    <div style="position: relative;margin:10% auto;padding:30px 30px;background-color: #fafafa;color:#333;border-radius: 3px;width:80%;">
        <div class="row" id="light4" style="display: none;">
            <div class="col-md-12">
                <form action="cursos_admin" name="holapro" class="form-horizontal">
                    <fieldset>
                    <legend style="font-weight: 600">NUEVO CURSO</legend>
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label for="nombrecur">CURSO</label>
                            <input name="nombrecur" type="text" class="form-control" id="nombrecur" required="">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="vaca">VACANTES</label>
                            <input name="vaca" type="number" class="form-control" id="vaca" required="">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="cost">COSTO S/.</label>
                            <input name="cost" type="text" class="form-control" id="cost" required="">
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <label for="desc">DESCRIPCIÓN</label>
                            <textarea name="desc" class="form-control" id="desc"></textarea>
                        </div>
                    </div> 
                    <div class="form-row">
                        <div class="form-group col-md-12" style="text-align: right">
                        <button onclick="return registrar()" class="btn btn-primary" type="submit">Grabar</button>
                    </div>
                    </div>
                    </fieldset>
                </form>
            </div>
        </div>
              <a class="popup-cerrar4" href="#" title="Cerrar" onclick = "document.getElementById('light4').style.display='none';">x</a>
    </div>
</div> 

                    
                    
                    
<script type="text/javascript">
    $(document).ready(function() {
    $('#example').DataTable({
        "language": {
    "sProcessing":     "Procesando...",
    "sLengthMenu":     "Mostrar _MENU_ registros",
    "sZeroRecords":    "No se encontraron resultados",
    "sEmptyTable":     "Ningún dato disponible en esta tabla",
    "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
    "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
    "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
    "sInfoPostFix":    "",
    "sSearch":         "Buscar:",
    "sUrl":            "",
    "sInfoThousands":  ",",
    "sLoadingRecords": "Cargando...",
    "oPaginate": {
        "sFirst":    "Primero",
        "sLast":     "Último",
        "sNext":     "Siguiente",
        "sPrevious": "Anterior"
    },
    "oAria": {
        "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
    }
}
    } );
} );
</script>

<script type="text/javascript">
    $(document).ready(function() {
    $('#example1').DataTable({
        "language": {
    "sProcessing":     "Procesando...",
    "sLengthMenu":     "Mostrar _MENU_ registros",
    "sZeroRecords":    "No se encontraron resultados",
    "sEmptyTable":     "Ningún dato disponible en esta tabla",
    "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
    "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
    "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
    "sInfoPostFix":    "",
    "sSearch":         "Buscar:",
    "sUrl":            "",
    "sInfoThousands":  ",",
    "sLoadingRecords": "Cargando...",
    "oPaginate": {
        "sFirst":    "Primero",
        "sLast":     "Último",
        "sNext":     "Siguiente",
        "sPrevious": "Anterior"
    },
    "oAria": {
        "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
    }
}
    } );
} );
</script>

<script type="text/javascript">
    $(document).ready(function() {
    $('#example2').DataTable({
        "language": {
    "sProcessing":     "Procesando...",
    "sLengthMenu":     "Mostrar _MENU_ registros",
    "sZeroRecords":    "No se encontraron resultados",
    "sEmptyTable":     "Ningún dato disponible en esta tabla",
    "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
    "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
    "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
    "sInfoPostFix":    "",
    "sSearch":         "Buscar:",
    "sUrl":            "",
    "sInfoThousands":  ",",
    "sLoadingRecords": "Cargando...",
    "oPaginate": {
        "sFirst":    "Primero",
        "sLast":     "Último",
        "sNext":     "Siguiente",
        "sPrevious": "Anterior"
    },
    "oAria": {
        "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
    }
}
    } );
} );
</script>

<script type="text/javascript">
    $(document).ready(function() {
    $('#example3').DataTable({
        "language": {
    "sProcessing":     "Procesando...",
    "sLengthMenu":     "Mostrar _MENU_ registros",
    "sZeroRecords":    "No se encontraron resultados",
    "sEmptyTable":     "Ningún dato disponible en esta tabla",
    "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
    "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
    "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
    "sInfoPostFix":    "",
    "sSearch":         "Buscar:",
    "sUrl":            "",
    "sInfoThousands":  ",",
    "sLoadingRecords": "Cargando...",
    "oPaginate": {
        "sFirst":    "Primero",
        "sLast":     "Último",
        "sNext":     "Siguiente",
        "sPrevious": "Anterior"
    },
    "oAria": {
        "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
    }
}
    } );
} );
</script>

<script type="text/javascript">
    $(document).ready(function() {
    $('#example4').DataTable({
        "language": {
    "sProcessing":     "Procesando...",
    "sLengthMenu":     "Mostrar _MENU_ registros",
    "sZeroRecords":    "No se encontraron resultados",
    "sEmptyTable":     "Ningún dato disponible en esta tabla",
    "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
    "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
    "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
    "sInfoPostFix":    "",
    "sSearch":         "Buscar:",
    "sUrl":            "",
    "sInfoThousands":  ",",
    "sLoadingRecords": "Cargando...",
    "oPaginate": {
        "sFirst":    "Primero",
        "sLast":     "Último",
        "sNext":     "Siguiente",
        "sPrevious": "Anterior"
    },
    "oAria": {
        "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
    }
}
    } );
} );
</script>

<script type="text/javascript">
    $(document).ready(function() {
    $('#example5').DataTable({
        "language": {
    "sProcessing":     "Procesando...",
    "sLengthMenu":     "Mostrar _MENU_ registros",
    "sZeroRecords":    "No se encontraron resultados",
    "sEmptyTable":     "Ningún dato disponible en esta tabla",
    "sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
    "sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
    "sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
    "sInfoPostFix":    "",
    "sSearch":         "Buscar:",
    "sUrl":            "",
    "sInfoThousands":  ",",
    "sLoadingRecords": "Cargando...",
    "oPaginate": {
        "sFirst":    "Primero",
        "sLast":     "Último",
        "sNext":     "Siguiente",
        "sPrevious": "Anterior"
    },
    "oAria": {
        "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
    }
}
    } );
} );
</script>

<script type="text/javascript">
    function showMe (it, box) {
    var vis = (box.checked) ? "block" : "none";
    document.getElementById(it).style.display = vis;
    }
</script>
               
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"></script>
    </body>
</html>
