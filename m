From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Sun, 04 Jun 2006 18:09:34 +0000
Subject: [lm-sensors] sysfs interface for fan present capability
Message-Id: <20060604180934.GM24739@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4482843D.5020506@hhs.nl>
In-Reply-To: <4482843D.5020506@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

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

