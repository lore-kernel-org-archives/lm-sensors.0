From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 15 Sep 2006 21:21:49 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and minor problems
Message-Id: <450B196D.7050501@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1157458671.18988.34.camel@mhcln03>
In-Reply-To: <1157458671.18988.34.camel@mhcln03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Good news everyone, the mystery of fan5 is now uncloaked. It is short story. The
bit0 in reg 47 is write only and reads always 0.

> 1. register 47h: force AUXFANIN1 to act as a fan output
> 2. CR[0x24] bit 1. ENROM. The datasheet says a hardware reset is necessary.

Yes this is true, we have the code which detects this already in the
wmon-w83627ehf-add-pwm-support.patch

I have hacked together a patch that should solve the problem. It checks for the
ENROM as it was, later it checks bit 1 instead of bit 0 which is zero anyway.
Then all writes to reg 47 are modified so the bit0 is 1 if the ENROM is disabled.

The patch contains some schematics that is my idea how the pins are connected.
Problem is that we really never know if the pin is fan output or input because
we cannot read the bit :/

So bit1 means that output should be 1, this is not the default, so then I assume
this is not fan5 input and fan5 is disabled in driver.

If the pin is configured as output and the level in bit1 is set to 0, then bad
luck we will still think that it is input and the chip will be reprogrammed.

The schematics shows what will happen. The output of 0 will be switched to 1.
But there is no way how we can detect this. If there is really fan connected,
the side effect will be that the fan starts to spin ;) (if the polarity is set 1
on 0 off - it is mostly) The schematics shows the typical programmable I/O  pin.


All in all I think the usage as fan output for fan on/off is very very unlikely
and I have done what I could to detect if it is this way.

> P.S. Working on an updated w83627dhg patch!

Good.

Matthias, please can you check if the patch is working for you? There might be
some typos in code, please fix them if you can.

The patch should be applied on the top of:
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-w83627ehf-add-pwm-support.patch
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-unchecked-return-status-fixes-w83627ehf.patch

Thanks,
Rudolf

-------------- next part --------------
A non-text attachment was scrubbed...
Name: fan5fix.patch
Type: text/x-patch
Size: 2769 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060915/c0775b63/attachment.bin 
