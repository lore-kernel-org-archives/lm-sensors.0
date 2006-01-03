From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 03 Jan 2006 19:21:23 +0000
Subject: [lm-sensors] [it8712] temperatures...
Message-Id: <20060103202123.005ee800.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43AD9085.5050906@free.fr>
In-Reply-To: <43AD9085.5050906@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fred,

> In /etc/sensors.conf, one can read that Asus mobo A7V8X-X and A7V600
> have cpu and mobo temp inverted.
> 
> On a P5ND2-Sli Deluxe, who knows ?

I don't. It would be nice if motherboard manufacturers in general, and
Asus in particular, could stick to one wiring scheme. But no, they
really seem to enjoy changing the wiring on every new board they
design...

> Should mobo temp be always under cpu temp ?
> 
> I have QFan enabled, so I'm not sure (more cpu task implies more rpm for
> CPU fan, so cpu temp could be under mobo temp, no ?)

It is possible, but quite rare. The CPU is almost always hotter,
because it is the most important heat source in your computer, and it
is cooled by the air in the case, those temperature is reported as
"motherboard temperature".

There are a few exceptions to the rule:

* If you use watercooling.

* If the motherboard sensor is next to the graphics adapter and that
adapter is a very high end model which heats much, and the CPU is a low
power consumption one (or is set to low power mode.) In that case, the
motherboard temperature can actually be greater.

* If your case is completely closed, with no air flow (but don't do
that!) In that case the CPU and motherboard temperature will be the
same after a few minutes.

Also note that the reported values have a limited accuracy, and
additionally, some sensors need to be offset and it's often hard to
figure that out.

The easiest way to determine which sensor is the CPU temperature is to
put the CPU under load (uncompress some large file, or compile a large
project, or use cpuburn [1]). The CPU temperature should always react
first and more significantly than the motherboard temperature.

[1] http://pages.sbcglobal.net/redelm/

-- 
Jean Delvare

