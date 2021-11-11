import 'dart:math';

String format(double amt, int round) {
  String res = '';
  if (amt >= 100000 && amt < 10000000) {
    res = '${(amt/100000).toStringAsFixed(round)} L';
  } else if (amt >= 10000000) {
    res = '${(amt/10000000).toStringAsFixed(round)} Cr';
  } else {
    res = '${amt.toStringAsFixed(round)}';
  }

  return res;
}

double sipCalculate(double p, double r, double t, bool sip) {
  double m = 0;
  double i = 0;
  double n = 0;

  if(sip) {
    i = r/1200;
    n = t*12;
    m = p*(((pow((1+i), n))-1)/i)*(1+i);
  } else {
    double x = 0;
    x = (1+(r/100));
    m = p*pow(x, t);
  }
  // print(m);
  return m;
}

double cagrCalculate(double p, double a, double t, bool cagr) {
  double per = 0;
  print('$p, $a, $t');
  if(cagr) {
    double x = (a/p);
    per = (pow(x, (1/t))-1)*100;
  } else {
    per = 100*(a-p)/p;
  }
  print(per);
  return per;
}

double emiCalculate(double p, double i, double t) {
  double emi = 0;
  double r = i/1200;
  double n = t*12;
  double x = (1+r);
  emi = 100000*p*r*(pow(x, n)/(pow(x, n)-1));
  print(emi);

  return emi;
}