From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 14 Jan 2012 17:22:10 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (lm63) Support extended lookup table of LM96163
Message-Id: <20120114172210.GC29012@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120114100836.462e6f2e@endymion.delvare>
In-Reply-To: <20120114100836.462e6f2e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sat, Jan 14, 2012 at 11:53:30AM -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> On Sat, 14 Jan 2012 08:40:32 -0800, Guenter Roeck wrote:
> > On Sat, Jan 14, 2012 at 04:08:36AM -0500, Jean Delvare wrote:
> > > The LM96163 has an extended lookup table with 12 entries instead of 8,
> > > add support for that.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > ---
> > > Guenter, can you please test this patch (on top of the previous one) on
> > > your LM96163? Thanks.
> > 
> > Tested-and-Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Thanks!
> 
> > Output:
> > 
> > # for x in pwm*; do echo $x: $(cat $x); done
> 
> aka
> # grep . pwm*
> 
I ought to know, but I keep forgetting it. Too fancy for me ;).

> > pwm1: 0
> > pwm1_auto_point10_pwm: 255
> > pwm1_auto_point10_temp: 127000
> > pwm1_auto_point10_temp_hyst: 123000
> > pwm1_auto_point11_pwm: 255
> > pwm1_auto_point11_temp: 127000
> > pwm1_auto_point11_temp_hyst: 123000
> > pwm1_auto_point12_pwm: 255
> > pwm1_auto_point12_temp: 127000
> > pwm1_auto_point12_temp_hyst: 123000
> > pwm1_auto_point1_pwm: 255
> > pwm1_auto_point1_temp: 127000
> > pwm1_auto_point1_temp_hyst: 123000
> > pwm1_auto_point2_pwm: 255
> > pwm1_auto_point2_temp: 127000
> > pwm1_auto_point2_temp_hyst: 123000
> > pwm1_auto_point3_pwm: 255
> > pwm1_auto_point3_temp: 127000
> > pwm1_auto_point3_temp_hyst: 123000
> > pwm1_auto_point4_pwm: 255
> > pwm1_auto_point4_temp: 127000
> > pwm1_auto_point4_temp_hyst: 123000
> > pwm1_auto_point5_pwm: 255
> > pwm1_auto_point5_temp: 127000
> > pwm1_auto_point5_temp_hyst: 123000
> > pwm1_auto_point6_pwm: 255
> > pwm1_auto_point6_temp: 127000
> > pwm1_auto_point6_temp_hyst: 123000
> > pwm1_auto_point7_pwm: 255
> > pwm1_auto_point7_temp: 127000
> > pwm1_auto_point7_temp_hyst: 123000
> > pwm1_auto_point8_pwm: 255
> > pwm1_auto_point8_temp: 127000
> > pwm1_auto_point8_temp_hyst: 123000
> > pwm1_auto_point9_pwm: 255
> > pwm1_auto_point9_temp: 127000
> > pwm1_auto_point9_temp_hyst: 123000
> > pwm1_enable: 1
> 
> In other words the lookup table isn't filled on your system, automatic
> control mode isn't used. On the LM64 I have (on a graphics card) it
> looks much more interesting:
> 
My "system" is a little breadboard which has nothing but a bare LM96196 and (coincidentially,
because I had space) a MAX16067 on it. Same for my LM63 board. If I want it to provide anything
but power-up functionality, I have to program it manually. On the plus side, once we get
to writing the pwm registers, I'll have a nice means of testing it. Maybe I can even connect
a LED to the pwm output to see what it is doing.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
