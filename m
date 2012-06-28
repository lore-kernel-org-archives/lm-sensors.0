From: Arun Raghavan <arraghav@gmail.com>
Date: Thu, 28 Jun 2012 17:18:45 +0000
Subject: Re: [lm-sensors] Reducing fan speed for w83627ehf
Message-Id: <CAP3RjSdx=H3dusrNE55bauq+JzDG2n=n4N3UqnZP+dP5wV4w6g@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============9173602141201049423=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
In-Reply-To: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============9173602141201049423==
Content-Type: multipart/alternative; boundary=f46d0444ec392b55f604c38b86ec

--f46d0444ec392b55f604c38b86ec
Content-Type: text/plain; charset=ISO-8859-1

Hi Guenter,



> is that the default setting after system powerup, or did you modify it ?
> Just wondering, since the NCT6775 is usually configured for automatic fan
> control (which, in my experience, works pretty well).
>
> Anyway, the fans are all in pwm mode, so I think Jean is right and the fan
> just
> doesn't get slower than 1000 rpm. Which may explain why one of the fans in
> my
> system runs at 1000 rpm, even though it turns out that its pwm value is
> lower
> than the other fan's pwm value.
>

I modified it to manual and changed the PWM divisor to see what speeds I
could get. I agree that Jean's diagnosis makes sense.
 It isn't that the automatic fan control didn't work well, in fact it never
gave me problems. This might sound weird, but I actually need the fan speed
lower to reach a specific (lower) TDP for experimental work.
After playing around with the heatsink and fan settings, the TDP is
currently pretty close to what I ideally want, to within about 5W. I was
hoping to shave off 5W more by reducing fan speed further.

>
> For comparison, here is the output for pwm1 on my system with NCT6775.
>
> /sys/class/hwmon/hwmon1/device/pwm1:64
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point1_pwm:50
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point1_temp:5000
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point1_temp_hyst:3000
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point2_pwm:77
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point2_temp:89000
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point2_temp_hyst:87000
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point3_pwm:77
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point3_temp:89000
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point3_temp_hyst:87000
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point4_pwm:123
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point4_temp:98000
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point4_temp_hyst:96000
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point5_pwm:166
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point5_temp:101000
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point5_temp_hyst:99000
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point6_pwm:255
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point6_temp:104000
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point6_temp_hyst:102000
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point7_pwm:255
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point7_temp:114000
> /sys/class/hwmon/hwmon1/device/pwm1_auto_point7_temp_hyst:114000
> /sys/class/hwmon/hwmon1/device/pwm1_enable:5
> /sys/class/hwmon/hwmon1/device/pwm1_max_output:255
> /sys/class/hwmon/hwmon1/device/pwm1_mode:1
> /sys/class/hwmon/hwmon1/device/pwm1_start_output:1
> /sys/class/hwmon/hwmon1/device/pwm1_step_down_time:100
> /sys/class/hwmon/hwmon1/device/pwm1_step_enable:1
> /sys/class/hwmon/hwmon1/device/pwm1_step_output:1
> /sys/class/hwmon/hwmon1/device/pwm1_step_up_time:200
> /sys/class/hwmon/hwmon1/device/pwm1_stop_output:1
> /sys/class/hwmon/hwmon1/device/pwm1_stop_output_enable:0
> /sys/class/hwmon/hwmon1/device/pwm1_stop_time:6000
> /sys/class/hwmon/hwmon1/device/pwm1_target:1000
> /sys/class/hwmon/hwmon1/device/pwm1_temp_sel:8
> /sys/class/hwmon/hwmon1/device/pwm1_weight_duty_step:36
> /sys/class/hwmon/hwmon1/device/pwm1_weight_enable:1
> /sys/class/hwmon/hwmon1/device/pwm1_weight_temp_sel:1
> /sys/class/hwmon/hwmon1/device/pwm1_weight_temp_step:2000
> /sys/class/hwmon/hwmon1/device/pwm1_weight_temp_step_base:70000
> /sys/class/hwmon/hwmon1/device/pwm1_weight_temp_step_tol:1000
>
> This is with the new driver for the NCT677X chips, which supports automatic
> fan control. Might be worthwhile to give it a try if you want to use
> automatic fan control.
>
> Thanks. I'm trying to retain control of the thermals for a study.
Actually, could you provide some more info on how the automatic control
works? In specific, does it try to keep *average* temperature under control
by modulating fan speed, or can I get it to keep a constant fan speed so
that temperature doesn't fluctuate (i.e. a plot of temperature v/s time
would be monotonic under constant input power)? That might work for me too.
Otherwise, as Jean said, I will have to look at replacing the fan and/or
changing input voltage.

thanks,
-arun



> Thanks,
> Guenter
>

--f46d0444ec392b55f604c38b86ec
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Guenter,<br><br><div class=3D"gmail_quote"><br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
<br>
is that the default setting after system powerup, or did you modify it ?<br=
>
Just wondering, since the NCT6775 is usually configured for automatic fan<b=
r>
control (which, in my experience, works pretty well).<br>
<br>
Anyway, the fans are all in pwm mode, so I think Jean is right and the fan =
just<br>
doesn&#39;t get slower than 1000 rpm. Which may explain why one of the fans=
 in my<br>
system runs at 1000 rpm, even though it turns out that its pwm value is low=
er<br>
than the other fan&#39;s pwm value.<br></blockquote><div><br>I modified it =
to manual and changed the PWM divisor to see what speeds I could get. I agr=
ee that Jean&#39;s diagnosis makes sense.<br>=A0It isn&#39;t that the autom=
atic fan control didn&#39;t work well, in fact it never gave me problems. T=
his might sound weird, but I actually need the fan speed lower to reach a s=
pecific (lower) TDP for experimental work. <br>
After playing around with the heatsink and fan settings, the TDP is current=
ly pretty close to what I ideally want, to within about 5W. I was hoping to=
 shave off 5W more by reducing fan speed further. <br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">

<br>
For comparison, here is the output for pwm1 on my system with NCT6775.<br>
<br>
/sys/class/hwmon/hwmon1/device/pwm1:64<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point1_pwm:50<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point1_temp:5000<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point1_temp_hyst:3000<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point2_pwm:77<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point2_temp:89000<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point2_temp_hyst:87000<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point3_pwm:77<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point3_temp:89000<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point3_temp_hyst:87000<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point4_pwm:123<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point4_temp:98000<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point4_temp_hyst:96000<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point5_pwm:166<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point5_temp:101000<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point5_temp_hyst:99000<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point6_pwm:255<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point6_temp:104000<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point6_temp_hyst:102000<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point7_pwm:255<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point7_temp:114000<br>
/sys/class/hwmon/hwmon1/device/pwm1_auto_point7_temp_hyst:114000<br>
/sys/class/hwmon/hwmon1/device/pwm1_enable:5<br>
<div class=3D"im">/sys/class/hwmon/hwmon1/device/pwm1_max_output:255<br>
/sys/class/hwmon/hwmon1/device/pwm1_mode:1<br>
/sys/class/hwmon/hwmon1/device/pwm1_start_output:1<br>
</div>/sys/class/hwmon/hwmon1/device/pwm1_step_down_time:100<br>
/sys/class/hwmon/hwmon1/device/pwm1_step_enable:1<br>
/sys/class/hwmon/hwmon1/device/pwm1_step_output:1<br>
/sys/class/hwmon/hwmon1/device/pwm1_step_up_time:200<br>
/sys/class/hwmon/hwmon1/device/pwm1_stop_output:1<br>
/sys/class/hwmon/hwmon1/device/pwm1_stop_output_enable:0<br>
/sys/class/hwmon/hwmon1/device/pwm1_stop_time:6000<br>
/sys/class/hwmon/hwmon1/device/pwm1_target:1000<br>
/sys/class/hwmon/hwmon1/device/pwm1_temp_sel:8<br>
/sys/class/hwmon/hwmon1/device/pwm1_weight_duty_step:36<br>
/sys/class/hwmon/hwmon1/device/pwm1_weight_enable:1<br>
/sys/class/hwmon/hwmon1/device/pwm1_weight_temp_sel:1<br>
/sys/class/hwmon/hwmon1/device/pwm1_weight_temp_step:2000<br>
/sys/class/hwmon/hwmon1/device/pwm1_weight_temp_step_base:70000<br>
/sys/class/hwmon/hwmon1/device/pwm1_weight_temp_step_tol:1000<br>
<br>
This is with the new driver for the NCT677X chips, which supports automatic=
<br>
fan control. Might be worthwhile to give it a try if you want to use<br>
automatic fan control.<br>
<br></blockquote><div>Thanks. I&#39;m trying to retain control of the therm=
als for a study. Actually, could you provide some more info on how the auto=
matic control works? In specific, does it try to keep *average* temperature=
 under control by modulating fan speed, or can I get it to keep a constant =
fan speed so that temperature doesn&#39;t fluctuate (i.e. a plot of tempera=
ture v/s time would be monotonic under constant input power)? That might wo=
rk for me too.<br>
Otherwise, as Jean said, I will have to look at replacing the fan and/or ch=
anging input voltage.<br><br>thanks,<br>-arun<br><br>=A0<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">

Thanks,<br>
Guenter<br>
</blockquote><br></div><br>

--f46d0444ec392b55f604c38b86ec--


--===============9173602141201049423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============9173602141201049423==--
