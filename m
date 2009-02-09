From: Mark Nienberg <gmane@tippingmar.com>
Date: Mon, 09 Feb 2009 18:47:04 +0000
Subject: Re: [lm-sensors] fan control questions
Message-Id: <gmptn9$t4q$1@ger.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <glni7k$fut$1@ger.gmane.org>
In-Reply-To: <glni7k$fut$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Well I tried a few more things and I think I am going to have to give up on this. 
Here is some of the output from pwmconfig.  As you can see, it found 3 pwm controls 
and they are on the same device as the fans speed monitors, so it seems promising.  I 
also added a fan and moved it around so that I tested almost all of the fan 
connectors.  And the first time I ran pwmconfig, it correctly detected that the 3 pwm 
controls were in automatic mode (enabled fan control in the bios), so they seem to be 
the correct ones.  Only problem is that pwmconfig does not have any effect on the fan 
speed.  I'm leaning toward concluding that fan control won't work on this board.



Found the following devices:
    hwmon0/device is w83792d

Found the following PWM controls:
    hwmon0/device/pwm1
    hwmon0/device/pwm2
    hwmon0/device/pwm3

Giving the fans some time to reach full speed...
Found the following fan sensors:
    hwmon0/device/fan1_input     current speed: 4218 RPM
    hwmon0/device/fan2_input     current speed: 2109 RPM
    hwmon0/device/fan3_input     current speed: 0 ... skipping!
    hwmon0/device/fan4_input     current speed: 5273 RPM
    hwmon0/device/fan5_input     current speed: 740 RPM
    hwmon0/device/fan7_input     current speed: 0 ... skipping!

Warning!!! This program will stop your fans, one at a time,
for approximately 5 seconds each!!!
This may cause your processor temperature to rise!!!
If you do not want to do this hit control-C now!!!
Hit return to continue:

Testing pwm control hwmon0/device/pwm1 ...
   hwmon0/device/fan1_input ... speed was 4218 now 4440
     no correlation
   hwmon0/device/fan2_input ... speed was 2109 now 2136
     no correlation
   hwmon0/device/fan4_input ... speed was 5273 now 5192
     no correlation
   hwmon0/device/fan5_input ... speed was 740 now 727
     no correlation

No correlations were detected.
There is either no fan connected to the output of hwmon0/device/pwm1,
or the connected fan has no rpm-signal connected to one of
the tested fan sensors. (Note: not all motherboards have
the pwm outputs connected to the fan connectors,
check out the hardware database on http://www.almico.com/forumindex.php)

Did you see/hear a fan stopping during the above test (n)?



-- 
Mark Nienberg
Sent from an invalid address. Please reply to the group.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
