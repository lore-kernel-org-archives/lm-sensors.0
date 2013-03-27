From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 27 Mar 2013 07:09:36 +0000
Subject: Re: [lm-sensors] MSI MS-9821 Sensor Help
Message-Id: <20130327080936.134841f7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU173-W922408091AE1E1E4EF4B1D1D00@phx.gbl>
In-Reply-To: <BLU173-W922408091AE1E1E4EF4B1D1D00@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bryan,

Please keep including the list in the discussion, I'm adding it back.
Other users may want to help, and the list is also archived for future
readers.

On Tue, 26 Mar 2013 17:26:23 -0500, Bryan Guidroz wrote:
> Thanks for the quick reply.  But, my bad... it's a MSI 9832... oops.
> These may be stupid questions, but I'm a little confused.
> 
> Once I figure this out, if I create my own conf file like you described (/etc/sensors.d/MSI-MS-9832.conf,) lm_sensors will ignore whatever may apply to my system that's already in in /etc/sensors3.conf?
> Or would my boards conf file (that I create) only include those values that are excluded from /etc/sensors3.conf?
> Or am I looking at this incorrectly or does it not matter?

Both would work. libsensors will read both /etc/sensors3.conf and your
own board configuration file, and will combine them. So it doesn't hurt
to repeat configuration statements, but it will work fine too if you
don't.

> (...)
> After quickly looking through your article, it sounds like the only way I'd be able to get these labels/values right is by comparing them to the BIOS.  Correct?
> (I plan to read/understand your article better in the coming days)

This is not the only way, but this is a way which almost all users can
use. Other ways are: finding detailed technical data about the board,
but this is very difficult to obtain from vendors; comparing with a
vendor-provided Windows monitoring tool, but this requires running
Windows on the same system; obtaining lm-sensors configuration files
from the vendor directly, but I think only Tyan is actually doing that;
tracing the wires and measuring the resistor values on-board, but
almost no user has the hardware and skills to do that.

> (and I was hoping google would find me someone that's run into this with the same system/Fintek sensors that would make this quick and easy...  oh well)

Actually if you find a configuration file for a board from the same
vendor, targeted at the same CPU vendor and family, and using the same
brand and model of hardware monitoring chip, there is a non-zero chance
that part of the configuration file would work for you too. But this
isn't as reliable as doing the work yourself, and if you get it wrong
(for example swapping labels of some inputs) it might be impossible to
detect afterward. So I would recommend looking at other configuration
files only if you can't get things right with BIOS value comparisons.

> My objective here is to get monitorix reporting most of these values as accurately as possible.
> Monitorix has been very helpful and I'm determined to get this working on this system too.

I didn't know about monitorix. Looks interesting and possibly a good
replacement for sensord, which starts showing its age and nobody seems
to be interested in developing further.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
