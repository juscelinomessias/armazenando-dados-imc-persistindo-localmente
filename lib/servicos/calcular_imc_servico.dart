class CalcularImcServico {
  static calcularImc(double peso, double altura) {
    var imc = peso / (altura * 2);
    var imcLimiteCasas = imc.toStringAsFixed(2);
    var resultado = "";

    if (imc < 16) {
      resultado = '$imcLimiteCasas - Magreza grave';
    } else if (imc >= 16 && imc < 17) {
      resultado = '$imcLimiteCasas - Magreza moderada';
    } else if (imc >= 17 && imc < 18.5) {
      resultado = '$imcLimiteCasas - Magreza leve';
    } else if (imc >= 18.5 && imc < 25) {
      resultado = '$imcLimiteCasas - Saudável';
    } else if (imc >= 25 && imc < 30) {
      resultado = '$imcLimiteCasas - Sobrepeso';
    } else if (imc >= 30 && imc < 35) {
      resultado = '$imcLimiteCasas - Obesidade Grau I';
    } else if (imc >= 35 && imc < 40) {
      resultado = '$imcLimiteCasas - Obesidade Grau II (severa)';
    } else if (imc >= 40) {
      resultado = '$imcLimiteCasas - Obesidade Grau III (mórbida)';
    }

    return resultado;
  }
}
