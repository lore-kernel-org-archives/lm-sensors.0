From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: lm_sensors
Message-Id: <iykE5dz9.1115976073.9820140.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
In-Reply-To: <OF0351D9C0.5474FFE2-ON87256C2B.005D8AC8@boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Dmitry,

> > Unfortunately, this could be an indication that PWM is not wired on this
> > board. the two Gigabyte boards using the it87 driver I have access to
> > and that have their PWM lines wired do have the option in BIOS.
>
> Does it mean, I can do nothing if PWM lines are not wired?

"Nothing" is a bit exagerated. This means that you cannot use your
IT8712F chip for fan speed control. There are other solutions to lower
the speed of your fans:
1* Add a hardware fan speed controller between the motherboard fan header
and the fan.
2* Change the fan for a lower speed model.
3* Change the fan for a thermoregulated model.

Obviously these solutions are more expensive and less flexible than what
you could have done with the IT8712F chip, but it now seems like these
are the only options left. You'll have to read some specialized sites
about low-noise computing and do some hardware hacking.

> Now to become sure about the wiring of PWM lines?

Your experiments seem to prove that they are not wired. One way to
confirm this would be to contact the Gygabyte technical support and ask
them:
http://www.giga-byte.com/TechSupport/ServiceCenter.htm

--
Jean Delvare
