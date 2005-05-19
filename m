From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: lm85 driver of 2.6.1 on Tyan Thunder K8W
Message-Id: <4000ED7B.8000606@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I don't have the 2.6 code handy right now, but I think the setting you 
need to change is the ZONE for the fan.

If the auto fan speed control registers have not been exposed by the 
lm85 driver for 2.6 yet, then you won't have a zone setting and you 
won't be able to change the PWM.  You might take a look at the 2.4 
version of the lm85 driver and extend the driver.

If you do have zone control, then you will probably find the zone is set 
to -1 meaning the PWM is 100% all the time.  Setting it to -2 should 
allow you to control the PWM manually.  See the documentation for other 
zone values and information on how you can have the lm85 change the PWM 
value automatically based on the measured CPU temperatures.

:v)

Frank Pieczynski wrote:

>Hello,
>I'm using kernel 2.6.1 on a Tyan Thunder K8W, with two Opteron 240, in 64bit 
>mode.
>
>The board has to sensor chips, a ADT7463 and a Winbond W83627HF.
>
>I can load the lm85 and lmsensors works via sysfs; sensors show fan speed etc.
>But I cannot control the fans via pwm (I'd like to slow down the system fans 3 
>und 4), the pwmX stay at 255.
>pwm_enableX is at 0. If I try to set it to 1 I get a permission denied (as 
>root: echo 1 > pwm_enable2 ). If I change the permission, the write into 
>pwm_enableX hangs forever.
>The control for the Winbond chip works ok, for that one I can change the pwm 
>values.
>
>What I'm doing wrong?
>
>Thanks
>FRank
>  
>

