From: timm@inbase.com (Wolfgang Timm)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: Compiling Errors
Message-Id: <5.1.0.14.2.20030207114346.00a258e0@195.245.9.193>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

i'm trying ls_sensors to watch our Webserver.
i2c compiles fine.

At the compile time for lm_sensors i got this:
gcc  -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. 
-Ikernel/include -I/usr/local/include -I/usr/src/linux/include   -O2   -c 
kernel/chips/lm92.c -o kernel/chips/lm92.o
kernel/chips/lm92.c:96: warning: parameter names (without types) in 
function declaration
kernel/chips/lm92.c: In function `lm92_temp':
kernel/chips/lm92.c:180: `mutex' undeclared (first use in this function)
kernel/chips/lm92.c:180: (Each undeclared identifier is reported only once
kernel/chips/lm92.c:180: for each function it appears in.)
kernel/chips/lm92.c: In function `lm92_alarms':
kernel/chips/lm92.c:207: `mutex' undeclared (first use in this function)
kernel/chips/lm92.c: In function `lm92_detect':
kernel/chips/lm92.c:280: `mutex' undeclared (first use in this function)
kernel/chips/lm92.c:298: `THIS_MODULE' undeclared (first use in this function)
kernel/chips/lm92.c: At top level:
kernel/chips/lm92.c:415: warning: parameter names (without types) in 
function declaration
kernel/chips/lm92.c:415: warning: data definition has no type or storage class
kernel/chips/lm92.c:416: warning: parameter names (without types) in 
function declaration
kernel/chips/lm92.c:416: warning: data definition has no type or storage class
make: *** [kernel/chips/lm92.o] Error 1

Whats this mean??
Thanks for your answer
timm

---------------------------------;-)
inbase
- Wolfgang Timm -
    3W:  http://www.inbase.de, http://www.mycms.de
