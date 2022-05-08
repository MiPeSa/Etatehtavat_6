<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<title>Insert title here</title>

</head>
<body>
<table id="listaus" class="users">
	<thead>
		<tr>
			<th colspan="5" class="oikealle"><span id="uusiAsiakas"> Lisää uusi asiakas</span><th>
		<tr>
			<th colspan="3" class="oikealle">Hakusana:</th>
			<th><input type="text" id="hakusana"></th>
			<th class="hakunap"><input type="button" id="hakunappi"  value="Hae"></th>
		</tr>
		<tr>
			<th class="row-1 row-etunimi">Etunimi</th>
			<th class="row-2 row-sukunimi">Sukunimi</th>
			<th class="row-3 row-puhelin">Puhelin</th>
			<th class="row-4 row-sposti">Sähköposti</th>
			<th>&nbsp;</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<script>


$(document).ready(function(){
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaaasiakas.jsp";
	});
	
	
	
	$(document.body).on("keydown", function(event){
		if(event.which==13) {
			haeAsiakkaat();
		}
	});
	
	haeAsiakkaat();
	$("#hakunappi").click(function(){
		haeAsiakkaat();
	});
	
	$("#hakusana").focus();
	haeAsiakkaat();
});

function haeAsiakkaat() {
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){		
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr id='rivi_'"+field.asiakas_id+"'>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>";
        	htmlStr+="<td><a href='muutaasiakas.jsp?asiakas_id="+field.asiakas_id+"'>Muuta</a>&nbsp;";
        	htmlStr+="<td><span class='poista' onclick=poista("+field.asiakas_id+",'"+field.etunimi+"','"+field.sukunimi+"')>Poista</span></td>";
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });	
    }});	
	
}

function poista(asiakas_id, etunimi, sukunimi){
	if(confirm("Poista asiakas " + etunimi +" "+ sukunimi + "?")){
		$.ajax({url:"asiakkaat/"+asiakas_id, type:"DELETE", dataType:"json", success:function(result) { 
	        if(result.response==0){
	        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+asiakas_id).css("background-color", "red"); 
	        	alert("Asiakkaan " + etunimi +" "+ sukunimi +" poisto onnistui.");
				haeAsiakkaat();        	
			}
	    }});
	}
}

</script>
</body>
</html>