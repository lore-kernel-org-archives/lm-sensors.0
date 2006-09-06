From: david.c.hubbard@gmail.com (David Hubbard)
Date: Wed, 06 Sep 2006 05:40:54 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and minor problems w/
Message-Id: <4dfa50520609052240h7482f831j726ab4a63c13c2e3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1157458671.18988.34.camel@mhcln03>
In-Reply-To: <1157458671.18988.34.camel@mhcln03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matthias,

Jean is right. I mixed up the PWM and RPM numbers there.

These things would be useful:

> Matthias, can you please provide a dump of your chip (isadump 0x295
> 0x296) at init time, before loading the w83627ehf driver?
>
> I'd try forcing the driver to use all 5 fan inputs. Just run "isaset
> 0x295 0x296 0x47 0x05 0x05" before loading the w83627ehf driver, and
> see what happens. It's supposed to be the default, but...
>
> Maybe our heuristics to detect the use of the pins are not correct,
> although they are simple enough and look OK to me. Or maybe the Asus
> BIOS isn't configuring the chip properly (that'd be odd as they need
> proper setup for displaying the values themselves.)

Matthias wrote:
> Windows users report that they can indeed controll all 5 fans  with a
> tool called "SpeedFan" or something like that. I will investigate =)

SpeedFan is indeed a useful tool. The author develops hardware
monitoring drivers for quite a lot of chips out there. I have used
SpeedFan on my machine, and the results match what I get from the
w83627ehf driver. But your motherboard is doing something new, in
order to drive 5 fans.

David

