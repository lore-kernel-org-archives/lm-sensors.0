From: darxus@chaosreigns.com
Date: Wed, 28 Jan 2015 17:09:38 +0000
Subject: [lm-sensors] Making the pwmcontrol UI a little easier, and delays
Message-Id: <20150128170938.GD31900@chaosreigns.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Last night I spent a couple hours fighting with this:
https://bugs.launchpad.net/ubuntu/+source/lm-sensors/+bug/485899
The bug is five years old, and six other people took the time to log in and
click that it affected them.  But the pwmcontrol script was working fine,
we were all just doing the wrong thing.  After hours of adding echos to
pwmcontrol to figure out what was going on, I realized the problem was
here:

Select fan output to configure, or other action:
1) hwmon0/device/pwm3 3) Change INTERVAL 5) Save and quit
2) hwmon0/device/pwm2 4) Just quit 6) Show configuration
select (1-n): 5

None of the seven of us realized we still needed to hit "1" or "2" and do
some more configuration.  We thought it was all automatic, and we were
done, and we just needed to save.

So I'd suggest adding a line of text clearing that up.  Maybe "You need to
select a PWM control and finish configuring it."  

And maybe even throw an error or something if somebody tries to save the
config without having done that, to avoid writing a config with all blank
values.


Also, the delays in pwmconfig weren't giving one of my fans enough time to
adjust.  Mostly because it slowed down (possibly stopped) right at the
beginning, and then didn't have time to get up to full speed (I think in 2
seconds?).  I think, in my case, it was worth changing both delays to 10
seconds:

diff pwmconfig.0 pwmconfig
64c64
< DELAY=5 # 3 seconds delay is too short for large fans, thus I increased it to 5
---
> DELAY # 3 seconds delay is too short for large fans, thus I increased it to 5
320c320,321
< PDELAY=2
---
> #PDELAY=2
> PDELAY


With the default delays, I get (with the fan that came with an AMD Phenom
II X4 965):

Would you like to generate a detailed correlation (y)? 
Would you like to generate a graphical plot using gnuplot (y)? 
    PWM 255 FAN 2393
    PWM 240 FAN 2800
    PWM 225 FAN 3792 (probably incorrect)
    PWM 210 FAN 4354 (probably incorrect)
    PWM 195 FAN 4115 (probably incorrect)
    PWM 180 FAN 3947 (probably incorrect)
    PWM 165 FAN 3729 (probably incorrect)
    PWM 150 FAN 3534 (probably incorrect)
    PWM 135 FAN 3308
    PWM 120 FAN 3125
...


With 10 second delays, I get:

Would you like to generate a detailed correlation (y)? 
Would you like to generate a graphical plot using gnuplot (y)? 
    PWM 255 FAN 4720
    PWM 240 FAN 4560
    PWM 225 FAN 4383
    PWM 210 FAN 4192
    PWM 195 FAN 3994
    PWM 180 FAN 3813
    PWM 165 FAN 3648
    PWM 150 FAN 3479
    PWM 135 FAN 3308
    PWM 120 FAN 3110
...

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
