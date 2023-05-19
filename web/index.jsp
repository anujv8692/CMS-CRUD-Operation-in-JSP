<%-- 
    Document   : index
    Created on : 05-May-2023, 5:55:47 pm
    Author     : anujv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!--Bootstrap cdn-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script> 
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">


        <!--jquery cdn-->
        <!--if we need to use the valid method of jquery the below cdn is mandatory-->
        <!--        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>  
                <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js"></script>  -->

        <script src="components/jquery.3.5.1-min.js" type="text/javascript"></script>
        <script src="components/jquery.validate.min.js" type="text/javascript"></script>

        <!--datatables cdn-->
        <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.css" />




    </head>
    <body>


        <nav class="navbar navbar-dark bg-dark">
            <h2 class="text-light">Basic Customer Management System</h2>
        </nav>
        <br/>
        <div class="row">
            <div class="col-sm-4" style="border: 0.2em grey solid; padding: 10px;">
                <div class="container">
                    <form id="formcustomer" name="formcustomer" method="post">
                        <div class="mb-3">
                            <label class="fw-bold">Customer Name :</label><input type="text" id="customername" name="customername" placeholder="Customer Name" size="30em" class="form-control" required/>
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">Customer Email :</label><input type="email" id="customeremail" name="customeremail" placeholder="Customer Email" size="30em" class="form-control" required/>
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">Customer Gender :</label>
                            <input type="radio" style="margin-left: 2em;" title="male"  id="gendermale" name="customergender"  value="male" size="30em" required/>Male
                            <input type="radio" style="margin-left: 2em;" title="female" id="genderfemale" name="customergender"  value="female" size="30em" required/>Female
                        </div>
                        <div class="mb-3">
                            <label class="fw-bold">Phone : </label><input type="text" placeholder="Enter Phone No" id="customerphone" name="customerphone" class="form-control" pattern="[6-9]{1}[0-9]{9}" required/>
                        </div>
                        <div class="mt-4">
                            <button id="addButton" style="margin-left: 5em;" class="btn btn-info" id="save" onclick="addCustomer()">Add</button>
                            <button style="margin-left: 5em;" class="btn btn-warning" id="reset" onclick="reSet()">Reset</button>
                        </div>

                    </form>
                </div>
            </div>
            <div class="col-sm-8" style="border: 0.2em grey solid; padding: 10px;">

                <div class="panel-body">
                    <table id="tbl-customer" class="table table-bordered" cellpadding="0" cellspacing="0" width="100%" >
                        <thead>
                            <tr>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>
                                <th></th>

                            </tr>
                        </thead>

                    </table> 
                </div>
            </div>
        </div>

        <script>

            getAllData();
            var isNew = true;
            var CustomerId;
            var globalCustomerId;



            function addCustomer() {
                if ($("#formcustomer").valid()) {
                    var url = "";
                    var data = "";
                    var method;
                    if (isNew == true) {
                        url = 'addCustomer.jsp';
                        data = $("#formcustomer").serialize();
                        method = 'POST';
                    } else {
                        url = 'updateCustomer.jsp';
                        data = $("#formcustomer").serialize() + "&CustomerId=" + globalCustomerId; //adding additonal data
                        method = 'POST';
                    }
                    $.ajax({
                        type: method,
                        url: url,
                        dataType: 'text',
                        data: data,
                        success: function (data, textStatus, jqXHR) {
                            if (isNew == true) {
                                alert("Record Added Successfully...");
                            } else {
                                alert("Record Updated Successfully...");
                            }
                            getAllData();
                        }

                    });
                } else {
                    alert("Recheck all fields carefully and try again...");
                }
            }


            function getAllData() {
                $("#tbl-customer").dataTable().fnDestroy();
                $.ajax({
                    url: "getAllCustomer.jsp",
                    type: 'GET',
                    dataType: 'JSON',
                    success: function (data, textStatus, jqXHR) {
                        $("#tbl-customer").dataTable({
                            "aaData": data,
                            "scrollX": true,
                            "scrollY": true,
                            "aoColumns": [
                                {"sTitle": "Customer Id", "mData": "id"},
                                {"sTitle": "Customer Name", "mData": "name"},
                                {"sTitle": "Customer Email", "mData": "email"},
                                {"sTitle": "Customer Gender", "mData": "gender"},
                                {"sTitle": "Customer Phone", "mData": "phone"},

                                {
                                    "sTitle": "Edit",
                                    "mData": "id",
                                    "render": function (mData, type, row, meta) {
                                        return '<button class="btn btn-success" onclick="getDetailsOfCustomerUsingIdAndEdit(' + mData + ')">Edit</button>';
                                    }
                                },
                                {
                                    "sTitle": "Delete",
                                    "mData": "id",
                                    "render": function (mData, type, row, meta) {
                                        return '<button class="btn btn-danger" onclick="getDetailsOfCustomerUsingIdAndDelete(' + mData + ')">Delete</button>';
                                    }
                                }
                            ]



                        });
                    }
                });
            }

            function getDetailsOfCustomerUsingIdAndEdit(CustomerId) {

                $.ajax({
                    type: 'POST',
                    url: "getCustomerById.jsp",
                    data: {"CustomerId": CustomerId},
                    success: function (data, textStatus, jqXHR) {
                        isNew = false;
                        var obj = JSON.parse(data);
                        CustomerId = obj[0].CustomerIdGetFromDB;
                        globalCustomerId = obj[0].CustomerIdGetFromDB;
                        $('#customername').val(obj[0].CustomerNameGetFromDB);
                        $('#customeremail').val(obj[0].CustomerEmailGetFromDB);
//                        $('#customergender').val(obj[0].CustomerGenderGetFromDB);
                        var customergender = obj[0].CustomerGenderGetFromDB;
                        if (customergender == "male") {
                            $('#gendermale').prop("checked", true);
                        } else {
                            $('#genderfemale').prop("checked", true);
                        }
                        $('#customerphone').val(obj[0].CustomerPhoneGetFromDB);
                        $('#addButton').html("Update"); //to change button label to update
                    }
                });
            }


            function getDetailsOfCustomerUsingIdAndDelete(CustomerId) {
                $.ajax({
                    type: 'POST',
                    url: "getCustomerById.jsp",
                    data: {"CustomerId": CustomerId},
                    success: function (data, textStatus, jqXHR) {

                        var obj = JSON.parse(data);
                        globalCustomerId = obj[0].CustomerIdGetFromDB;
                        url = 'deleteCustomer.jsp';
                        data = $("#formcustomer").serialize() + "&CustomerId=" + globalCustomerId; //adding additonal data
                        method = 'POST';
                        $.ajax({
                            type: method,
                            url: url,
                            dataType: 'text',
                            data: data,
                            success: function (data, textStatus, jqXHR) {
                                alert("Record Deleted Successfully...");
                                getAllData();
                            }

                        });
                    }
                });
            }
        </script>
    </body>
</html>
