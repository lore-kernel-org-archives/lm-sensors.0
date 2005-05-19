From: denisleroy@yahoo.com (Denis Leroy)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: lm75 compute
Message-Id: <20031028233032.9976.qmail@web10104.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F9C884D.93E32BDA@paradyne.com>
In-Reply-To: <3F9C884D.93E32BDA@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Salut Jean,

Yes, i think you must be right there, i can't come up with any other
explanation of why your board BIOS would scale up the temperature. The
LM75 is an air-flow temperature sensor, not a die temperature sensor. 
My point was: you're right to modify your sensors.conf to scale it up
by 2.0, but it probably shouldn't be the default setting.

As far as i know (which is not that much as i'm a software guy), the
National LM75 is very commonly used, though i could ask one of our
hardware gurus if you're interested. One of our boards has an LM75, an
LM87 and a NE1617 very close together. All three have internal temp
sensors, and all three report pretty much the exact same temperature
(typically around 25 to 30C in our strongly air-conditionned lab). The
LM87 has pins for external sensor diodes which are connected to FPGA
diodes. Those are die temperatures, and are always a lot higher
(depending of whether the FPGA has a heat-sink or not), around 40 to
50C (hyst is typically 75C, limit 85C).

I was hoping to contribute some drivers to your project, based on your
interest and if i get some time (Philips ne1617, Vitesse VSC055, or
more fun, XFP laser 10G transceivers...).

-denis

--- Jean Delvare <khali@linux-fr.org> wrote:
> I did that and could see the chips. There *is* a real LM75 right
> under
> the CPU socket. My guess is that the LM75 is not designed to
> accurately
> measure a CPU's temperature, so Asus placed it in such a location
> that
> multiplying the original value by two would give a correct
> approximation
> of the CPU's temperature. This means that I should not trust the
> reported value too much - although it *is* related to how much heat
> the
> CPU generates, whatever the actual value is.


__________________________________
Do you Yahoo!?
Exclusive Video Premiere - Britney Spears
http://launch.yahoo.com/promos/britneyspears/
