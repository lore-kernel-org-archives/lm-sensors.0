From: tfindlay@internode.on.net (Timothy Findlay)
Date: Wed, 20 Jul 2005 14:17:35 +0000
Subject: [lm-sensors] ASUS P5WD2 Premium - Winbond 83627EHG-A
Message-Id: <42DE4186.9070702@internode.on.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <42D27327.7050402@internode.on.net>
In-Reply-To: <42D27327.7050402@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:

>You really mean lm75.h then. I now remember the w83627ehf driver needs
>it. Should be OK though.
>  
>
Your correct as always, my apologies for such sloopy information, it 
seems the only time I get to sit and tinker with this is  past midnight, 
by which stage I'm half asleep. :(

>I think I see what happens here. We had a recent change in the sysfs
>callback function parameters. You probably need to revert them for your
>older kernel. Search for callback functions with the following
>parameters:
>
>static ssize_t
>show_reg_fan_##offset(struct device *dev, struct device_attribute *attr,
>                      char *buf)
>
>And drop the "struct device_attribute *attr" one, resulting in:
>
>static ssize_t
>show_reg_fan_##offset(struct device *dev, char *buf)
>
>Do that for all warnings you had when compiling, and hopefully the driver
>should then work.
>  
>
HOORAY! .. Your right-on! I tried searching my kernel source for 
definitions/prototypes for these functions, but couldnt find a thing, so 
I just hacked away at the source, removing all function parameters with 
offending struct, and then tried compiling it... no errors! :)

>And a note for next time... Never assume that warnings are OK when
>porting a driver. Drivers usually compile without any warning (at least
>all i2c and hardware monitoring drivers do), so new warnings are always
>the sign that something else changed and the driver code needs to be
>updated to match that change. That was the case here.
>  
>
Very true, alot of open source packages I build usually have warnings of 
some type, over time I get lazy and stop checking or trying to fix them. 
After the changes mentioned, the module compiled perfect. I'll attach a 
session log showing what I did, and I'll attach my butchered up module 
code (dont get mad! I tried to be careful with it!).

>Oh, and please CC the sensors list on replies.
>  
>
Certainly, as mentioned initially, I'm usually half asleep when I've 
been working on this.

My sincere thanks to you (and greg) for your help getting this working, 
I'm absolutely elated. I've fired up my fravorite gkRellm, and its 
picked up all the sensors perfectly. I did notice it didnt pick up the 
voltages (not that I'm all that interested in voltage), if I only 
understood the code a little better (and the spec provided by Winbond), 
I'd be happy to keep working on the driver to add anything else in. But 
I'm not sure I understand hex adressing that well, and I'd probably be a 
hinderance more than a help. Having said that, if theres anything I can 
do to help, just let me know. (sorry I dont have a spare P5WD2 to send 
you I'm afraid)

Again, sincere thanks,
Tim.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: build_log2.log
Type: text/x-log
Size: 4585 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050720/f84d72ab/build_log2-0001.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf.c
Type: text/x-csrc
Size: 23532 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050720/f84d72ab/w83627ehf-0001.bin
