From: juergh@gmail.com (Juerg Haefliger)
Date: Tue, 15 Aug 2006 18:23:08 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 2] hwmon: new vt1211 driver
Message-Id: <191fb4ca0608151123ua0740bbjb2a68c21db7d0b3e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
In-Reply-To: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> > particular speed zone. The current PWM value changed accordingly so
> > I'm pretty sure it's working even though my fan is not connected to
> > the PWM output :-)
>
> OK. I'd be nice if someone could test it with a real fan, though.

Sure, if someone has a vt1211-based board that actually has the fan
connected to the PWM output. I haven't seen one yet...

And sometimes I'm wondering why do I put so much effort into
implementing PWM if none of the VIA boards actually uses the PMW
outputs? sigh...


> The driver should provide the functions the chip provides. Any form of
> emulation belongs to user-space. So I think you should wipe out the
> manual mode from the driver entirely (it doesn't work as documented),
> and only leave off (0) and automatic (2) modes. The nice side is that
> it solves the "pwm1 and pwm2 can't mix modes" issue.

Will do. Makes my life certainly easier :-)

...juerg


> Then you can document your trick above, if you want. This should work
> for any chip with automatic mode, it's not really VT1211-specific. It's
> just so rare that a chip can do automatic fan speed control, but not
> manual.
>
> --
> Jean Delvare
>

