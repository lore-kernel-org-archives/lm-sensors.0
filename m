From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 17 Jul 2005 17:44:00 +0000
Subject: [lm-sensors] ASUS P5WD2 Premium - Winbond 83627EHG-A
Message-Id: <20050717174320.29f23c2b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42D27327.7050402@internode.on.net>
In-Reply-To: <42D27327.7050402@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Timothy,

> Well, I built it, (had to pull the newer lm_78.c from the 2.6.13
> kernel  also, but I eventually got it to compile ok, and got a .ko
> file and  plonked it into:
>  /lib/modules/2.6.12.1-1390_FC4smp/kernel/drivers/i2c/chips/
> I ran a depmod, and rebooted....
> 
> It all appeared to load up ok, and showed up in the /proc/modules 
> listing ... but as soon as I loaded up GkRellm, my PC locked. :(
> I searched the /var/log/messages but couldnt find any errors or 
> anything... If its not too much to ask, can you give me any
> hints/tips to debug it ?

Let's try. First, can you tell us why you needed to backport lm78.c? I
don't get it. The w83627ehf driver is standalone and certainly doesn't
need lm78 is any way.

Second, please don't use gkrellm for testing, as this program is not
supported by us. Please use the files in /sys/bus/i2c/devices directly,
using "cat" and "echo". At least we will know which action precisely did
cause the problem.

Third, please enable as much i2c debugging as possible. This can be done
in the I2C menu with make menuconfig. also Add
#define DEBUG 1
at the top of the w83627ehf.c file.

This should let us gather some information.

Also, if you had to change something to the w83627ehf file when
backporting it, please tell us what exactly you did. If you could share
the exact file you are using, it will help us help you.

-- 
Jean Delvare
