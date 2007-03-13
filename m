From: hjk@linutronix.de (=?iso-8859-15?q?Hans-J=FCrgen_Koch?=)
Date: Tue, 13 Mar 2007 13:25:10 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <200703131425.11843.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Montag, 12. M?rz 2007 17:49 schrieb Jean Delvare:

>
> Notice that the counttime is also only expressed as powers of 2.
>
> > All right. New version will follow soon.
>
> Great, thanks.

Here it is: The driver creates only standard sysfs files now. I left the 
module insmod parameters in place, though. This allows users to initialize 
ALL registers if their BIOS doesn't do so. I hope you do not object.

sysfs files follow the specification as close as possible. I used 
pwm1_enable=3 for "fan off". There is no other possibility to switch the fan 
off, setting pwm1_enable to 1 and fan1_target to 0 doesn't turn it off 
completely.

You mentioned problems compiling my code. Sorry, I can't reproduce this here. 
It compiles without any warnings. If you still notice problems, please tell 
me.

Signed-off-by: Hans J. Koch <hjk at linutronix.de>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: max6650.patch
Type: text/x-diff
Size: 24520 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070313/084653de/attachment.bin 
