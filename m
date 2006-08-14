From: juergh@gmail.com (Juerg Haefliger)
Date: Mon, 14 Aug 2006 22:19:55 +0000
Subject: [lm-sensors] [PATCH 2/2 RESEND 2] hwmon: add vt1211
Message-Id: <191fb4ca0608141519s203231ebmb3314c8ca36eb4de@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814143719.c2b61ce7.khali@linux-fr.org>
In-Reply-To: <20060814143719.c2b61ce7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > +Authors: Juerg Haefliger <juergh at gmail.com>
> > +         Lars Ekman <emil71se at yahoo.com>
> > +         Mark D. Studebaker <mdsxyz123 at yahoo.com>
>
> Drop Mark, or add a statement "based on a driver written my Mark..."

Will do.


> > +Note that even though in6 is implemented in the driver, it is reserved as per
> > +the datasheet and doesn't return a meaningful value (always 0).
>
> I take it as a strong indication that it doesn't exist at all, and I'd
> drop it.

Makes sense. I just kept it around for legacy reasons.


> > +Diode Type      Offset   Gain
> > +----------      ------   ----
> > +Intel CPU       88.638   0.9528
> > +VIA C3 Ezra     83.869   0.9528
> > +VIA C3 Ezra-T   73.869   0.9528
>
> Odd, in sensors.conf we have a different fomula, supposedly for Intel
> CPUs: offset 65, gain 0.9686. It presumably comes from an older BIOS
> porting guide? Might be worth documenting.

Will do.


> Not a word on thermistor-based measurements?

Hmm... Let me check the BIOS porting guide. I think there's something
in there, if yes, I'll add it.


> > +pwm1_enable   pwm2_enable   |   pwm1        pwm2
> > +----------------------------------------------------
> > +0             0             |   off         off
> > +0             1             |   off         manual
> > +1             0             |   manual      off
> > +1             1             |   manual      manual
> > +2             0             |   automatic   off
> > +0             2             |   off         automatic
> > +2             2             |   automatic   automatic
>
> This table doesn't help much IMHO. What is really important to say is
> that you can't mix manual and automatic modes.

Well actually the table is wrong. There is no manual mode per se. Only
an automatic mode that behaves like a manual mode (if setup properly).
Let me think about how to rephrase it

I guess this depends on how I'll implement the manual mode (user vs
kernel space). See
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017192.html.



> > +Each PWM has 4 associated distinctiv output duty-cycles: full, high, low
>
> That would be distinctive or (better I think) distinct.

Yep, distinct it is.


> > +different thermal input but - and here's the weird part - only one set of
> > +thermal thresholds exist that control both PWMs output duty cycles (??).
>
> Why these question marks?

Just to show my confusion why they implemented it that way. I'll take
them out...


> > +pwm[1..2]_auto_point1_pwm   full speed dc (255)
> > +pwm[1..2]_auto_point2_pwm   high speed dc
> > +pwm[1..2]_auto_point3_pwm   low speed dc
> > +pwm[1..2]_auto_point4_pwm   off dc (0)
>
> "dc" is an unfortunate abbreviation for duty cycle. People could read it
> as "direct current", which is the other fan speed control method. Pretty
> confusing.

Will fix.


> > +Long story short, the controller inmplements the following algorithm to set
>
> Typo: implements.

Will fix.


> Very good doc, well done.

Thanks :-)

...juerg

