From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: adm1026 driver port for kernel 2.6.X - [REVISED DRIVER]
Message-Id: <20041102203122.7e7a8366.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041025210057.GB19053@penguincomputing.com>
	<GNXY8AG6.1098776962.4770080.khali@gcu.info>
	<20041029191229.GB803@penguincomputing.com>
	<20041102164642.GA16378@penguincomputing.com>
In-Reply-To: <20041102164642.GA16378@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>

Hi justin,

> As discussed in previous messages, control over the pwm output is
> provided via:
> 
> pwm1                  {0-255}
> pwm1_auto_pwm_min     {0-255}

What exactly does this value represent again? (See below too.)

> pwm1_enable           {0-2}  (off, manual, automatic fan control)
> 
> Access to the DAC is provided via:
> 
> analog_out            {0-2500} (millivolts)
> 
> No way is currently provided to turn on DAC-mediated automatic fan
> control. See my previous email in this thread for the reasons why.

On a side note, MBM lists the ADM1026 as being used on only two
motherboard models, one being yours. Considering this and the fact that
nobody ever requested us to port the adm1026 driver to Linux 2.6, I
would conclude that the motherboard you use is possibly the only one
worth supporting. Do not bother with anything that you don't personally
need. We can still add it later on request.

> Control over automatic fan "on" temperatures are provided by:
> 
> temp[1-3]_auto_point1_temp     {-128000 - 127000}
> 
> Hardware-determined hysteresis and range values are revealed in:
> 
> temp[1-3]_auto_point1_temp_hyst   {-6000}

Hysteresis temperatures have to be absolute temperatures as per
interface standard.

> temp[1-3]_auto_point2_temp        {temp[1-3]_auto_point1_temp + 20000}

I'm a bit surprised not to see temp[1-3]_auto_point[1-2]_pwm. Trip
points are supposed to be (temp, pwm) pairs. Doesn't pwm1_auto_pwm_min
above correspond to one or more of these?

> Failsafe critical temperatures at which the fans go to maximum speed
> are controled via:
> 
> temp_crit_enable       {0-1}  (off, on)
> temp[1-3]_crit         {-128000 - 127000}

Granted it's not part of the standard yet, but you would have three
files temp[1-3]_crit_enable if we stick to our chip-indenpendent
interface logic. Either make 1 read-write and [2-3] read-only, or make
all read-write and each one changes the three values.

> These values override any values set for the pwm-mediated automatic
> fan control.

Doesn't this mean that you could integrate these in the auto-pwm
interface as point3?

> Thanks to all for the feedback.

You're welcome. Sorry to ask questions about the proposed interface
again, I just want things to be as clean and logical as possible.

Thanks,

-- 
Jean Delvare
http://khali.linux-fr.org/
