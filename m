From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: RFC PATCH 2.6 sysfs names: fscher: change div to ripple
Message-Id: <kcUzmTIS.1114592720.5754220.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
In-Reply-To: <o99t61p4c255uvjrhpavjejblb2r1cdts5@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> I'll do it this way, the long name was for comment :)  Any driver may
> choose to include the fanN_ppr accessor so that correct reading in
> rpm available from sysfs?  Or is that going too far again?

Drivers should only expose this interface if it matches a hardware
capability. If not, then the conversion belongs to userspace (through
libsensors or whatever the user likes).

> > Note that such patches can only be accepted in Linux 2.6 if an
> > equivalent patch is provided for libsensors.
>
> I've done that before, do you want the old name kept like last time too?

It's less sensible for the FSC chips, as there are only a couple users
out there. Also, this feature is certainly not much used (most people
have 2 pulses per revolution fans anyway). As a matter of fact,
libsensors doesn't even point to the correct names for fscher. The
fscpos driver has not been in any official Linux 2.6 kernel yet. So I
wouldn't bother with compatibility this time in the drivers themselves.

We can support both names for both chips in libsensors though, as the
additional cost is very thin (and it is such a mess already anyway...)

Thanks,
--
Jean Delvare
