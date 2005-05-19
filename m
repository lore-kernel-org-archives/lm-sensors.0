From: bjorn@mork.no (=?iso-8859-1?q?Bj=F8rn_Mork?=)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: "probe" module param broken for it87 in Linux 2.6.6
Message-Id: <hvk6zhzp6c.fsf@rasputin.ws.nextra.no>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg KH <greg@kroah.com> writes:
> On Tue, May 11, 2004 at 01:13:40AM +0200, Bj?rn Mork wrote:
>
>> BTW, I once wrote some SuperIO probing code for the IT8712F so that
>> users wouldn't need to know the register address on their particular
>> motherboard.  This code is included in the current lm_sensors version
>> of the driver.  Any chance of getting this into the kernel version too?
>
> Care to port it to the 2.6 driver and send me a patch?  Make sure to cc:
> the sensors mailing list so the other developers can see it too.

Sure.  Not much porting though.  The code was originally based on the
similar SuperIO detection in w83627hf.c and this doesn't seem to have
changed much in 2.6.  Not sure about the style, or that this is the
correct way to do things, but at least it's the way it has been done
before ;-)

There were some concerns about detecting the IT8712F since it has a
non-standard config mode exit sequence.  Theoretically we risk putting
another SuperIO chip in config mode.  Therefore, just in case, the
"standard" exit command has been added to superio_exit(). This does
not seem to matter to the IT8712F.  The code as it is has been in the
lm_sensors package for some time.


Bj?rn

-------------- next part --------------
A non-text attachment was scrubbed...
Name: it87-2.6.6.patch
Type: text/x-patch
Size: 2573 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040512/648bec2f/it87-2.6.6.bin
