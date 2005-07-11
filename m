From: michel@bouissou.net (Michel Bouissou)
Date: Mon, 11 Jul 2005 12:57:30 +0000
Subject: [lm-sensors] Fwd: [Bug 16755] [lm_sensors] ASSIGNED: [PATCH] Bad
Message-Id: <200507111257.12713@totor.bouissou.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200507111118.03565@totor.bouissou.net>
In-Reply-To: <200507111118.03565@totor.bouissou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Le Lundi 11 Juillet 2005 12:42, Jean Delvare a ?crit :
>
> This could be easily explained then. In your configuration file there is:
> >     set fan1_min 1600
> >     set fan1_div 4
> > #   set fan2_min 1500
> >     set fan2_min 900
> >     set fan2_div 8
>
> You set the min limit before the clock divider, while a comment at the
> top of the default sensors.conf file explicitely suggests NOT to do so:

OOOops !!!

I usually reads the docs thoroughly (yes I do ;-) but I had missed this one... 
I'm not familar with the order of parameters being of any importance in 
config files...

> Just try swapping the lines, and then your second "sensors -s" may no
> more be necessary.

I'll check this.

> > it87: Found IT8705F chip at 0x290, revision 2
> > it87 1-0290: Detected broken BIOS defaults, disabling PWM interface
> >
> > (What does this mean, btw ?)
>
> That Gigabyte did not properly intialize your chip for PWM operation (fan
> control). If the driver would let you use the PWM interface right now,
> you'd certainly burn your system because the fans have inverted
> polarity (you'd stop the fan if asking it to go full speed, and
> vice-versa). So for safety we had the driver disable the interface
> altogether. You can reconfigure the chip and re-enable it using the
> module parameter "fix_pwm_polarity". Use at your own risk though. I'd
> suggest you first complain to Gigabyte and ask them for an updated BIOS
> before resorting to this.
>
> Do you have any fan control options in your BIOS setup screens?

No. AFAIK, my board is capable of reporting the fans speeds, but doesn't have 
active control over them. That's probably why these BIOS defaults are 
"broken".

My CPU fan is controlled via a manual potentiometer, and my box fans are under 
control of my power supply (Antec) that reports their speed to the MB thru a 
specific cable.

Thanks for the help !

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
