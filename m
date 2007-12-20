From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 20 Dec 2007 18:50:15 +0000
Subject: Re: [lm-sensors] auto_pwm_min in dme1737 driver
Message-Id: <191fb4ca0712201050q3842b7cdi1c72e2441fdbe4fa@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0712191022i313516d2t759f71a95e561ff1@mail.gmail.com>
In-Reply-To: <191fb4ca0712191022i313516d2t759f71a95e561ff1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michel,


On Dec 19, 2007 4:35 PM, Michel Lespinasse <walken@zoy.org> wrote:
> On Wed, Dec 19, 2007 at 10:22:35AM -0800, Juerg Haefliger wrote:
> > For the future, please keep the lm-sensors list in the loop so that
> > others can profit from the information.
>
> Oops, sorry about that.
>
> > Mode 2) This mode is like mode 1) except that the fan will turn off if
> > the associated temp goes below the auto_point1_temp_hyst value. I
> > believe this is what you want and this is what I couldn't get to work
> > :-) Anyways, please give it a try. To set the chip up in this mode, do
> > this:
> > echo <MIN_TEMP> > XXX_auto_point1_temp_hyst
> > echo <LOW_TEMP> > XXX_auto_point1_temp
> > echo <MAX_TEMP> > XXX_auto_point2_temp
> > echo <MIN_PWM> > XXX_auto_point1_pwm
> > echo 0 > XXX_auto_pwm_min
> >
> > After you set the chip up, please run 'grep ""
> > /sys/class/hwmon/hwmon*/device/*' and post the output to the list.
>
> Sure, here are my results:
>
> # echo 47000 > zone3_auto_point1_temp_hyst
> # echo 51000 > zone3_auto_point1_temp
> # echo 77666 > zone3_auto_point2_temp
> # echo 85 > pwm1_auto_point1_pwm
> # echo 0 > pwm1_auto_pwm_min
> # grep '' *
> cpu0_vid:1550
> fan1_alarm:0
> fan1_input:0
> fan1_min:0
> fan1_type:2
> fan2_alarm:0
> fan2_input:0
> fan2_min:0
> fan2_type:2
> fan4_alarm:0
> fan4_input:0
> fan4_min:0
> fan4_type:2
> in0_alarm:1
> in0_input:0
> in0_max:6641
> in0_min:0
> in1_alarm:0
> in1_input:1099
> in1_max:1277
> in1_min:1043
> in2_alarm:0
> in2_input:3274
> in2_max:3472
> in2_min:3128
> in3_alarm:0
> in3_input:4980
> in3_max:5260
> in3_min:4740
> in4_alarm:0
> in4_input:11801
> in4_max:12625
> in4_min:11375
> in5_alarm:0
> in5_input:3266
> in5_max:3472
> in5_min:3128
> in6_alarm:0
> in6_input:2959
> in6_max:3145
> in6_min:2853
> name:dme1737
> pwm1:85
> pwm1_auto_channels_zone:4
> pwm1_auto_point1_pwm:85
> pwm1_auto_point2_pwm:255
> pwm1_auto_pwm_min:85
> pwm1_enable:2
> pwm1_freq:25000
> pwm1_ramp_rate:0
> pwm2:255
> pwm2_auto_channels_zone:2
> pwm2_auto_point1_pwm:128
> pwm2_auto_point2_pwm:255
> pwm2_auto_pwm_min:128
> pwm2_enable:0
> pwm2_freq:25000
> pwm2_ramp_rate:0
> pwm3:255
> pwm3_auto_channels_zone:4
> pwm3_auto_point1_pwm:128
> pwm3_auto_point2_pwm:255
> pwm3_auto_pwm_min:128
> pwm3_enable:0
> pwm3_freq:25000
> pwm3_ramp_rate:0
> temp1_alarm:1
> temp1_fault:0
> temp1_input:-128000
> temp1_max:127000
> temp1_min:-127000
> temp1_offset:0
> temp2_alarm:0
> temp2_fault:0
> temp2_input:33875
> temp2_max:50000
> temp2_min:-127000
> temp2_offset:0
> temp3_alarm:0
> temp3_fault:0
> temp3_input:26187
> temp3_max:60000
> temp3_min:-127000
> temp3_offset:0
> grep: uevent: Permission denied
> vrm:24
> zone1_auto_channels_temp:1
> zone1_auto_point1_temp:90000
> zone1_auto_point1_temp_hyst:86000
> zone1_auto_point2_temp:122000
> zone1_auto_point3_temp:100000
> zone2_auto_channels_temp:2
> zone2_auto_point1_temp:90000
> zone2_auto_point1_temp_hyst:90000
> zone2_auto_point2_temp:122000
> zone2_auto_point3_temp:100000
> zone3_auto_channels_temp:4
> zone3_auto_point1_temp:51000
> zone3_auto_point1_temp_hyst:47000
> zone3_auto_point2_temp:77666
> zone3_auto_point3_temp:69000
>
> pwm1_auto_pwm_min just refuses to go to zero...
>
> After a quick look at the code, my guess would be that the asus chip
> ignores writes to the OFF1-OFF3 bits in the PWM ramp rate register
> and always returns 1 when we read them. I have not instrumented anything
> to confirm that, though. I did check that writing a large value into
> pwm1_ramp_rate does force it to get set to 206 (largest supported value),
> so at least the lower bits of that register appear to work as expected...

Yes, this is the behavior that I saw earlier. I just tested it again
and the 3 MSB's can't be set to 0, they always return 1. The datasheet
only states the the whole register is read-only if the chip is locked
but that is not the case. It also states that the default for this
register is 0. The fact that they return 1 now tells me that either
the datasheet is wrong or the bits were writable at one point. Maybe
there is a dependency on other register settings or the order in which
registers get set that turn these 3 bits read-only.


>
> Oh, and I just found another small issue. This one is in the driver.
> # echo 0 > fan1_min
> saloon kernel: divide error: 0000 [1]
> I guess the divide error is in the FAN_TO_REG macro...

Good catch. Thanks, will fix.

...juerg


> Cheers,
>
> --
> Michel Lespinasse
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
