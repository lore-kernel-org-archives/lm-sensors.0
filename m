From: michael.hufer@freenet.de (Michael Hufer)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: fan speed for it87?? chips added
Message-Id: <200309262328.35313.michael.hufer@freenet.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309232035.29480.michael.hufer@freenet.de>
In-Reply-To: <200309232035.29480.michael.hufer@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 26 September 2003 22:40, Jean Delvare wrote:
> > I found and fixed the little problem I had with the original chip
> > initialization. I can now load the module with reset_it87=0 and
> > init=1 without messing up the settings of the power supply fan
> > from the BIOS. It was quite simple after all.
>
> I'm interested in details, can you tell us what it was?

Sure, it actually was something I introduced myself :-(. I initialized the 
fan_ctl register with  (read_value & 0x8f | 0x77) to enable the smart 
guardian feature for all 3 fans. But the power supply fan does not support 
pwm. It can only be operated in on/off mode, i.e. bit 0 must be clear. I 
switched it back to the original  (rv & 0x8f | 0x70 ) and everything is back 
to working.

> > Do you want me to send the latest diff?
>
> Sure I want.

 Here it comes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: it87_pwm-cvs.diff
Type: text/x-diff
Size: 23000 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030926/aa2e4f94/it87_pwm-cvs.bin
