// Define a function.

printInteger(int aNumber) {
  print('The number is $aNumber.'); // Print to console.
}

// This is where the app starts executing.
main() {
  int _ad = 0;
  print(_ad.toString());
  print("-------");
  var number = 42; // Declare and initialize a variable.
  printInteger(number); // Call a function.

  var name = 'test(((((())))))';
  print("hello, I am $name");
  int a = 10, b = 20;
  print("$a + $b = ${a + b}");

  var clapping = '\u{1f44f}';
  print(clapping); // 打印的是拍手emoji的表情

  // symbols
  print(#s == new Symbol("s")); // true
  print(#sss == new Symbol("sss")); // true

  print(add(1, 2)); // 3
  print(add2(2, 3)); // 5
  print(add3(1, 2)); // 3

  var arr = [1, 2, 3];
  arr.forEach(printNum);

  // ?.运算符
  // 跟.差不多,但是最左边的操作数可以为空；例子:foo?.bar从表达式foo中选择属性bar，
  // 除非foo为空(在这种情况下，foo?.bar值为空)
  var str1 = "hello world";
  var str2 = null;
  print(str1.length); // 11
  print(str1?.length); // 11
  print(str2?.length); // null
  try {
    print(str2.length); // 报错

  } catch (e) {
    print(e);
  }

  print(add3(2, 4));
  testDenghao(9);
}

onSuccess() {}

onFail() {}
// 声明返回值
int add(int a, int b) {
  return a + b;
}

// 不声明返回值
add2(int a, int b) {
  return a + b;
}

// =>是return语句的简写
add3(a, b) => a + b;

testDenghao(num n) => print(n);

void printNum(int a) {
  print("$a");
}

test(int value) {
  int b;
// 赋值给a
  int a = value;
// 如果b为空，则将值分配给b；否则，b保持不变
  b ??= value;
}
