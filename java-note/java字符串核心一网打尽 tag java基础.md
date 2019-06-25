##  java字符串核心一网打尽 tag: java基础

对字符串中最核心的点：对象创建和动态加入常量池这些点进行深入分析。

比如有两个面试题：

Q1：`String s = new String("abc");` 定义了几个对象。

Q2：如何理解`String`的`intern`方法？

A1：对于通过 `new` 产生的对象，会先去常量池检查有没有 “abc”，如果没有，先在常量池创建一个 “abc” 对象，然后在堆中创建一个常量池中此 “abc” 对象的拷贝对象。所以答案是：一个或两个。如果常量池中原来没有 ”abc”, 就是两个。如果原来的常量池中存在“abc”时，就是一个。

A2：当一个`String`实例调用`intern()`方法时，JVM会查找常量池中是否有相同Unicode的字符串常量，如果有，则返回其的引用，如果没有，则在常量池中增加一个Unicode等于str的字符串并返回它的引用；

## 字面量和运行时常量池

JVM为了提高性能和减少内存开销，在实例化字符串常量的时候进行了一些优化。为了减少在JVM中创建的字符串的数量，字符串类维护了一个字符串常量池。

在JVM运行时区域的方法区中，有一块区域是运行时常量池，主要用来存储编译期生成的各种字面量和符号引用。

了解过JVM就会知道，在java代码被javac编译之后，文件结构中是包含一部分`Constant pool`的。比如以下代码：

```
public static void main(String[] args) {
    String s = "abc";
}
```

经过编译后，常量池内容如下：

```
 Constant pool:
   #1 = Methodref          #4.#20         // java/lang/Object."<init>":()V
   #2 = String             #21            // abc
   #3 = Class              #22            // StringDemo
   #4 = Class              #23            // java/lang/Object
   ...
   #16 = Utf8               s
   ..
   #21 = Utf8               abc
   #22 = Utf8               StringDemo
   #23 = Utf8               java/lang/Object
```

上面的Class文件中的常量池中，比较重要的几个内容：

```
#16 = Utf8               s
#21 = Utf8               abc
#22 = Utf8               StringDemo
```

上面几个常量中，`s`就是前面提到的符号引用，而`abc`就是前面提到的字面量。而Class文件中的常量池部分的内容，会在运行期被运行时常量池加载进去。

## new String创建了几个对象

下面，我们可以来分析下`String s = new String("abc");`创建对象情况了。

这段代码中，我们可以知道的是，在编译期，符号引用`s`和字面量`abc`会被加入到Class文件的常量池中。由于是`new`的方式，在类加载期间，先去常量池检查有没有 “abc”，如果没有，先在常量池创建一个 “abc” 对象。

在运行期间，在堆中创建一个常量池中此 “abc” 对象的拷贝对象。

## 运行时常量池的动态扩展

编译期生成的各种字面量和符号引用是运行时常量池中比较重要的一部分来源，但是并不是全部。那么还有一种情况，可以在运行期像运行时常量池中增加常量。那就是String的`intern`方法。

当一个String实例调用`intern()`方法时，JVM会查找常量池中是否有相同`Unicode`的字符串常量，如果有，则返回其的引用，如果没有，则在常量池中增加一个`Unicode`等于str的字符串并返回它的引用；

`intern()`有两个作用，第一个是将字符串字面量放入常量池（如果池没有的话），第二个是返回这个常量的引用。

一个例子：

```java
import org.joda.time.DateTime;

/**
 * @Author YangKun
 * @Date 2018/10/17
 */
public class A {
    public static void main(String[] args) {
        String s= "hello world";

        String s1 = new String("hello world");

        System.out.println("s==s1:"+(s==s1));

        String s2 = new String("hello world").intern();

        System.out.println("s==s2:"+(s==s2));
    }
}
```

运行结果是：

```
s1==s2:false
s2==s3:true
```

你可以简单的理解为`String s = "hello world";`和`String s2 = new String("hello world").intern();`做的事情是一样的（但实际有些区别，这里暂不展开）。都是定义一个字符串对象，然后将其字符串字面量保存在常量池中，并把这个字面量的引用返回给定义好的对象引用。

对于`String s2 = new String("hello world").intern();`，在不调`intern`情况，`s2指向的是JVM在堆中创建的那个对象的引用的（如`s1`）。但是当执行了`intern`方法时，`s3`将指向字符串常量池中的那个字符串常量。

由于`s`和`s2`都是字符串常量池中的字面量的引用，所以`s`==`s2`。但是，`s1`的引用是堆中的对象，所以`s1!=s`。

## intern的正确用法

不知道，你有没有发现，在`String s2 = new String("abc").intern();`中，其实`intern`是多余的？

因为就算不用`intern`，"abc"作为一个字面量也会被加载到Class文件的常量池""，进而加入到运行时常量池中，为啥还要多此一举呢？到底什么场景下才会用到`intern`呢? 在解释这个之前，我们先来看下以下代码：

```
String s1 = "hello";
String s2 = "world";
String s3 = s1 + s2;
String s4 = "hello" + "world";
```

在经过反编译后，得到代码如下：

```
String s1 = "hello";
String s2 = "world";
String s3 = (new StringBuilder()).append(s1).append(s2).toString();
String s4 = "helloworld";
```

这就是阿里巴巴文档里为什么规定循环拼接字符串不准使用"+"而必须使用`StringBuilder`，因为反编译出的字节码文件显示每次循环都会 `new` 出一个 `StringBuilder` 对象，然后进行`append` 操作，最后通过 `toString` 方法返回 `String` 对象，造成内存资源浪费。

不恰当的方式形如：

```
String str = "start";
for (int i = 0; i < 100; i++) {
    str = str + "hello";
}
```

好了，言归正传，可以发现，同样是字符串拼接，`s3`和`s4`在经过编译器编译后的实现方式并不一样。`s3`被转化成`StringBuilder`及`append`，而`s4`被直接拼接成新的字符串。

如果你感兴趣，你还能发现，`String s4 = s1 + s2;` 经过编译之后，常量池中是有两个字符串常量的分别是 `hello`、`world`（其实`hello`和`world`是`String s1 = "hello";`和`String s2 = "world";`定义出来的），拼接结果`helloworld`并不在常量池中。

如果代码只有`String s4 = "hello" + "world";`，那么常量池中将只有`helloworld`而没有`hello`和 `world`。

**究其原因，是因为常量池要保存的是已确定的字面量值**。也就是说，对于字符串的拼接，纯字面量和字面量的拼接，会把拼接结果作为常量保存到字符串。

如果在字符串拼接中，有一个参数是非字面量，而是一个变量的话，整个拼接操作会被编译成`StringBuilder.append`，这种情况编译器是无法知道其确定值的。只有在运行期才能确定。

那么，有了这个特性了，`intern`就有用武之地了。**那就是很多时候，我们在程序中用到的字符串是只有在运行期才能确定的，在编译期是无法确定的，那么也就没办法在编译期被加入到常量池中**。

这时候，对于那种可能经常使用的字符串，使用`intern`进行定义，每次JVM运行到这段代码的时候，就会直接把常量池中该字面值的引用返回，这样就可以减少大量字符串对象的创建了。

## 总结

###### 第一种情况：

```
String str1 = "abc"; 
System.out.println(str1 == "abc"); 
```

- 栈中开辟一块空间存放引用str1；
- String池中开辟一块空间，存放String常量"abc"；
- 引用str1指向池中String常量"abc"；
- str1所指代的地址即常量"abc"所在地址，输出为true

###### 第二种情况：

```
String str2 = new String("abc"); 
System.out.println(str2 == "abc");
```

- 栈中开辟一块空间存放引用str2；
- 堆中开辟一块空间存放一个新建的String对象"abc"；
- 引用str2指向堆中的新建的String对象"abc"；
- str2所指代的对象地址为堆中地址，而常量"abc"地址在池中，输出为false；

###### 第三、四种情况

```
//（3）
String str1 = "a"；
String str2 = "b"；
String str3 = str1 + "b"；
//str1 和 str2 是字符串常量，所以在编译期就确定了。
//str3 中有个 str1 是引用，所以不会在编译期确定。
//又因为String是 final 类型的，所以在 str1 + "b" 的时候实际上是创建了一个新的对象，在把新对象的引用传给str3。

//（4）
final String str1 = "a"；
String str2 = "b"；
String str3 = str1 + "b"；
//这里和(3)的不同就是给 str1 加上了一个final，这样str1就变成了一个常量。
//这样 str3 就可以在编译期中就确定了
```

这里的细节在上面已经详细说明了。

###### 第五种情况

```
String str1 = "ab"；
String str2 = new String("ab");
System.out.println(str1== str2);//false
System.out.println(str2.intern() == str1);//true
```