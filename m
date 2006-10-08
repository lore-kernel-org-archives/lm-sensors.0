From: kress@hal.saar.de (Michael Kress)
Date: Sun, 08 Oct 2006 09:14:48 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <4528C188.9070404@hal.saar.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare schrieb:
> Here you go. I attached the driver itself, and a Makefile to compile it
> off-tree. Just type "make modules" to build the driver and "make
> modules_install" to install it. Then "modprobe pc87427" should work.
> Let me know if not.
>
> Once the driver is loaded you should have fan interface files
>   
Hi Jean,

first of all thanks for letting me try the driver!
Unfortunately, I can't modprobe the driver:
[root at matrix PC87427]# make
  CC [M]  /root/software/PC87427/pc87427.o
  Building modules, stage 2.
  MODPOST
  CC      /root/software/PC87427/pc87427.mod.o
  LD [M]  /root/software/PC87427/pc87427.ko
[root at matrix PC87427]# make modules_install
cp pc87427.ko /lib/modules/2.6.16-xen/kernel/drivers/hwmon
depmod -a -F /lib/modules/2.6.16-xen/build/System.map 2.6.16-xen
[root at matrix PC87427]# modprobe -v pc87427
insmod /lib/modules/2.6.16-xen/kernel/drivers/hwmon/pc87427.ko
FATAL: Error inserting pc87427
(/lib/modules/2.6.16-xen/kernel/drivers/hwmon/pc87427.ko): Invalid
module format

Have you got an idea what's going wrong?
TIA - Michael

-- 
Michael Kress, kress at hal.saar.de
http://www.michael-kress.de / http://kress.net
P E N G U I N S   A R E   C O O L


