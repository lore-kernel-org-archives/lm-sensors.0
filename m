From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 26 Jul 2007 22:00:24 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <191fb4ca0707261500w222c230bn8bf782ebc34377b2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi cilly,


> Hi Juerg,
>
> # cd /sys/class/hwmon/hwmon0/device
> # echo 2 > pwm2_auto_channels_temp
>
> # echo 2 > pwm2_enable
>
> now, fan goes off

Hmm... interesting.... that's unexpected...


> What are these for, and why pwm1:
>
> # echo -99999 > pwm1_auto_point1_temp
> # echo -99999 > pwm1_auto_point2_temp
> # echo 999999 > pwm1_auto_point3_temp
> # echo 999999 > pwm1_auto_point4_temp

Please read the vt1211 doc in the kernel tree (Documentation/hwmon/vt1211).


> fan still off after above commands
>
> echo 200 > pwm2_auto_point3_pwm
>
> fan still off
>
> Why do I have to apply those commands again:
>
> # echo -99999 > pwm1_auto_point3_temp
> # echo 999999 > pwm1_auto_point3_temp

To trick the vt1211 into believing that there's a temp change.
Otherwise it will not apply the new pwm value.


> fan off
>
> # grep "" pwm2
> 200
>
> fan off
>
> After all, fan is off and does not spin. I am running burnMMX to
> produce some heat... seems fan does not run at all.

It's pointless to run stress tests. The fan is not automatically
controlled (yet), we're still trying 'manual' mode.

Once the fan is up and running again (maybe you have to reboot to put
the vt1211 back to default values), can you do the 'grep "" *' so that
we know which input the fan is connected to?


>
> # grep "" *
>
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
> in0_input:1952
> in0_max:2067
> in0_min:1868
> in1_alarm:0
> in1_input:1952
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
> in4_input:2015
> in4_max:2203
> in4_min:1795
> in5_alarm:0
> in5_input:3283
> in5_max:3465
> in5_min:3133
> modalias:vt1211
> name:vt1211
> pwm1:100
> pwm1_auto_channels_temp:1
> pwm1_auto_point1_pwm:0
> pwm1_auto_point1_temp:0
> pwm1_auto_point2_pwm:255
> pwm1_auto_point2_temp:0
> pwm1_auto_point3_pwm:100
> pwm1_auto_point3_temp:255000
> pwm1_auto_point4_pwm:255
> pwm1_auto_point4_temp:255000
> pwm1_enable:0
> pwm1_freq:45000
> pwm2:200
> pwm2_auto_channels_temp:2
> pwm2_auto_point1_pwm:0
> pwm2_auto_point1_temp:0
> pwm2_auto_point2_pwm:255
> pwm2_auto_point2_temp:0
> pwm2_auto_point3_pwm:200
> pwm2_auto_point3_temp:204000
> pwm2_auto_point4_pwm:255
> pwm2_auto_point4_temp:204000
> pwm2_enable:2
> pwm2_freq:45000
> temp1_alarm:0
> temp1_input:116000
> temp1_max:147000
> temp1_max_hyst:142000
> temp2_alarm:0
> temp2_input:57000
> temp2_max:65000
> temp2_max_hyst:60000
> vrm:85

Well it looks like it applied your pwm values. pwm1 and
pwm1_auto_point3_pwm match and pwm2 and pwm2_auto_point3_pwm match.
The fan is not spinning?
What if you bump the values to 255?

...juerg


>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
