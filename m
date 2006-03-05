From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sun, 05 Mar 2006 16:42:08 +0000
Subject: [lm-sensors] [PATCH] Add fan control support to W83627EHF
Message-Id: <4dfa50520603050842o5331251dt1f3b4430fdd1c186@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409FFA1.7050109@sh.cvut.cz>
In-Reply-To: <4409FFA1.7050109@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I disagree. If users want to ignore the RPM cruise or speed cruise
> > then it's easy to modify the sensors.conf to suit their taste. I agree
> > that there isn't a standardized sysfs file for the target RPM, but I
> > am planning on using the RPM cruise feature. Yuan has already
> > implemented it. I don't think it'd be a problem to support it. Since
> > it is present on all four PWM outputs, and Smart Fan 3 isn't, I
> > thought it would make sense to have PWM cruise be mode 3.
>
> Well it could be implemented when you will create some files like fanX_target
> (Because this file has to be in RPM and you need to convert the RPM into ticks and
> write it back to the "target temp" register. On the other hand it will mean that
> user receive nonsence when reading from tempX_target
>
> I think I'm missing the whole point of RPM cruise. To me it seems I can
> manually setup the requested RPM through the pwm file in manual mode.
>
> Can you explain please how the RPM cruise mode is different from that?
>
> Please always CC to the list so others know too ;)

Hi Rudolf,

The tempX_target register can still contain a target temperature,
either the default value loaded by the BIOS or the last temp target
when the chip was in temp cruise. fanX_target is a good way to add the
sysfs interface, I like that.

RPM cruise allows me to set an RPM directly without knowing the PWM
value. Or, more specifically, it's good for low RPMs, which are hard
to get perfectly right, since the PWM value is typically 100 or so. At
PWM values of 70 or so, the fan just stops spinning. Yes, if I wanted
to read out the RPM value and tinker with the PWM until I got the RPM
I wanted, I could find what the low threshold is where the fan
overcomes friction and starts spinning. But that's why RPM cruise is
so nice.

Anyway, as long as the chip implements it, it doesn't hurt to export
the interface, right?

David

