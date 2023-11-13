import 'dart:math';

abstract class Calculararea {
  Future<int> calcularPerimetro(int altura, int base);
  Future<int> calcularArea(int altura, int base);
  Future<double> calcularDiagonal(int altura, int base);
}

class Calcularforma extends Calculararea {
  @override
  Future<int> calcularPerimetro(int altura, int base) async {
    int perimetro = 2 * (base + altura);
    return perimetro;
  }

  @override
  Future<int> calcularArea(int altura, int base) async {
    int area = base * altura;
    return area;
  }

  @override
  Future<double> calcularDiagonal(int altura, int base) async {
    double diagonal = sqrt(pow(base, 2) + pow(altura, 2));
    return diagonal;
  }
}
