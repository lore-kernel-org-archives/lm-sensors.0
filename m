From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Jan 2012 16:53:30 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (lm63) Support extended lookup table of LM96163
Message-Id: <20120114175330.25202ec0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120114100836.462e6f2e@endymion.delvare>
In-Reply-To: <20120114100836.462e6f2e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Sat, 14 Jan 2012 08:40:32 -0800, Guenter Roeck wrote:
> On Sat, Jan 14, 2012 at 04:08:36AM -0500, Jean Delvare wrote:
> > The LM96163 has an extended lookup table with 12 entries instead of 8,
> > add support for that.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > ---
> > Guenter, can you please test this patch (on top of the previous one) on
> > your LM96163? Thanks.
> 
> Tested-and-Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Thanks!

> Output:
> 
> # for x in pwm*; do echo $x: $(cat $x); done

aka
# grep . pwm*

> pwm1: 0
> pwm1_auto_point10_pwm: 255
> pwm1_auto_point10_temp: 127000
> pwm1_auto_point10_temp_hyst: 123000
> pwm1_auto_point11_pwm: 255
> pwm1_auto_point11_temp: 127000
> pwm1_auto_point11_temp_hyst: 123000
> pwm1_auto_point12_pwm: 255
> pwm1_auto_point12_temp: 127000
> pwm1_auto_point12_temp_hyst: 123000
> pwm1_auto_point1_pwm: 255
> pwm1_auto_point1_temp: 127000
> pwm1_auto_point1_temp_hyst: 123000
> pwm1_auto_point2_pwm: 255
> pwm1_auto_point2_temp: 127000
> pwm1_auto_point2_temp_hyst: 123000
> pwm1_auto_point3_pwm: 255
> pwm1_auto_point3_temp: 127000
> pwm1_auto_point3_temp_hyst: 123000
> pwm1_auto_point4_pwm: 255
> pwm1_auto_point4_temp: 127000
> pwm1_auto_point4_temp_hyst: 123000
> pwm1_auto_point5_pwm: 255
> pwm1_auto_point5_temp: 127000
> pwm1_auto_point5_temp_hyst: 123000
> pwm1_auto_point6_pwm: 255
> pwm1_auto_point6_temp: 127000
> pwm1_auto_point6_temp_hyst: 123000
> pwm1_auto_point7_pwm: 255
> pwm1_auto_point7_temp: 127000
> pwm1_auto_point7_temp_hyst: 123000
> pwm1_auto_point8_pwm: 255
> pwm1_auto_point8_temp: 127000
> pwm1_auto_point8_temp_hyst: 123000
> pwm1_auto_point9_pwm: 255
> pwm1_auto_point9_temp: 127000
> pwm1_auto_point9_temp_hyst: 123000
> pwm1_enable: 1

In other words the lookup table isn't filled on your system, automatic
control mode isn't used. On the LM64 I have (on a graphics card) it
looks much more interesting:

pwm1:70
pwm1_auto_point1_pwm:70
pwm1_auto_point1_temp:16000
pwm1_auto_point1_temp_hyst:13000
pwm1_auto_point2_pwm:81
pwm1_auto_point2_temp:86000
pwm1_auto_point2_temp_hyst:83000
pwm1_auto_point3_pwm:93
pwm1_auto_point3_temp:96000
pwm1_auto_point3_temp_hyst:93000
pwm1_auto_point4_pwm:128
pwm1_auto_point4_temp:104000
pwm1_auto_point4_temp_hyst:101000
pwm1_auto_point5_pwm:139
pwm1_auto_point5_temp:107000
pwm1_auto_point5_temp_hyst:104000
pwm1_auto_point6_pwm:151
pwm1_auto_point6_temp:110000
pwm1_auto_point6_temp_hyst:107000
pwm1_auto_point7_pwm:174
pwm1_auto_point7_temp:113000
pwm1_auto_point7_temp_hyst:110000
pwm1_auto_point8_pwm:255
pwm1_auto_point8_temp:116000
pwm1_auto_point8_temp_hyst:113000
pwm1_enable:2

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
