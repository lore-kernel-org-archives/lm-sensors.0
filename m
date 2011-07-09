From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 09 Jul 2011 17:07:59 +0000
Subject: [lm-sensors] Suggested additions to hwmon sysfs ABI
Message-Id: <20110709170759.GA5750@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

while adding support for more PMBus devices, I noticed that many of the chips
support attributes which are not currently available in the sysfs ABI.

Here is a (not necessarily complete) list.

---

Historic minimum attributes:
		vout_min	vin_min		temp_min
MAX34440	x
MAX34441	x
LTC2978		x		x		x

Peak (historic maximum) attributes:

		pin_peak	vin_peak	vout_peak	iout_peak	temp_peak
MAX34440					x		x		x
MAX34441					x		x		x
MAX8688						x		x		x
MAX16064					x				x
ADM1275				x		x		x
ADM1276		x		x		x		x
LTC2978				x		x				x
LM25066		x (1)
LM5064		x (1)
LM5066		x (1)
ZLxxxx (2)							x (3)

Average attributes:

		vin_avg		vout_avg	iin_avg		pin_avg
LM25066		x		x		x		x (1)
LM5064		x		x		x		x (1)
LM5066		x		x		x		x (1)

Notes:
1) In addition to instantaneous power measurements
2) All Intersil / Zilker Labs power management chips
3) Only available through SNAPSHOT command, which reads a total of 32 bytes.
   Also see Intersil / Zilker Labs AN2033.

---

Based on this list, I suggest adding the following attributes to the ABI.

in[0-*]_input_lowest
in[0-*]_input_highest
in[0-*]_average
in[0-*]_reset_history

curr[1-*]_input_lowest
curr[1-*]_input_highest
curr[1-*]_average
curr[1-*]_reset_history

temp[1-*]_input_lowest
temp[1-*]_input_highest
temp[1-*]_average
temp[1-*]_reset_history

It might also be necessary to modify the sensors command to support both instantaneous
and average/peak power readings at the same time.

Thoughts/comments ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
