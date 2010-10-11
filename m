From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 11 Oct 2010 14:45:32 +0000
Subject: Re: [lm-sensors] hwmon and GPIO fan
Message-Id: <20101011164532.4f123229@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101011142558.GD13596@kw.sim.vm.gnt>
In-Reply-To: <20101011142558.GD13596@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Salut Simon,

On Mon, 11 Oct 2010 14:25:58 +0000, Simon Guinot wrote:
> I am currently looking to add hwmon support for the fan device found on
> Network Space Max v2 boards (ARM Kirkwood SoC).
> 
> The fan speed can be configured trough GPIOs. The GPIO settings allow to
> change the fan input voltage (via some resistors).
> After a quick look at the hwmon sysfs interface, I have failed to find
> the appropriate way to expose a non-pwm fan. If any, what is the
> dedicated sysfs entry to set speed for a non-pwm fan ?
> Maybe that a fake pwm interface is needed ?

Don't let yourself be fooled by the "pwm[1-n]" and "pwm[1_n]_enable"
files names. These are valid for all fan control outputs, be they PWM
or DC. As a matter of fact, "pwm[1-n]_mode" lets you advertise whether
the controller is using PWM or DC.

All that really matters is that you use 0-255 as the pwm[1-n] range
matching 0-100%.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
