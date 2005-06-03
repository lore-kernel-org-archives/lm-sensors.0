From: Huang0@winbond.com.tw (Huang0@winbond.com.tw)
Date: Fri, 03 Jun 2005 03:51:12 +0000
Subject: [lm-sensors] W83792 review and testing
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE550143@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <429D7565.4090203@sh.cvut.cz>
In-Reply-To: <429D7565.4090203@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf


> Thermal cruise
> --------------
> 
> At this mode, W83792D provides the Smart Fan system to automatically
control
> fan speed to keep the temperatures of CPU and the system within
specific
> range. At first a wanted temperature and interval must be set. This is
done
> via thermal_cruise# file. The tolerance# file serves to create T +-
tolerance
> interval. The fan speed will be lowered as long as the current
temperature
> remains below the thermal_cruise# +- tolerance# value. Once the
temperature
> exceeds the high limit (T+tolernace), the fan will be turned on with a
> specific speed set by pwm# and automatically controlled its PWM duty
cycle
> with the temperature varying. Three conditions may occur:

Your comprehension is correct, I test it just now on your suggestion:
If I set pwm2_enable into thermal cruise mode first,
then set the thermal_cruise2 into a low value such as 25(degree), the
pwm2
will decrease automatically step by step.

On the other hand, if I set the thermal_cruise2 into a large value such
as
42(degree) under thermal cruise mode, the pwm2 will increase step by
step,
If the set thermal_cruise2 is very larger such as 80(degree), the
increase
of pwm2 may be very quickly, for example, from 9 into 15(full) in ONE
step.


Thanks
Best Regards
Chunhao

