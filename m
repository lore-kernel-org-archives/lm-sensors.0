From: "M.Kiesel" <mayne@users.sourceforge.net>
Date: Sun, 31 Oct 2010 15:54:46 +0000
Subject: [lm-sensors] pwmconfig problems/Gigabyte hiccups + fix
Message-Id: <alpine.DEB.2.00.1010311604090.24751@bluebox.conspiracy.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

I see some problems with the pwmconfig script on several of my machines. 
Gigabyte AMD mainboards, 12cm fans.
Detailed correlations and stop values are not figured out properly in 
pwmconfig. A log is at the bottom of this mail.

Testing a bit, it looks like the boards (tested mostly with a Gigabyte 
GA-MA78GM-S2H) hiccup when re-enabling pwm. These three stops produce the 
hiccup:
# echo -n 1 > /sys/class/hwmon/hwmon1/device/pwm1_enable ; echo -n 0 > /sys/class/hwmon/hwmon1/device/pwm1
(fan stops as expected)
# echo -n 0 > /sys/class/hwmon/hwmon1/device/pwm1_enable
(fan spins up again)
# echo -n 1 > /sys/class/hwmon/hwmon1/device/pwm1_enable ; echo -n 255 > /sys/class/hwmon/hwmon1/device/pwm1
(fan stops (!), then takes ~10 secs to go to full speed again)

In case 255 is written to pwm1 *before* disabling pwm, everything works 
fine.
Writing 255 to pwm1 *while* pwm is disabled does *not* fix the hiccup.

Moving "echo $MAX > $1" to the top of the pwmdisable() function fixes the 
problem for me.

Jean, could you commit that to pwmconfig?

Regards
Kiesel


Testing pwm control hwmon1/device/pwm1 ...
   hwmon1/device/fan1_input ... speed was 2303 now 0
     It appears that fan hwmon1/device/fan1_input
     is controlled by pwm hwmon1/device/pwm1
Would you like to generate a detailed correlation (y)? y
Would you like to generate a graphical plot using gnuplot (y)? n
>>>> fan stops, then starts again, FAN is read during spin-up
     PWM 255 FAN 738
     PWM 240 FAN 1033 (probably incorrect)
     PWM 225 FAN 1704 (probably incorrect)
     PWM 210 FAN 2198 (probably incorrect)
     PWM 195 FAN 2102 (probably incorrect)
     PWM 180 FAN 1985 (probably incorrect)
     PWM 165 FAN 1844 (probably incorrect)
     PWM 150 FAN 1704 (probably incorrect)
     PWM 135 FAN 1551 (probably incorrect)
     PWM 120 FAN 1403 (probably incorrect)
     PWM 105 FAN 1227 (probably incorrect)
     PWM 90 FAN 1054 (probably incorrect)
     PWM 75 FAN 850
     PWM 60 FAN 417
     PWM 45 FAN 0
     Fan Stopped at PWM = 45
>>>> snip, configure config file...
Enter the minimum PWM value (0-255)
at which the fan STOPS spinning (press t to test) (100): t

Now we decrease the PWM value to figure out the lowest usable value.
We will use a slightly greater value as the minimum speed.
>>>> again, fan stops and re-starts, fan speed is read during spin-up
     PWM 255 -> 1046 RPM
     PWM 240 -> 1577 RPM (probably incorrect)
OK, using 255

Enter the minimum PWM value (255-255)
at which the fan STARTS spinning (press t to test) (150):

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
