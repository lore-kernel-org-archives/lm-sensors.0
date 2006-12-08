From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 08 Dec 2006 19:52:09 +0000
Subject: [lm-sensors] fancontrol with IT8705F
Message-Id: <20061208205209.cb80b161.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4576F2F4.9050200@gmx.de>
In-Reply-To: <4576F2F4.9050200@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Tobias,

On Thu, 7 Dec 2006 14:10:47 +0100, Tobias Fritz wrote:
> Cool, this helps! If I set it to e.g. 3MHz it seems to change pretty smoothly 
> over the whole range. I have to test this a little more but I don't know when 
> I'll find time for it. 

Great. So I created a patch which will let the user change the PWM
frequency through a device sysfs file. The patch is against 2.6.18 as
this is what the machine I had for testing was running. The it87 driver
was significantly modified since then so this patch will need to be
rewritten for 2.6.20, I'll do that later.

If you give a try to this patch, note that the frequency you control
through pwm1_freq is the real PWM base frequency, while the values I
gave you before were internal frequencies, which are 128 times greater.
In other words, if "3 MHz" was working for you, you'll need to write
23437 (3000000/128) to pwm1_freq.

> If I find a value that suits me, how can I set this permanently?

You can't, as the IT8705F chip will lose its settings on power-off and
most probably on reboot as well. So you'll have to make sure the
frequency is set again at boot time. Without the patch, this can be
done by calling isaset with the right parameters in one of your system
boot scripts. With the patch, echo the wanted frequency
to /sys/devices/platform/i2c-9191/9191-0290/pwm1_freq instead (make
sure the script is called after the it87 driver is loaded.)

-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: hwmon-it87-pwm-freq.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061208/b2353c17/attachment.pl 
