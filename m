From: huynhphong0104@yahoo.fr (=?iso-8859-1?q?PHAM=20Huynh=20Phong?=)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: I2C driver for Linux
Message-Id: <20040521150552.26891.qmail@web25010.mail.ukl.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040515083517.5d91a699.khali@linux-fr.org>
In-Reply-To: <20040515083517.5d91a699.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I read the document in http://secure.netroedge.com/~lm78/index.html but it didn't say anything about LPT-I2C adapter that I researching. I did a sample adapter using 74LS05 chip :
 
                                  LS05 pin 14 (Vcc) o      -------   
                                                          |      |     |   
           +--+--+---------------------+--+--+------------+------+-o 1 |   
           |  |  |                     |  |  |           ==.1uF | +5V |   
 -------- [R][R][R] 3x10K       3x10K [R][R][R]   LS05    |      |     |   
 |      |  |  |  |                     |  |  |    pin 7 o-+------+-o 2 |   
 | 12 o-+--+  |  |   3|\ 4             |  |  |    (Gnd)          | GND |   
 | 17 o-+-----|--|----| >o-------------+--|--|--------------+    |     |   
 |      |     |  |    |/        8 /|9     |  |     10 /|11  +----+-o 3 |   
 | 15 o-+-----+--|--------------o< |------+--|------o< |----+    | SCL |   
 |      |        |   1|\ 2        \|         |        \|         |     |   
 |  9 o-+--------|----| >o-------------------+--------------+----+-o 4 |   
 |      |        |    |/                            6 /|5   |    | SDA |   
 | 11 o-+--------+----------------------------------o< |----+    -------   
 | 10 o-+-+                                           \|          4-pin    
 | 13 o-+-+--oGND                                               Connector  
 | 25 o-+-+        ------------------ Part List -------------------------- 
 --------          | 1 - .01 uF capacitor  | 6 - 10K 5% resistors        | 
 25-pin male D     | 1 - 4-pin connector   | 1 - 25-pin male D connector | 
 connector to PC   | 1 - 74LS05 open collector hex inverter              | 
 printer port      ------------------------------------------------------- 

I have some questions for you :
 
1/Need I REBUILD the kernel?
 
2/I found all files for I2C :(i2c-core, i2c-algo-bit, i2c-philips-par, i2c-dev,...) What must I do with these file to operate that bus. (Sorry, because I am newbie in Linux PC-port interface. But I really need this adapter for my project)
 
3/Do you know anyone that did a projet that I am doing. So I could ask for more detail?
 
I am waiting for your reply.

Jean Delvare <khali@linux-fr.org> wrote:
> My current project is "PC-based, Linux robot". I need to use I2C. I
> made an adapter with 74LS05 and I try to operate with C codes I found.
> But I could not operate this.
> 
> Could you help me? Would like to know what distribution you used.
> Could you show me step by step, hard and software for controlling I2C
> bus. Could I have you sample codes of using I2C bus?

Distribution is irrelevant, any will do.

No chance we will guide you step by step. There is plenty of
documentation and code available. Read them first. We'll help on
specific questions, but cannot do the whole work for you.

Anything you need is in our i2c and lm_sensors packages, which you can
download here:
http://secure.netroedge.com/~lm78/download.html

i2c has the lowest level drivers, while lm_sensors has
hardware-monitoring drivers and tools.

Sample kernel code can be found under lm_sensors/kernel/chip. Sample
user-space code can be found under lm_sensors/prog/dump and
lm_sensors/prog/sensors.

Good luck.

-- 
Jean Delvare
http://khali.linux-fr.org/
		
---------------------------------
Yahoo! Mail : votre e-mail personnel et gratuit qui vous suit partout !
Cr?ez votre Yahoo! Mail

Dialoguez en direct avec vos amis gr?ce ? Yahoo! Messenger !
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040521/97800eb4/attachment.html
