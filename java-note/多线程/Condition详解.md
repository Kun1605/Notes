在[线程间通信方式总结](http://fossi.oursnail.cn/2019/02/13/thread/%E7%BA%BF%E7%A8%8B%E9%97%B4%E9%80%9A%E4%BF%A1%E6%96%B9%E5%BC%8F%E6%80%BB%E7%BB%93/)中有一个需求：轮流打印奇数和偶数，我们用wait和notify实现了一下，但是这种方式存在弊端，就是不能精确控制唤醒哪个线程，比如现在有一个需求是轮流打印ABC该怎么办呢？

首先准备三个线程，分别执行打印方法，是一个死循环，每次休息一秒。

[![image](assets/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d312e6a7067.jpg)](https://camo.githubusercontent.com/d6950657b1a59bd29a98e13e3f4f5c1517750aea/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d312e6a7067)

## 一、wait/notify实现轮流打印ABC三个字母

如果是不加任何控制策略的话，必然是无法保证按照`A` `B` `C`的顺序依次循环执行的，比如：

[![image](assets/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d322e6a7067.jpg)](https://camo.githubusercontent.com/e9d80759a0a6033f9c381d529a3dc02655f4f9a1/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d322e6a7067)

执行结果是：

1694620367

```
A
B
C
B
A
C
...
```

那么如何保证按照我们这个顺序执行呢？如果还是沿用这个方法，只能这样写：

[![image](assets/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d332e6a7067.jpg)](https://camo.githubusercontent.com/d59348583c99bca4be0ff250c3f9311bff9e3244/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d332e6a7067)

思想也很简单，就是搞一个变量，规定只有0的时候才打印`A`，只有1的时候才打印`B`，只有2的时候才打印`C`。那么，对于打印`A`的线程，只要不是0就`wait()`等待，一旦等于0就打印，并且加一；对于打印`B`的线程，只要不是1就`wait()`等待，一旦等于1就打印，并且加一。剩下同理。

这样，由于`signal`是一个成员变量，初始值为0.那么三个线程中`PrintB`和`PrintC`都等待，只有`PrintA`能执行打印，然后加为1，唤醒所有等待的线程来判断，此时打印`A`的线程和打印`C`的线程发现都不符合他们打印的条件，都进入了`while`中等待了，只有打印`B`的线程发现等于1，则不进入`while`循环，打印再加一。依次反复，可以得到顺序打印的`A`、`B`、`C`。

这种方式显然很不好，是靠`notifyAll`来唤醒所有线程来实现的，那么我们能不能唤醒指定的线程呢？这样处理起来更加优雅效率也会更高！

## 二、Condition来实现

[![image](assets/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d342e6a7067.jpg)](https://camo.githubusercontent.com/9bbfc9df91d915dad549358b85a180ee346dda09/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d342e6a7067)

达到了上面一样的效果。此时，我们发现它的强大之处在于我们可以指定哪个线程唤醒了，这看起来是一点点进步，但是我们学习多线程那么长时间了，在我看来，是很大的一个进步，因为之前用`notify`是随机唤醒一个，`notifyAll`是唤醒全部，总是不能受我们的完全控制，虽然说线程的执行本身就是不确定的，因此不确定性是他们的天生属性，但是在某些场景下我们确实需要一个高效并且优雅的实现可控的方式，所以是很重要的。

它这种功能可以给我们带来什么呢？下面用它实现一个有界队列。（关于生产者消费者模式，当然也可以用了，写法非常简单，就是对照上面的例子改一下即可。）

## 三、Condition实现有界队列

我们已经接触了线程池，它里面涉及队列，有很多种队列，最常见的是`ArrayBlockingQueue`以及`LinkedBlockingQueue`，他们的源码中其实也是靠`Condition`来实现阻塞塞值和阻塞取值的。现在我们也来实现一个比较简单的`ArrayBlockingQueue`吧！

首先明确一下队列是`FIFO`的，即先进先出，那么我们要保证先插入的要先弹出。其次要注意的是当没有元素的时候要阻塞，即等待有元素了才能获取；放入元素也是同理，要等有空位的才能重新放入。

如何实现以上这种数据结构呢？关于先进的先出来，我们可以用两个指针来实现，一个叫做`addIndex`，一个叫做`removeIndex`，初始都是指向第一个元素处。当塞进来一个元素，那么`addIndex`就自增，当自增到最后一个位置，这个时候数组不一定是满的，因为有可能前面的值已经被取出去了，所以还需要一个变量`count`来标志是否已经塞满，如果满了就阻塞，否则如果`addIndex`到最后一个位置，就重新置0.

对于`removeIndex`也是相同方向移除，假设最简单的情况，就是长度为5的数组，那么第一个元素放在0位置，第二个元素放在1位置，第三个元素放在2位置，此时要移除，那么第一个元素就是我们要的最先进来的元素，我们将其移除，并且`removeIndex`加一指向第二个元素。如此反复执行。

代码：

```
public class MyQueue {
    //指向的是刚入队的元素的下角标
    private int addIndex;
    //指向的是刚出队的元素后面一个元素的下角标
    private int removeIndex;
    //实际元素个数
    private int count;

    private Lock lock = new ReentrantLock();
    private Condition putCondition = lock.newCondition();
    private Condition getCondition = lock.newCondition();

    private Object[] myQueue;

    //初始化队列的长度
    public MyQueue(int initSize){
        myQueue = new Object[initSize];
    }

    //向队列的尾部放入元素
    public void put(Object object){
        lock.lock();
        while (count == myQueue.length){
            //说明队列已经满了，需要等待一下，那么放元素的线程就要阻塞住，即等待
            System.out.println(Thread.currentThread().getName()+"--队列已满，不能再塞值了，我要阻塞一会....");
            try {
                putCondition.await();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        //说明是可以放入元素的
        myQueue[addIndex++] = object;
        if(addIndex == myQueue.length){
            addIndex = 0;
        }
        //元素的数量要加一
        count++;
        System.out.println(Thread.currentThread().getName()+"成功向队列放入一个元素，当前队列元素个数为---"+count);
        System.out.println();
        getCondition.signal();
        lock.unlock();
    }

    //从队列的头部获取元素
    public Object get(){
        lock.lock();
        while (count == 0){
            //说明队列已经满了，需要等待一下，那么取元素的线程就要阻塞住，即等待
            System.out.println(Thread.currentThread().getName()+"--队列已空，不能再取值了，我要阻塞一会....");
            System.out.println();
            try {
                getCondition.await();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        int removeValue = (int) myQueue[removeIndex];
        myQueue[removeIndex++] = null;
        if (removeIndex == myQueue.length){
            removeIndex = 0;
        }
        count--;
        System.out.println(Thread.currentThread().getName()+"成功从队列获取一个元素，当前队列的元素个数为---"+count);
        putCondition.signal();
        lock.unlock();
        return removeValue;
    }

    public static void main(String[] args) {
        MyQueue myQueue = new MyQueue(5);
        new Thread(new PutThread(myQueue)).start();
        new Thread(new TakeThread(myQueue)).start();
        new Thread(new TakeThread(myQueue)).start();

    }
}

class PutThread implements Runnable{
    private MyQueue myQueue;
    public PutThread(MyQueue myQueue){
        this.myQueue = myQueue;
    }
    @Override
    public void run() {
        for(int i=0;i<10;i++){
            System.out.println(Thread.currentThread().getName()+"成功放入一个元素，元素为："+i);
            myQueue.put(i);
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

class TakeThread implements Runnable{
    private MyQueue myQueue;
    public TakeThread(MyQueue myQueue){
        this.myQueue = myQueue;
    }
    @Override
    public void run() {
        int res = (int) myQueue.get();
        System.out.println(Thread.currentThread().getName()+"成功放入一个元素，元素为："+res);
    }
}
```

## 四、Condition原理概述

我们在上面的学习中看到，对于一个线程，我们就要准备一个`Condition`对象，并且还要用可重入锁`ReentrantLock`来实现加锁：

```
public Lock lock = new ReentrantLock();
public Condition cp = lock.newCondition();
public Condition cc = lock.newCondition();
```

它的原理是什么呢？

我们看到，创建一个`condition`对象是通过`lock.newCondition()`,而这个方法实际上是会`new`出一个`ConditionObject`对象，该类是`AQS`的一个内部类.

我们知道在锁机制的实现上，`AQS`内部维护了一个同步队列，如果是独占式锁的话，所有获取锁失败的线程的尾插入到同步队列，同样的，`condition`内部也是使用同样的方式，内部维护了一个 等待队列，所有调用`condition.await`方法的线程会加入到等待队列中，并且线程状态转换为等待状态。另外注意到`ConditionObject`中有两个成员变量：

```
/** First node of condition queue. */
private transient Node firstWaiter;
/** Last node of condition queue. */
private transient Node lastWaiter;
```

这样我们就可以看出来`ConditionObject`通过持有等待队列的头尾指针来管理等待队列。主要注意的是`Node`类复用了在`AQS`中的`Node`类。所以理解了`AQS`就简单了。但是这个队列有一点不同，他是一个单向链表，而`AQS`中的同步队列式一个双向链表。

[![image](assets/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d352e6a7067.jpg)](https://camo.githubusercontent.com/944945d0d2b7e630cf061bc395ba97bcd77eb4c7/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d352e6a7067)

同时还有一点需要注意的是：我们可以多次调用`lock.newCondition()`方法创建多个`condition`对象，也就是一个`lock`可以持有多个等待队列。而在之前利用`Object`的方式实际上是指在对象`Object`对象监视器上只能拥有一个同步队列和一个等待队列，而并发包中的`Lock`拥有一个同步队列和多个等待队列。示意图如下：

[![image](assets/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d362e6a7067.jpg)](https://camo.githubusercontent.com/cb24d7da1a61d464798fdaca889bdf2011bf0372/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d362e6a7067)

如图所示，`ConditionObject`是`AQS`的内部类，因此每个`ConditionObject`能够访问到`AQS`提供的方法，相当于每个`Condition`都拥有所属同步器的引用。

好了，至此我们已经知道多次调用`lock.newCondition()`方法创建多个`condition`对象，并且实际上这个对象就是`ConditionObject`。AQS维护的同步队列是一个双向链表结构，而这个`Condition`对象维护的是一个单项链表结构。

## 五、await实现原理

当调用`condition.await()`方法后会使得当前获取`lock`的线程进入到等待队列，如果该线程能够从`await()`方法返回的话一定是该线程获取了与`condition`相关联的`lock`。`await()`方法源码为：

[![image](assets/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d372e6a7067.jpg)](https://camo.githubusercontent.com/de07c6fba0c39f3991a745a266de21c511e7fad5/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d372e6a7067)

在当前线程调用`condition.await()`方法后，会使得当前线程释放`lock`然后加入到等待队列中，直至被`signal`/`signalAll`后会使得当前线程从等待队列中移至到同步队列中去，直到获得了`lock`后才会从`await`方法返回(跳出`while`循环那就不用继续等待了呗)，或者在等待时被中断会做中断处理。

所以对于`await()`方法来说，它实现的功能为：将要等待的线程封装成节点尾插入到等待队列中，然后跟`wait`一样释放这个等待线程的锁。这些做完了之后还需要`while`循环判断是否已经在同步队列中，这个`isOnsyncQueue`是由下面说到的`signal`方法触发的，由于此时还没有`signal`所以陷在死循环中出不来，就调用`lockSupport.park`方法使他进入等待状态；当有`signal`或者有中断发生的时候，就跳出循环，继续执行，此时如果是`signal`触发的，就会进入下一个`if`,那就调用`acquireQueue`方法，这个方法在我们之前说的`AQS`中是提及的，主要思想是如果这个节点的前驱节点是`head`那么就自旋获取锁，否则可能会阻塞。这里已经从大体上说明了这个方法的整体思路，下面继续详细分析分析。

在这段代码中，我们将知道：

- 是怎样将当前线程添加到等待队列中去的？
- 释放锁的过程？
- 怎样才能从`await`方法退出？

第一个问题：是怎样将当前线程添加到等待队列中去的？

[![image](assets/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d382e6a7067.jpg)](https://camo.githubusercontent.com/eed8df0e532d2ddd842735e360f0d71d5ddbe8fb/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d382e6a7067)

这段代码就很容易理解了，将当前节点包装成`Node`，如果等待队列的`firstWaiter`为`null`的话（等待队列为空队列），则将`firstWaiter`指向当前的`Node`,否则，更新`lastWaiter`(尾节点)即可。就是通过尾插入的方式将当前线程封装的`Node`插入到等待队列中即可，同时可以看出等待队列是一个不带头结点的链式队列，之前我们学习`AQS`时知道同步队列是一个带头结点的链式队列，这是两者的一个区别。将当前节点插入到等待队列之后，会使当前线程释放`lock`，由`fullyRelease`方法实现，`fullyRelease`源码为：

[![image](assets/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d392e6a7067.jpg)](https://camo.githubusercontent.com/cc3e6accb445614017be3b44f98cf172d7d7853e/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d392e6a7067)

调用`AQS`的模板方法`release`方法释放`AQS`的同步状态(这样也说明了退出`await`方法必须是已经获得了`condition`引用（关联）的`lock`)并且唤醒在同步队列中头结点的后继节点引用的线程，如果释放成功则正常返回，若失败的话就抛出异常。到目前为止，这两段代码已经解决了前面的两个问题的答案了，还剩下第三个问题，怎样从`await`方法退出？现在回过头再来看`await`方法有这样一段逻辑：

[![image](assets/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d31302e6a7067.jpg)](https://camo.githubusercontent.com/040b4b8606595a66eb5019ac64dcd0c76a888ae1/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d31302e6a7067)

很显然，当线程第一次调用`condition.await()`方法时，会进入到这个`while()`循环中，因为判断的条件是这个线程是否在同步队列中，我们这个刚进等待队列，咋可能在同步队列。

然后通过`LockSupport.park(this)`方法使得当前线程进入等待状态，那么要想退出这个`await`方法第一个前提条件自然而然的是要先退出这个`while`循环，出口就只剩下两个地方：

1. 逻辑走到`break`退出`while`循环；
2. `while`循环中的逻辑判断为`false`。

再看代码出现第1种情况的条件是当前等待的线程被中断后代码会走到`break`退出，第二种情况是当前节点被移动到了同步队列中（即另外线程调用的`condition`的`signal`或者`signalAll`方法），`while`中逻辑判断为`false`后结束`while`循环。

总结下，就是当前线程被中断或者调用`condition.signal`/`condition.signalAll`方法当前节点移动到了同步队列后 ，这是当前线程退出`await`方法的前提条件。

当退出`while`循环后就会调用`acquireQueued(node, savedState)`，这个方法在介绍AQS的底层实现时说过了，该方法的作用是在自旋过程中线程不断尝试获取同步状态，直至成功（线程获取到`lock`）。

`await`方法示意图如下图：

[![image](assets/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d31312e6a7067.jpg)](https://camo.githubusercontent.com/9bb60285904f656753718343ae90e33f717b2abb/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d31312e6a7067)

如图，调用`condition.await`方法的线程必须是已经获得了`lock`，也就是当前线程是同步队列中的头结点。调用该方法后会使得当前线程所封装的`Node`尾插入到等待队列中。

此外，`await`也支持超时等待和不响应中断，这里不再赘述。

## 六、signal/signalAll实现原理

调用`condition`的`signal`或者`signalAll`方法可以将等待队列中等待时间最长的节点移动到同步队列中，使得该节点能够有机会获得`lock`。按照等待队列是先进先出（`FIFO`）的，所以等待队列的头节点必然会是等待时间最长的节点，也就是每次调用`condition`的`signal`方法是将头节点移动到同步队列中。

[![image](assets/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d31322e6a7067.jpg)](https://camo.githubusercontent.com/f8c87a0d142bef3ad88dedc162a74f69aa08cc81/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d31322e6a7067)

`signal`方法首先会检测当前线程是否已经获取`lock`，如果没有获取`lock`会直接抛出异常，如果获取的话再得到等待队列的头指针引用的节点，之后的操作的`doSignal`方法也是基于该节点。下面我们来看看`doSignal`方法做了些什么事情，`doSignal`方法源码为：

[![image](assets/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d31332e6a7067.jpg)](https://camo.githubusercontent.com/e8882f71a790a4405e4ad68fc0f04548935a9e14/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d31332e6a7067)

具体逻辑请看注释，真正对头节点做处理的逻辑在`transferForSignal`中，该方法源码为：

[![image](assets/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d31342e6a7067.jpg)](https://camo.githubusercontent.com/98ab4460a3566543c493554a1a1a41a61f57a187/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d31342e6a7067)

关键逻辑请看注释，这段代码主要做了两件事情1.将头结点的状态更改为`CONDITION`；2.调用`enq`方法，将该节点尾插入到同步队列中，关于`enq`方法请看`AQS`的底层实现这篇文章。现在我们可以得出结论：调用`condition`的`signal`的前提条件是当前线程已经获取了`lock`，该方法会使得等待队列中的头节点即等待时间最长的那个节点移入到同步队列，而移入到同步队列后才有机会使得等待线程被唤醒，即从`await`方法中的`LockSupport.park(this)`方法中返回，从而才有机会使得调用`await`方法的线程成功退出，此时就要回过头去再看看`await`方法的后续处理流程了。`signal`执行示意图如下图：

[![image](assets/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d31352e6a7067.jpg)](https://camo.githubusercontent.com/4a1cd0c087239870fcff2ba19e689ab19aab9b97/687474703a2f2f626c6f6768656c6c6f2e6f7572736e61696c2e636e2f74687265616431362d31352e6a7067)

`sigllAll`与`sigal`方法的区别体现在`doSignalAll`方法上，前面我们已经知道`doSignal`方法只会对等待队列的头节点进行操作，而`doSignalAll`只不过时间等待队列中的每一个节点都移入到同步队列中，即“通知”当前调用`condition.await()`方法的每一个线程。