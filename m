From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Feb 2008 15:08:14 +0000
Subject: Re: [lm-sensors] does lm-sensors pick up sensors that don't exist?
Message-Id: <20080218160814.5665e8f1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <fpc320$q83$1@saturn.local.net>
In-Reply-To: <fpc320$q83$1@saturn.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matt,

On Mon, 18 Feb 2008 08:30:09 -0600 (CST), Matt Roberds wrote:
> On my system, temp3 on the it8716 always reports the maximum possible
> value, +127 C.  I can guarantee (by putting my hand inside the case)
> that nothing in my computer is that hot, so I have always just ignored
> that reading.  I suspect that either the chip is designed to report the
> maximum possible reading if there is no sensor connected, or that Asus
> wired the unused sensor input to ground, +3.3 V, or some other voltage
> that makes it read at the maximum possible.

Depends on the thermal sensor type. For thermal diodes (or
diode-connected transistors) the chip can typically detect if the
thermal sensor is missing, and it will report it either explicitly in a
status register, or through an arbitrary value (typically -128 or +127).

For thermistors, what the chip measures is actually a voltage, which is
then converted to a temperature value. If the board manufacturer
doesn't want to implement a sensor, they will typically wire the input
to the ground, which is equivalent to an infinitely high or infinitely
low temperature (depending on how the voltage divisor bridge is built),
and the chip doesn't have to treat this as a special case. Things get
bad when the manufacturer leave the thermal input floating, you will
get random temperatures. This is quite possibly what Per is
experiencing.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
