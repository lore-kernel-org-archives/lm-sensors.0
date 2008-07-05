From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Jul 2008 17:16:24 +0000
Subject: Re: [lm-sensors] set beep_enable 1
Message-Id: <20080705191624.78012f45@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <486FA824.2000101@gmail.com>
In-Reply-To: <486FA824.2000101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 05 Jul 2008 18:58:12 +0200, skull wrote:
> launching rc.lm_sensors with the option in the object i get an error saying
> "Starting lm_sensors: loading module i2c-nforce2 lm83 lm90 Error: Line
> 1587: Unknown feature name
> lm90-i2c-1-4c: No such subfeature known"
> 
> Is it the chipset who doesn't have that feature, or am i doing some mistake?

The LM90 chip and compatible indeed don't have this feature.

> Alternatively, how can i enable the ALARM function for M/B and CPU Temp?

You can setup the temperature limits appropriately (set temp1_max, set
temp1_crit, etc.) What will happen when the limits are crossed depends
on your motherboard though. Many motherboards don't do anything,
meaning that the alarm is informative only (you just see ALARM in the
output of "sensors".) If you want something to happen on alarm, you
then have to write a little script checking the output of sensors (see
prog/daemon/healthd.sh for an example.)

As a side note, I would be surprised that you have an LM83 and an LM90
or compatible chip on the same motherboard...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
