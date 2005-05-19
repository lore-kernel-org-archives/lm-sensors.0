From: ajohnson@lastaccess.com (Andrew D. Johnson)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: PC87366 with the net4801
Message-Id: <1088155613.5t0ycdbqps00@lastaccess.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As a quick recap for those viewing this in the soekris-tech list,
I'm trying to get lm sensors (temp and voltage monitoring)
working on a net4801 under linux, using the pc87360 driver that
Jean has developed. (Please correct me if i'm wrong, Jean, I
assume you've developed this driver). Here's the lm sensors
website, for those unfamiliar with the software:
http://www.lm-sensors.nu/

There's a question further down in this email that I was hoping
someone from Soekris might be able to answer. Any other insight
would also be appreciated. Thanks.

On Fri 25 Jun 2004 03:07:57 AM CDT Jean Delvare <khali@linux-fr.org> said:
> >> Most voltage channels seem to be disabled. You should try
> >> passing init=2 or init=3 to the module as you load it, so
> >> that it forcibly enables them. Maybe you'll get readings
> >> after that.
> >
> >I seem to get the same results with init=2 or init=3.
> Strange. I'd have expected changes, such as voltage readings to
> come up, or Vcore limits to show.  How did you pass the
> parameter?

I've attached a log (output.txt) of the exact command sequence
and output.

> OK... I would like you to run (in an empty directory) the
> attached script on that machine. I'll dump the whole chip
> contents (all channels on all devices) and generate a tarball
> from all individual files.
>
> Please do that *before* you force the chip to use an internal
> voltage reference. And possibly a second time *after* doing so
> if you feel like it.

Ok, I've attached dumps for both before and after forcing
internal vref.

> Let me know if you have any change after switching to internal
> reference.

See output.txt for more command output from this. I
don't really see any change in the readings. There is one thing
that I found noteworthy, however. Even after forcing internal
vref using the commands you suggested, I still get the following
dmesg output:

soekris1# dmesg -c
pc87360.o version 2.8.8-CVS (2004xxxx)
pc87360.o: device 0x09 not activated
Using external reference voltage

> BTW, do you know whether your board is using thermistor-based
> or thermal-diode-based temperature measurements?

Unfortunately, I'm not certain. I'll CC the soekris-tech mailing
list in on this, which I discovered only recently. Someone there
from Soekris might be listening and will perhaps be able to shed
a little bit more light on this.

--
Andrew D. Johnson
PGP Fingerprint: 77BD 80B1 4918 1D98 9EBF 2E62 073B 9B31 A1DC 41F4
KeyID: 0xA1DC41F4
-------------- next part --------------
A non-text attachment was scrubbed...
Name: output.txt.gz
Type: application/x-tar
Size: 727 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040625/fa6b7753/output.txt.tar
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pc87366-dump-after-internal-vref.tar.gz
Type: application/x-tar
Size: 672 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040625/fa6b7753/pc87366-dump-after-internal-vref.tar.tar
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pc87366-dump-before-internal-vref.tar.gz
Type: application/x-tar
Size: 679 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040625/fa6b7753/pc87366-dump-before-internal-vref.tar.tar
