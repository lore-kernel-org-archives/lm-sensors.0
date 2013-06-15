From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 15 Jun 2013 16:13:29 +0000
Subject: Re: [lm-sensors] [PATCHv2 1/3] Add support for GMT G762/G763 PWM fan controller
Message-Id: <87sj0jmjx2.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1369687670.git.arno@natisbad.org>
	<b44f55c4194f6cd8c94f8a3d63ad5c8bd1d1cfe0.1369687670.git.arno@natisbad.org>
	<20130531221616.GG7626@kw.sim.vm.gnt> <87fvx1pwrl.fsf@natisbad.org>
	<20130602215904.GH7626@kw.sim.vm.gnt> <87sj0yz7tv.fsf@natisbad.org>
	<20130604212306.GL7626@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Nicolas Perrin <nperrin@lacie.com>, Guenter Roeck <linux@roeck-us.net>

Hi Simon,

spoiler: end of the story below ;-)

Simon Guinot <simon.guinot@sequanux.org> writes:

> OK you are lucky. Your bootloader initialize set_cnt with 0x5a. Mine
> don't and it is precisely the issue: set_cnt is still 0xff (the default
> value) when the driver controls the fan.
>
> Please, could you try open-loop mode with set_cnt set to 0xff ?  Maybe
> you can enforce this value for the test purpose ?
>
> If you observe the same behaviour than me, then could modify the driver
> to ensure that set_cnt is not 0xff when open-loop mode is selected ?
> Maybe by systematically setting a different value (as 0) ?

Here we go:

# cd /sys/bus/i2c/drivers/g762/0-003e

# for k in fan* pwm* ; do echo -n "$k:" ; echo `cat $k `; done
fan1_alarm:0
fan1_div:1
fan1_fault:0
fan1_input:1365
fan1_pulses:2
fan1_target:1365
pwm1:0
pwm1_enable:2             /* closed-loop */
pwm1_mode:0               /* DC mode */

# echo 0 > fan1_target   /* set set_cnt to 0, fan stops rotating */

# echo 1 > pwm1_enable   /* switch to open-loop, fan does not rotate yet
                          * as default value for set_out is 0 and it has
                          * neither been touched by bootloader or driver */

# for k in fan* pwm* ; do echo -n "$k:" ; echo `cat $k `; done
fan1_alarm:0
fan1_div:1
fan1_fault:0
fan1_input:0
fan1_pulses:2
fan1_target:0
pwm1:0
pwm1_enable:1
pwm1_mode:0

# echo 100 > pwm1        /* set set_out to 100, fan rotates */


I don't get the issue in DC mode but ...


# echo 1 > pwm1_mode     /* switch to PWM mode, fan stops rotating
                          * even though set_out is still set to
                          * 100: */
# for k in fan* pwm* ; do echo -n "$k:" ; echo `cat $k `; done
fan1_alarm:0
fan1_div:1
fan1_fault:1
fan1_input:0
fan1_pulses:2
fan1_target:0
pwm1:100
pwm1_enable:1
pwm1_mode:1

# echo 1000 > fan1_target

At that point, fan starts rotating again and its speed can be controlled
using pwm1 (i.e. set_out). But, as you pointed, if set_cnt is set to 255
then, it stop rotating: with my hardware, I tried and set fan1_target to
481 (set_cnt is 255) and fan stops. Then setting fan1_target to 482
gives set_cnt a value of 254 and make the fan run again.

So, as a conclusion, I think I get the behavior you described i.e. in
PWM mode + open-loop, if set_cnt is 255, then the fan will not rotate,
no matter the value of set_out (which is supposed to control the
rotation w/ open-loop). The problem does not appear in DC mode
(i.e. set_cnt can be 255 in DC mode + open-loop and the fan will rotate
as expected based on set_out value).

In v4 version to come, I have implemented the following fix:

	switch (val) {
	case G762_FAN_MODE_OPEN_LOOP:
		data->fan_cmd1 &= ~G762_REG_FAN_CMD1_FAN_MODE;
		/*
		 * BUG FIX: if SET_CNT register value is 255 then, for some
		 * unknown reason, fan will not rotate as expected, no matter
		 * the value of SET_OUT (to be specific, this seems to happen
		 * only in PWM mode). To workaround this bug, we give SET_CNT
		 * value of 254 if it is 255 when switching to open-loop.
		 */
		if (data->set_cnt = 0xff)
			i2c_smbus_write_byte_data(client, G762_REG_SET_CNT,
						  254);
		break;
	case G762_FAN_MODE_CLOSED_LOOP:
		data->fan_cmd1 |=  G762_REG_FAN_CMD1_FAN_MODE;
		break;
	default:
		goto out;
	}

I tested it and it fixe the issue. Can you confirm it also does on your
side Simon by testing v4?

Cheers,

a+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
