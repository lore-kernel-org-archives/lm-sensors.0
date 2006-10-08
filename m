From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 08 Oct 2006 09:17:08 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <20061008111708.9e9d7316.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Morgen Michael,

> first of all thanks for letting me try the driver!
> Unfortunately, I can't modprobe the driver:
> [root at matrix PC87427]# make
>   CC [M]  /root/software/PC87427/pc87427.o
>   Building modules, stage 2.
>   MODPOST
>   CC      /root/software/PC87427/pc87427.mod.o
>   LD [M]  /root/software/PC87427/pc87427.ko
> [root at matrix PC87427]# make modules_install
> cp pc87427.ko /lib/modules/2.6.16-xen/kernel/drivers/hwmon
> depmod -a -F /lib/modules/2.6.16-xen/build/System.map 2.6.16-xen
> [root at matrix PC87427]# modprobe -v pc87427
> insmod /lib/modules/2.6.16-xen/kernel/drivers/hwmon/pc87427.ko
> FATAL: Error inserting pc87427
> (/lib/modules/2.6.16-xen/kernel/drivers/hwmon/pc87427.ko): Invalid
> module format
> 
> Have you got an idea what's going wrong?

I'm having similar problem with another tester for another driver
off-list. It's usually a matter of adding some flag at compilation
time. Any hint in the logs (dmesg or /var/log/messages)? Is this a
64-bit system?

-- 
Jean Delvare

