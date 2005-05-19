From: schnobs@babylon-kino.de (Christian Schnobrich)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: low fan speed = zero?
Message-Id: <1075385890.672.19.camel@pferd.babel>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'm a bit shy of mailing a developer, but there doesn't seem to be a
public mailing list...

I've got a temperature-controlled fan here. When the speed drops below
an uncertain threshold, it is reported as 0 (zero).

Now, the reason I'm writing is that this threshold seems software
related. For testing purposes, I replaced the NTC with a variable
resistor.

The Windows software that came with my Mobo will report values as low as
1600rpm, the hardware Monitor in BIOS/CMOS setup starts ticking at about
2000rpm, lm_sensors and gkrellm will only give me a reading at 2400 and
over -- a value that's unlikely to be reached even on the hottest
summer's day.

Apparently, some software does a sanity check and won't report values it
considers to be too low. Could you give me a hint where this may happen,
iow point me to the right place if it is in the lm_sensors code?


regards,
Schnobs


