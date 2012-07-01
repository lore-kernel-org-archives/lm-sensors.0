From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 01 Jul 2012 00:31:41 +0000
Subject: Re: [lm-sensors] CPU fan with full speed
Message-Id: <20120701003141.GB21694@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <jsm40t$qk8$1@dough.gmane.org>
In-Reply-To: <jsm40t$qk8$1@dough.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jun 30, 2012 at 11:46:14PM +0100, Michael Zintakis wrote:
> 
> >If I understand the code and the data sheet correectly, this attribute
> >is a bit map used to map a temperature source to one or multiple fans.
> I was just about to fire-up a question regarding that point! My
> pwm3_auto_channels_pwm has a value of 4 and I was a bit baffled why
> 4 and not 3 - the above explains it very well.
> 
> Related to this query: as part of my censors setup, I have 3
> different temperature monitors which supply reading for my CPU. 2 of
> them are in hwmon0/device/tempX_input (Intel's own coretemp module,
> X=2,3) and one of them is part of my f71882fg chip-supported
> reading: hwmon1/device/temp1_input. There are 2 Intel readings,
> because the CPU is multi-core.
> 
> Now, the f71882fg CPU reading is a bit off. What I mean by that is
> that it shows temperature which is between 3-7 degrees cooler than
> the Intel's own (coretemp) readings. Is there a way (via
> pwm1_auto_channels_pwm perhaps) to force f71882fg to take the
> coretemp reading into account instead of using its own?
> 
> I tried to "cheat" by executing "ln -s
> /sys/class/hwmon/hwmon0/device/temp2_input
> /sysclass/hwmon/hwmon1/device/temp4_input" but that didn't work - I
> get "No such file or directory" error. I cannot write anything to
> that hwmon1/device directory. Is there any way of pointing my
> f71882fg driver to read the 2 Intel temperatures temperatures
> instead of using its own, not very accurate reading?
>
No ... those are separate drivers, and different sensors. Also, the coretemp
reading is not really that exact. Especially at low temperatures it can be quite
a bit off, as far as I remember by 10 degrees C or more. It is more accurate at
very high temperatures.

Also, keep in mind that you have a different chip. pwm3_auto_channels_pwm
means something completely different on the f71882fg. For that chip, it is
not a bit map, but the temperature sensor index. 1..4 in pwmX_auto_channels_pwm
reflects temp[1..4]_input.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
