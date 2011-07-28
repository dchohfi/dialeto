$(function(){
   	$("input, textarea, select, button").uniform();
});
function validaCPF(cpf)
{
	erro = new String;

	valCpf = cpf.value;
	valCpf = valCpf.replace('.', '');
	valCpf = valCpf.replace('.', '');
	valCpf = valCpf.replace('-', '');
	valCpf = valCpf.replace(/_/g, '');
	if (valCpf.length == 11)
	{	
		var nonNumbers = /\D/;

		if (nonNumbers.test(valCpf)) 
		{
			erro = "A verificacao de CPF suporta apenas números!"; 
		}
		else
		{
			if (valCpf == "00000000000" || 
			valCpf == "11111111111" || 
			valCpf == "22222222222" || 
			valCpf == "33333333333" || 
			valCpf == "44444444444" || 
			valCpf == "55555555555" || 
			valCpf == "66666666666" || 
			valCpf == "77777777777" || 
			valCpf == "88888888888" || 
			valCpf == "99999999999") {

				erro = "Número de CPF inválido!"
			}

			var a = [];
			var b = new Number;
			var c = 11;

			for (i=0; i<11; i++){
				a[i] = valCpf.charAt(i);
				if (i < 9) b += (a[i] * --c);
			}

			if ((x = b % 11) < 2) { a[9] = 0 } else { a[9] = 11-x }
			b = 0;
			c = 11;

			for (y=0; y<10; y++) b += (a[y] * c--); 

			if ((x = b % 11) < 2) { a[10] = 0; } else { a[10] = 11-x; }

			if ((valCpf.charAt(9) != a[9]) || (valCpf.charAt(10) != a[10])) {
				erro = "Número de CPF inválido.";
			}
		}
	}
	else
	{
		if(valCpf.length == 0){
			return false
		}else{
			erro = "Número de CPF inválido.";
		}
	}
	if (erro.length > 0) {
		alert(erro);
		cpf.focus();
		return false;
	} 	
	return true;	
}

function maskCPF(CPF) {
	var evt = window.event;
	kcode=evt.keyCode;
	if (kcode == 8) return;
	if (CPF.value.length == 3) { CPF.value = CPF.value + '.'; }
	if (CPF.value.length == 7) { CPF.value = CPF.value + '.'; }
	if (CPF.value.length == 11) { CPF.value = CPF.value + '-'; }
}

function formataCPF(CPF)
{
	with (CPF)
	{
		value = value.substr(0, 3) + '.' + 
		value.substr(3, 3) + '.' + 
		value.substr(6, 3) + '-' +
		value.substr(9, 2);
	}
}
function retiraFormatacao(CPF)
{
	with (CPF)
	{
		value = value.replace (".","");
		value = value.replace (".","");
		value = value.replace ("-","");
		value = value.replace ("/","");
	}
}