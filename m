From: jamagallon@able.es (J.A. Magallon)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: i2c: lost sensors with 2.6.10(-mm1)
Message-Id: <1105148752l.9029l.0l@werewolf.able.es>
List-Id: <lm-sensors.vger.kernel.org>
References: <1105058791l.5580l.0l@werewolf.able.es>
	<41DE5B99.1040602@linux-fr.org>
In-Reply-To: <41DE5B99.1040602@linux-fr.org> (from khali@linux-fr.org on Fri
	Jan  7 10:51:21 2005)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "J.A. Magallon" <jamagallon@able.es>, LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>, LM Sensors <sensors@stimpy.netroedge.com>


On 2005.01.07, Jean Delvare wrote:
> J.A. Magallon wrote:
> 
> > I have lost my sensors info with 2.6.10, in particular -mm1.
> > They work fine with 2.6.9-mm1 (current state of the box, booted on
> > 2.6.9 or 10, no other difference).
>  > (...)
> > I have noticed different contents in /sys:
> > under 2.6.9:
> > /sys/devices/platform/i2c-1:
> > /sys/devices/platform/i2c-1/1-0290:
> > /sys/devices/platform/i2c-1/1-0290/power:
> > /sys/devices/platform/i2c-1/power:
> > 
> > under 2.6.10:
> > /sys/devices/platform/i2c-1:
> > /sys/devices/platform/i2c-1/power:
> > 
> > So some /sys nodes are missing !!!
> > (the isa bus)
> 
> This basically means that the i2c client was not registered.
> 
> > Debug output from 2.6.10-mm1:
> > (...)
> > Jan  7 01:33:11 werewolf kernel: i2c-core: driver w83627hf registered.
> > Jan  7 01:33:11 werewolf kernel: i2c_adapter i2c-1: found normal isa entry for adapter 9191, addr 0290
> 
> However, this suggests that the driver loaded properly and the base 
> address was correctly read from Super-I/O space. This would mean that 
> the problem happened later, in w83627hf_detect(). The most likely reason 
> for this would be if the region request failed (unfortunately we have no 
> message, not even debug, if this happens).
> 
> > Some ideas ?
> 
> Three things to try, in order:
> 
> 1* Compare /proc/ioports in 2.6.9-mm1 and 2.6.10-mm1. I suspect that the 
> 0x290-0x297 range is held by some device in 2.6.10-mm1.
> 

Disabling "Plug and Play ACPI support" freed the ioport range and sensors
worked again.

Thanks for the info.

Is this a problem/conflict ? Or I can't use PnP-ACPI (if I ever guess
what is it useful for) and sensors at the same time ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-jam2 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-2mdk)) #1

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050108/bb367b8d/attachment.bin
