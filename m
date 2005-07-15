From: tfindlay@internode.on.net (Timothy Findlay)
Date: Fri, 15 Jul 2005 18:14:32 +0000
Subject: [lm-sensors] ASUS P5WD2 Premium - Winbond 83627EHG-A
Message-Id: <42D7E1BA.3060301@internode.on.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <42D27327.7050402@internode.on.net>
In-Reply-To: <42D27327.7050402@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,


Jean Delvare wrote:

>Hi Timothy,
>I doubt that. The w83627ehf driver is new in 2.6.13-rc1.
>  
>
Correct, I'll be chasing down a new kernel by the looks of it .... I'm 
hanging for the 2.6.13 to finally get released under "yum" ... I noticed 
and -rc3 patch is now available, and I dont mind whipp'n it down and 
having a go if I have to, but I didnt want to run "obscure" kernel 
versions or break too far away from the base updates (if possible).

>This is 627, not 267.
>  
>
whoops! sorry about the typo ..... I'll be more careful in future ....

>>I really didnt want to start customising my
>>kernel  though! Someone on fedoraforum.org suggested I try the
>>w83627hf driver  which I did as follows:
>>
>>[root@localhost rc.d]# modprobe w83627hf
>>FATAL: Error inserting w83627hf 
>>(/lib/modules/2.6.12-1.1390_FC4smp/kernel/drivers/i2c/chips/w83627hf.ko):
>>No such device
>>    
>>
>
>There are two different drivers: the original w83627hf driver supports
>the W83627HF, W83627THF, W83637HF and W83697HF chips. The new w83627ehf
>driver (partly) supports the W83627EHF chip, and possibly the W83627EHG
>as well. All these drivers and chips have very similar names so you have
>to pay attention to which driver supports exactly what chips.
>  
>
Thanks for that, I'll abandon the 83627hf driver idea ....

>The driver you need is really the new w83627ehf driver. You will have to
>either upgrade your kernel to 2.6.13-rc1 or later, or backport the
>w83627ehf driver to the kernel you are using (we can help you do so, it
>should be easy.) The least intrusive approach would be to compile the
>backported driver outside of the kernel tree. Let us know if you want to
>do that.
>  
>
Yep, I'll have a go at backporting then, mind you, the last time I 
touched any C code was in a "Hello World" program! haha!  ... So I'll 
start reading around how to do this, of course any hints/tips would be 
appreciated (though I recognise your time is important, and I dont 
expect to be hand-fed).

I've now downloaded a 22-June-05 build of "w83627ehf.c" (by Greg) from 
GIT (which I dont really get understand)... though not sure how/where to 
complile it yet ... (I'm just wing'n it! haha)

>>Anyway, here's the long-winded output from sensors-detect:
>>[root@localhost ~]# ./sensors-detect
>>(...)
>>Probing for `Winbond W83627EHF Super IO Sensors'
>>  Success... found at address 0x0290
>>    
>>
>This means that your chip has an ID similar to those of the W83627EHF.
>I'd like to know the exact 16-bit ID though, in case we need to
>differenciate between both chips in the driver. Could you possibly get
>isadump from lm_sensors 2.9.1 or CVS, and run the following command:
>
>isadump -y -k 0x87,0x87 0x2e 0x2f 0x0b
>
>This should give us the exact ID.
>  
>

In the mean time, here's the "isadump" you asked for ... I built this 
from the CVS version.

[root@localhost dump]# ./isadump -y -k 0x87,0x87 0x2e 0x2f 0x0b
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff 0b ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 88 63 ff 00 44 00 00 ff 50 04 00 00 9a 21 00 ff
30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: 02 90 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: c1 17 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[root@localhost dump]#  

Hope that helps! If theres anything else you'd like (photo of the chip 
?) just sing out!

Tim.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050716/3740e1f4/attachment.html
