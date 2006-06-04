From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Sun, 04 Jun 2006 19:22:49 +0000
Subject: [lm-sensors] sysfs interface for fan present capability
Message-Id: <654FA770A883FB43BAF3CB0B1E1DAC8C058042@jellyfish.highlyscyld.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4482843D.5020506@hhs.nl>
In-Reply-To: <4482843D.5020506@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The four wire fan connectors are the same original 3 wires (pwr, gnd, tach) with the fourth wire being a digital pwm control signal to the fan.

The way that it works is to take advantage of the power MOSFET (switch) that is already in every DC fan.  Add the PWM input to the circuit that controls when the switch is turned on so that it *doesn't* turn on when the PWM is active.  The result is that the fan slows down.

This is much simpler, cheaper to implement, and resolves several issues with using low-side or high-side MOSFETs on the motherboard.

CPU fans on the new Intel CPUs (Conroe, Dempsey, Woodcrest) will probably all be four wire.  Penguin Computing uses four wire case fans in its Tempest 2150 for better control and monitoring.

:v)

 -----Original Message-----
From: 	Henrique de Moraes Holschuh [mailto:hmh at debian.org]
Sent:	Sun Jun 04 11:10:28 2006
To:	Jean Delvare
Cc:	Hans de Goede; LM Sensors
Subject:	Re: [lm-sensors] sysfs interface for fan present capability

On Sun, 04 Jun 2006, Jean Delvare wrote:
> Definitely not the LM75, as it is a temperature-only sensor chip. But I

My bad, I should have typed lm85 (which would not be strictly correct,
either: the ADM1027 does it.  It is a LM85 compatible chip, but I don't
think the lm85b/c can do it).

> indeed. Strangely enough, some vendors are doing the opposite and
> propose 4-wire fans, the idea being that tick counts tend to be lost
> when fan speed control is in use on 3-wire fans.

As soon as you drive fans using PWM you screw up any sort of simple tick
counters completely, as you have a spike on every PWM cycle start, plus no
spikes generated during the second phase of the PWM cycle.

Probably they want four wires so that you can have Vcc, GND, Vcc-sense and
sense, so that PWM does not disable the sensor. 

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors at lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060604/84cdd296/attachment.html 
