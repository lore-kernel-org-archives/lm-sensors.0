From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Ticket #: 1368 - could lm_sensors have affected my ability to
Message-Id: <20030827122329.0e6cdaec.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43d6eukbfw.fsf@pup.phpwebhosting.com>
In-Reply-To: <43d6eukbfw.fsf@pup.phpwebhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > It's possible that lm_sensors is reponsible for that, because we
> > have been writing the driver for you chipset without a datasheet
> > (blame Asus for that).  Maybe using the init=0 parameter for the
> > w83781d module will help (unless the value that might have been
> > broken by our initialization is not reset at boot time, in which
> > case you're doomed).
> 
> Then my a7v333 motherbord is doomed, as I can't even power off during
> the first phase of boot, when the bios does its tests.  That's pretty
> disappointing!
> 
> If anyone knows about how to undo the damage, for example by resetting
> the chips to their pre-lm_sensors state, please let me know.

Two options:

1* Update your BIOS. It may reset some parameter into its original
state. Even "Load setup defaults" in your BIOS configuration screen
could help, who knows.

2* Find someone else with the same motherboard, who is running Linux and
does not have the problem you do have. Get a dump of the chipset status
using i2cdump. Then set, byte by byte, the same values into your chipset
(well, for registers you can write to) using i2cset. This is dangerous
and may not work, so I take no liability for anyting that could happen.

> Also, can anyone suggest what I could possibly say to ASUS when asking
> them for help with the problem?

Whatever you say, they'll pretend it's your fault and that Linux isn't
supported and blah blah blah. However, if you insist on the fact that a
datasheet would help us preventing this kind of incident, and if you can
convince them to do so, it'd be great.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
