From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 06 Oct 2005 12:20:14 +0000
Subject: [lm-sensors] Myson MTP008 driver ported to 2.6 kernel
Message-Id: <47L0URBU.1128593387.8874620.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051004125511.GI7154@kira.glasswings.com.au>
In-Reply-To: <20051004125511.GI7154@kira.glasswings.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi again Andrew,

> > If we go that way, then you do not have to handle the conditions in each
> > callback function. Simply do not create the sysfs files which do not
> > match the current setup (that is, create in4* or temp2*, but not both
> > sets.)
>
> I agree, but according to Documentation/hwmon/sysfs-interface the
> temp[1-3]_type file is Read/Write which suggests that either the driver
> needs to support writes and the changes to the chip configuration that
> implies, or the documentation needs to be changed.

It is considered OK to let the user change the thermal sensor type,
because it might be needed even if the BIOS properly configures the
chip. At least two cases come to mind:
* Different CPUs may embed different sensor types.
* Some mother boards have headers for additional thermal sensors,
different users may use different sensor types.

You could object that this doesn't need to be changeable at runtime and
could be a module parameter instead, and you'd be right. There are
historical reasons for this choice, changing it now would break
compatibility.

So it is OK to have tempN_type read/write, as long as writing only allows
a sensor type change and not a function change.

Thanks,
--
Jean Delvare
