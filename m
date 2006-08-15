From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 15 Aug 2006 06:43:48 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 2] hwmon: new vt1211 driver
Message-Id: <20060815084348.46482f32.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
In-Reply-To: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

> > > Was PWM tested on the VT1211? Both manual and automatic modes? I
> > > remember we dropped it from the vt8231 driver because it didn't
> > > actually work for anyone.
> 
> Well, manual mode works (somewhat). But it's not the 'regular' manual
> mode, i.e., writing a value to the pwm sysfs file doesn't do anything.
> It definitely looks like it's RO and just reports the current PWM
> value. I got manual mode working by activating the automatic mode and
> programming the parameters such that the PWM controller was forced
> into a specific state. Remember that the PWM controller has four
> 'speed' zones. It enter/leaves those speeds zones based on the current
> value of the selected input temp and the programmed boundaries. I
> programmed the boundaries such that the controller ended up in a
> specific speed zone (and it stayed there over the 'whole' temperature
> range) and then I could manually change the PWM setting for that
> particular speed zone. The current PWM value changed accordingly so
> I'm pretty sure it's working even though my fan is not connected to
> the PWM output :-)

OK. I'd be nice if someone could test it with a real fan, though.

> Now how do I go about documenting this? Should I provide a script to
> set up the paramters if someone wants to use the 'manual' PWM mode or
> should I put it into the driver? Actually, putting it into the driver
> might not be such a bad idea although it might become a nightmare to
> document :-)
> 
> Any thoughts?

The driver should provide the functions the chip provides. Any form of
emulation belongs to user-space. So I think you should wipe out the
manual mode from the driver entirely (it doesn't work as documented),
and only leave off (0) and automatic (2) modes. The nice side is that
it solves the "pwm1 and pwm2 can't mix modes" issue.

Then you can document your trick above, if you want. This should work
for any chip with automatic mode, it's not really VT1211-specific. It's
just so rare that a chip can do automatic fan speed control, but not
manual.

-- 
Jean Delvare

