// Define a function.
printInteger(int aNumber) {
  print('The number is $aNumber.'); // Print to console.
}

// This is where the app starts executing.
main() {
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
  var str1 = "hello world";
  var str2 = null;
  print(str1.length); // 11
  print(str1?.length); // 11
  print(str2?.length); // null
  print(str2.length); // 报错
}

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


void printNum(int a) {
  print("$a");
}