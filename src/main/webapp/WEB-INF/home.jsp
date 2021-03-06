<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Login Webapp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"></script>
</head>
<body>
<style>
    body {
        background-image: url('https://images.unsplash.com/photo-1520052205864-92d242b3a76b?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80');
        background-repeat: no-repeat;
        background-size: cover;
        background-attachment: fixed;
    }
</style>
<div class="container">
    <nav class="navbar navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand">SSC - Login Webapp</a>
            <a class="btn btn-light pull-right" type="button" href="/logout">
                <i class="fa fa-sign-out"></i>Logout</a>
        </div>
    </nav>
    <div class="row">
        <div class = "col-12">
            <h3 class="my-4"> Welcome, ${username}</h3>
        </div>
    </div>
    <div class="row">
        <div class = "col-12">
            <c:if test="${not empty message}">
                <c:choose>
                    <c:when test="${hasError}">
                        <div class="alert alert-danger" role="alert">
                                ${message}
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-success" role="alert">
                                ${message}
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </div>
    </div>
    <div class="row">
        <div class = "col-12">
            <a class="btn btn-success pull-right" type="button" href="/user/create">
                <i class="fa fa-plus"></i> &nbsp; New user
            </a>
        </div>
    </div>
    <div class="row">
        <div class = "col-12">
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th class="py-3">Id</th>
                    <th class="py-3">Username</th>
                    <th class="py-3">Display Name</th>
                    <th class="py-3">Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td class="py-3">${user.id}</td>
                        <td class="py-3">${user.username}</td>
                        <td class="py-3">${user.display_name}</td>
                        <td class="pt-3" class="align-middle">
                            <a class="btn btn-warning btn-sm" type="button" href="/user/edit?username=${user.username}">
                                <i class="fa fa-pencil"></i></a>
                            <a class="btn btn-info btn-sm" type="button" href="/user/password?username=${user.username}">
                                <i class="fa fa-key"></i></a>
                            <c:if test="${currentUser.username != user.username}">

                                <button
                                        class="btn btn-danger btn-sm"
                                        type="button" href="/user/delete?username=${user.username}"
                                        data-bs-toggle="modal"
                                        data-bs-target="#delete-modal-${user.id}"
                                >
                                    <i class="fa fa-trash"></i>
                                </button>
                                <!-- Modal -->
                                <div class="modal fade" id="delete-modal-${user.id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">Confirm deleting user</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                Do you want to delete <b>${user.display_name} (${user.username})</b>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                <a class="btn btn-danger" href="/user/delete?username=${user.username}">
                                                    <i class="fa fa-trash"></i> &nbsp; Delete
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>