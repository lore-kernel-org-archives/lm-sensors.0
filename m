From: juergh@gmail.com (Juerg Haefliger)
Date: Mon, 14 Aug 2006 17:42:24 +0000
Subject: [lm-sensors] [PATCH 1/2 RESEND 2] hwmon: new vt1211 driver
Message-Id: <191fb4ca0608141042h7542981la25b4ae679ed3a62@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
In-Reply-To: <191fb4ca0605311844n3d24f429k8942ffaa15e864a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Was PWM tested on the VT1211? Both manual and automatic modes? I
> > remember we dropped it from the vt8231 driver because it didn't
> > actually work for anyone.

Well, manual mode works (somewhat). But it's not the 'regular' manual
mode, i.e., writing a value to the pwm sysfs file doesn't do anything.
It definitely looks like it's RO and just reports the current PWM
value. I got manual mode working by activating the automatic mode and
programming the parameters such that the PWM controller was forced
into a specific state. Remember that the PWM controller has four
'speed' zones. It enter/leaves those speeds zones based on the current
value of the selected input temp and the programmed boundaries. I
programmed the boundaries such that the controller ended up in a
specific speed zone (and it stayed there over the 'whole' temperature
range) and then I could manually change the PWM setting for that
particular speed zone. The current PWM value changed accordingly so
I'm pretty sure it's working even though my fan is not connected to
the PWM output :-)
Now how do I go about documenting this? Should I provide a script to
set up the paramters if someone wants to use the 'manual' PWM mode or
should I put it into the driver? Actually, putting it into the driver
might not be such a bad idea although it might become a nightmare to
document :-)

Any thoughts?
...juerg

