From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 26 Jul 2007 19:51:56 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <191fb4ca0707261251u60f7a2a0x73d6ab33d5d03183@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi cilly,


> On Jul 26, 2007, at 6:24 PM, Juerg Haefliger wrote:
>
> Hi Juerg,
>
> > Looks all good. I guess your running on older version of sensors. What
> > does 'sensors -v' show? You might want to consider upgrading to the
> > latest version.
>
> I am using:
>
> sensors version 2.10.1 with libsensors version 2.10.1
>
> Do I have to upgrade to 2.10.4 to perform the following steps?

No. Not necessary.


> In the following, I report the standard values:
> > Anyhow, pwmconfig will not work with the vt1211 driver since the
> > driver doesn't support manual mode which pwmconfig relies on. I
> > couldn't get manual mode to work. The driver does support automatic
> > mode though and you can abuse the automatic mode to behave like manual
> > mode (but it still will not work with pwmconfig).
> > The idea is to set the automatic mode parameters to extreme values so
> > that the pwm controller stays always in the same pwm zone. Then you
> > can change the pwm value for that zone to manually control your fan.
> >
> > Try the follwowing (assuming your fan is controlled by pwm2 and the
> > vt1211 is registered under hwmon0):
> >
> > cd /sys/class/hwmon/hwmon0/device
> > # pwm2 is controlled by temp2
> > echo 2 > pwm2_auto_channels_temp
>
> # cat pwm2_auto_channels_temp
> 1

That's the chip default.


> > # enable auto mode
> > echo 2 > pwm2_enable
>
> # cat pwm2_enable
> 0

That's the chip default.


> > # set the temp boundaries to extreme values
> > echo -99999 > pwm1_auto_point1_temp
> > echo -99999 > pwm1_auto_point2_temp
> > echo 999999 > pwm1_auto_point3_temp
> > echo 999999 > pwm1_auto_point4_temp
>
> All above values are set to:
> 0

That's the chip default.


>
> >
> > You only need to issue the above command once to setup the vt1211. Now
> > to change the pwm value to xyz, you have to do the following
> >
> > echo xyz > pwm2_auto_point3_pwm
>
> What value do you recommend for xyz?

Well this is just to try to figure out if you can actually control the
fan. Currently pwm2 is set to 255 so the fan should be running at full
speed. You can try 0 and see if the fan stops. But be careful, if the
fan is actually cooling something that something could overheat and
die if you disable the fan!


> # cat pwm2_auto_point3_temp
> 0

Chip default.


> > echo -99999 > pwm1_auto_point3_temp
> > echo 999999 > pwm1_auto_point3_temp
> >
> > And you can check the current pwm value:
> > grep "" pwm2
>
> grep "" pwm2
> 255
>
> > If your fan is controlled by pwm1, change pwm2 to pwm1 in the above
> > commands.
> >
> > After you issued the above commands, can you post the output of
> > 'grep "" *'?
> > Let me know how it goes.
>
> alarms:4608
> cpu0_vid:1250
> fan1_alarm:0
> fan1_div:2
> fan1_input:0
> fan1_min:3006
> fan2_alarm:0
> fan2_div:2
> fan2_input:0
> fan2_min:3006
> in0_alarm:0
> in0_input:1962
> in0_max:2067
> in0_min:1868
> in1_alarm:0
> in1_input:1973
> in1_max:2119
> in1_min:1910
> in2_alarm:0
> in2_input:1221
> in2_max:1253
> in2_min:1180
> in3_alarm:0
> in3_input:1942
> in3_max:2119
> in3_min:1733
> in4_alarm:0
> in4_input:2004
> in4_max:2203
> in4_min:1795
> in5_alarm:0
> in5_input:3283
> in5_max:3465
> in5_min:3133
> modalias:vt1211
> name:vt1211
> pwm1:255
> pwm1_auto_channels_temp:1
> pwm1_auto_point1_pwm:0
> pwm1_auto_point1_temp:0
> pwm1_auto_point2_pwm:255
> pwm1_auto_point2_temp:0
> pwm1_auto_point3_pwm:255
> pwm1_auto_point3_temp:0
> pwm1_auto_point4_pwm:255
> pwm1_auto_point4_temp:0
> pwm1_enable:0
> pwm1_freq:45000
> pwm2:255
> pwm2_auto_channels_temp:1
> pwm2_auto_point1_pwm:0
> pwm2_auto_point1_temp:0
> pwm2_auto_point2_pwm:255
> pwm2_auto_point2_temp:0
> pwm2_auto_point3_pwm:255
> pwm2_auto_point3_temp:0
> pwm2_auto_point4_pwm:255
> pwm2_auto_point4_temp:0
> pwm2_enable:0
> pwm2_freq:45000
> temp1_alarm:0
> temp1_input:111000
> temp1_max:147000
> temp1_max_hyst:142000
> temp2_alarm:0
> temp2_input:63000
> temp2_max:65000
> temp2_max_hyst:60000
> vrm:85
>
> Will I have to perform the following steps on each reboot?

Yes. But if you really plan on using a fan and if it can be controlled
by the vt1211 I recommend using the automatic mode. Then the vt1211 is
picking the pwm value based on the measured temp and you don't have to
deal with it. You still need to set the chip up after every reboot.

But let's try manual control first and if that works, we'll go from there.

...juerg


> Regards,
>
> c.
>
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
