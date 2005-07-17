From: tfindlay@internode.on.net (Timothy Findlay)
Date: Sun, 17 Jul 2005 15:22:37 +0000
Subject: [lm-sensors] ASUS P5WD2 Premium - Winbond 83627EHG-A
Message-Id: <42DA5C68.60202@internode.on.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <42D27327.7050402@internode.on.net>
In-Reply-To: <42D27327.7050402@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Well, I built it, (had to pull the newer lm_78.c from the 2.6.13 kernel 
also, but I eventually got it to compile ok, and got a .ko file and 
plonked it into:
 /lib/modules/2.6.12.1-1390_FC4smp/kernel/drivers/i2c/chips/
I ran a depmod, and rebooted....

It all appeared to load up ok, and showed up in the /proc/modules 
listing ... but as soon as I loaded up GkRellm, my PC locked. :(
I searched the /var/log/messages but couldnt find any errors or 
anything... If its not too much to ask, can you give me any hints/tips 
to debug it ?

Regards,
Tim.

Jean Delvare wrote:

>Hi Timothy,
>
>  
>
>>Yep, I'll have a go at backporting then, mind you, the last time I 
>>touched any C code was in a "Hello World" program! haha!  ... So I'll 
>>start reading around how to do this, of course any hints/tips would 
>>be appreciated (though I recognise your time is important, and I dont 
>>expect to be hand-fed).
>>
>>I've now downloaded a 22-June-05 build of "w83627ehf.c" (by Greg)
>>from GIT (which I dont really get understand)... though not sure
>>how/where to complile it yet ... (I'm just wing'n it! haha)
>>    
>>
>
>>From there, create a Makefile with this line:
>
>obj-m	+= w83627ehf.o
>
>Then run:
>
>make -C /usr/src/linux SUBDIRS=$PWD modules
>
>(replace /usr/src/linux with the path to your real kernel source tree).
>
>That should do it. If there are warnings or errors, you'll have to
>figure out how to fix them (or ask us). Then modprobe the new driver and
>see how it goes.
>
>  
>
>>>This should give us the exact ID.
>>>      
>>>
>>In the mean time, here's the "isadump" you asked for ... I built this 
>>from the CVS version.
>>
>>[root@localhost dump]# ./isadump -y -k 0x87,0x87 0x2e 0x2f 0x0b
>>     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>>00: ff ff ff ff ff ff ff 0b ff ff ff ff ff ff ff ff
>>10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>20: 88 63 ff 00 44 00 00 ff 50 04 00 00 9a 21 00 ff
>>    
>>
>
>For the records, your chip has ID 0x8863, which matches the W83627EHF
>datasheet (it says 0x886x), but oddly enough not the ID of the only
>W83627EHF chip we saw so far (which had 0x8853). I have good hope that
>both chips will be compatible as far as hardware monitoring is
>concerned.
>
>Oh, and remember that my w83627ehf driver is not finished, it only
>implements half of the features the chip has, due to a lack of time and
>hardware to test my work. Someone else is working on improving it. Or I
>might do if someone considers a hardware donation.
>  
>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050717/869cd82c/attachment.html
