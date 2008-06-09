From: Matt Roberds <mattroberds@cox.net>
Date: Mon, 09 Jun 2008 00:35:36 +0000
Subject: Re: [lm-sensors] [Bug?] W83697: Broken readings for fan speed 10%
Message-Id: <Pine.LNX.4.64.0806081915360.4011@birdbird.example.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="655872-920424273-1212971736=:4011"
List-Id: <lm-sensors.vger.kernel.org>
References: <20080531220339.05dc83fd@neptune.home>
In-Reply-To: <20080531220339.05dc83fd@neptune.home>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--655872-920424273-1212971736=:4011
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 8 Jun 2008, Bruno Pr=E9mont wrote:
> I will look if I can find a way do determine the real fan speed in
> order to compare with the values both chips report.

The exactly right instrument to use for this is probably an optical
tachometer.  It looks for reflections from a piece of reflective tape or
a white stripe painted on a rotating machine, and tells you the speed in
rpm.  If you're in university (or know someone who is), the physics or
mechanical engineering labs will often have such a device.
http://www.extech.com/instrument/products/451_499/461700.html is one
example but they are made by several companies.

There is another kind of tachometer that has a small wheel or probe that
you hold against the rotating machine; the machine spins the wheel and
the tachometer displays the rpm.  A computer fan motor is not very
strong, though, and making the measurement may tend to slow down the
fan.  http://www.extech.com/instrument/products/451_499/461750.html
is an example, but again, several companies make them.

The previous way to do this was with a stroboscope - a flashing light
with adjustable flash rate.  You point the light at the rotating machine
and turn a knob until the flashes of light "stop" the motion of the
machine.  You then read the flash rate from the knob and compute the
rpm.  http://www.ietlabs.com/Genrad/1531.html is a classic example.

If you have a function generator, you might be able to connect a LED to
its output and use it as a stroboscope.  (Make sure the output of the
function generator is strong enough to drive a LED; some of them are not
designed for this.)

Another way to do it is to use a plain old fluorescent lamp (with
magnetic ballast) or neon glow lamp.  Either one will flash at 100 Hz
(Europe) or 120 Hz (North America).  It may help to be in a dark room
with the fluorescent or neon lamp as the only source of illumination.
You can't adjust the flash rate, but you can use it to get an idea of
the fan speed.  For instance, if you mark one fan blade, and it appears
to "stop" in the same spot every time, the fan is probably turning at
6000 rpm (Europe): 100 Hz * 60 sec.  (It could also be turning at 12000
or 18000 or 24000 rpm, but most computer fans don't go that fast.)  If
the mark appears to "stop" in two places, 180 degrees apart, the fan is
probably turning at 3000 rpm, and so on.

Standard disclaimers apply; I don't get money or other consideration
from any companies mentioned.

Matt Roberds

--655872-920424273-1212971736=:4011
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--655872-920424273-1212971736=:4011--
