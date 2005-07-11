From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 11 Jul 2005 12:48:00 +0000
Subject: [lm-sensors] Fwd: [Bug 16755] [lm_sensors] ASSIGNED: [PATCH] Bad
Message-Id: <2X8THuwz.1121078561.9480250.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200507111118.03565@totor.bouissou.net>
In-Reply-To: <200507111118.03565@totor.bouissou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Michel,

> > * Which limits exactly don't get set by the first "sensors -s"? All?
>
> As far as I noticed, only the fans RPM thresholds are concerned.

This could be easily explained then. In your configuration file there is:

>     set fan1_min 1600  
>     set fan1_div 4  
> #   set fan2_min 1500  
>     set fan2_min 900  
>     set fan2_div 8  

You set the min limit before the clock divider, while a comment at the
top of the default sensors.conf file explicitely suggests NOT to do so:

> # A 'set fan1_div' statement must go before a 'set fan1_min' statement,
> # because the driver uses the divisor in calculating the minimum.
> # Also, one should set vrm prior to using vid in any formula.

Just try swapping the lines, and then your second "sensors -s" may no
more be necessary.

> > Please provide the output of "sensors" before the first "sensors
> > -s", after the first "sensors -s" and after the second "sensors -s".
>
> I don't have them on hand, but what I can tell from memory is that after
> the 1st "sensors -s", the fans RPM thresholds are set to 5100+ something
> RPMs, which doesn't correspond at all to what I have in sensors.conf.

Aren't there by any chance multiples of what you asked for? Or
compeletely different?

> it87: Found IT8705F chip at 0x290, revision 2
> it87 1-0290: Detected broken BIOS defaults, disabling PWM interface
>
> (What does this mean, btw ?)

That Gigabyte did not properly intialize your chip for PWM operation (fan
control). If the driver would let you use the PWM interface right now,
you'd certainly burn your system because the fans have inverted
polarity (you'd stop the fan if asking it to go full speed, and
vice-versa). So for safety we had the driver disable the interface
altogether. You can reconfigure the chip and re-enable it using the
module parameter "fix_pwm_polarity". Use at your own risk though. I'd
suggest you first complain to Gigabyte and ask them for an updated BIOS
before resorting to this.

Do you have any fan control options in your BIOS setup screens?

> > Please keep in mind that this is *expected* that reported alarms won't
> > disappear immediately after changing the limits. You will always see
> > them once after that, per chip design (you must not miss once-only
> > alarms).
>
> I understand, but what I observe prove that it's the thresholds that don't
> get set correctly as first "sensors -s" call, so it's not just an alarm
> problem...

What I meant was that your test (grep -q ALARMS) is fundamentally broken.
The second "sensors -s" is likely to run on almost all systems,
whether required or not, because it would take a second call to sensors
after the caching delay (typically 1 to 2 seconds) before all remnants
alarms wear off. But hopefully we'll find a real fix anyway, so it
doesn't really matter anymore.

So please try swapping the fan_min and fan_div lines in your
configuration file and report success or failure.

I have quite a few pending patches for that driver BTW, I was just
waiting for a bigger patch to be applied before (the one moving all
driver files around).

Thanks,
--
Jean Delvare
