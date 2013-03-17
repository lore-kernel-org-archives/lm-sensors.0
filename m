From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 17 Mar 2013 06:44:16 +0000
Subject: Re: [lm-sensors] IT8771E
Message-Id: <20130317064416.GD32694@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJDbZnQ-rGoUL+5F=e8cWD9Q8JQd+RXZ9ec=J8PC+8SE9P+=Cg@mail.gmail.com>
In-Reply-To: <CAJDbZnQ-rGoUL+5F=e8cWD9Q8JQd+RXZ9ec=J8PC+8SE9P+=Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 17, 2013 at 02:05:05PM +0800, Ross Moore wrote:
> Here is the output of pwmconfig - I was noting the pwm and fan are on the
> same chip; perhaps they always are. But note the correlation plots in here.
> It seems pwm is controlling the fans in any kind of consistent manner
> (although clearly there is a link):
> 
> # pwmconfig revision 5857 (2010-08-22)
> This program will search your sensors for pulse width modulation (pwm)
> controls, and test each one to see if it controls a fan on
> your motherboard. Note that many motherboards do not have pwm
> circuitry installed, even if your sensor chip supports pwm.
> 
> We will attempt to briefly stop each fan using the pwm controls.
> The program will attempt to restore each fan to full speed
> after testing. However, it is ** very important ** that you
> physically verify that the fans have been to full speed
> after the program has completed.
> 
> Found the following devices:
>    hwmon0 is acpitz
>    hwmon1/device is coretemp
>    hwmon2/device is it8771
>    hwmon3 is asus
> 
> Found the following PWM controls:
>    hwmon2/device/pwm1
>    hwmon2/device/pwm2
>    hwmon2/device/pwm3
> 
> Giving the fans some time to reach full speed...
> Found the following fan sensors:
>    hwmon2/device/fan1_input     current speed: 2227 RPM
>    hwmon2/device/fan2_input     current speed: 1211 RPM
> 
> Warning!!! This program will stop your fans, one at a time,
> for approximately 5 seconds each!!!
> This may cause your processor temperature to rise!!!
> If you do not want to do this hit control-C now!!!
> Hit return to continue:
> 
> Testing pwm control hwmon2/device/pwm1 ...
>   hwmon2/device/fan1_input ... speed was 2227 now 1115
>     It appears that fan hwmon2/device/fan1_input
>     is controlled by pwm hwmon2/device/pwm1
> Would you like to generate a detailed correlation (y)? y
> Note: If you had gnuplot installed, I could generate a graphical plot.
>     PWM 255 FAN 1256
>     PWM 240 FAN 1149
>     PWM 225 FAN 1256
>     PWM 210 FAN 1388
>     PWM 195 FAN 1599
>     PWM 180 FAN 1795
>     PWM 165 FAN 1739
>     PWM 150 FAN 1683
>     PWM 135 FAN 1562
>     PWM 120 FAN 1490
>     PWM 105 FAN 1400
>     PWM 90 FAN 1313
>     PWM 75 FAN 1250
>     PWM 60 FAN 1194
>     PWM 45 FAN 1121
>     PWM 30 FAN 1112
>     PWM 28 FAN 1113
>     PWM 26 FAN 1112
>     PWM 24 FAN 1112
>     PWM 22 FAN 1113
>     PWM 20 FAN 1112
>     PWM 18 FAN 1112
>     PWM 16 FAN 1113
>     PWM 14 FAN 1112
>     PWM 12 FAN 1113
>     PWM 10 FAN 1112
>     PWM 8 FAN 1113
>     PWM 6 FAN 1112
>     PWM 4 FAN 1112
>     PWM 2 FAN 1112
>     PWM 0 FAN 1112
> 
>   hwmon2/device/fan2_input ... speed was 1211 now 1207
>     no correlation
> 
> Testing pwm control hwmon2/device/pwm2 ...
>   hwmon2/device/fan1_input ... speed was 2227 now 2419
>     no correlation
>   hwmon2/device/fan2_input ... speed was 1211 now 0
>     It appears that fan hwmon2/device/fan2_input
>     is controlled by pwm hwmon2/device/pwm2
> Would you like to generate a detailed correlation (y)? y
> Note: If you had gnuplot installed, I could generate a graphical plot.
>     PWM 255 FAN 548
>     PWM 240 FAN 258
>     PWM 225 FAN 360 (probably incorrect)
>     PWM 210 FAN 547 (probably incorrect)
>     PWM 195 FAN 734 (probably incorrect)
>     PWM 180 FAN 891 (probably incorrect)
>     PWM 165 FAN 903 (probably incorrect)
>     PWM 150 FAN 853 (probably incorrect)
>     PWM 135 FAN 791 (probably incorrect)
>     PWM 120 FAN 724 (probably incorrect)
>     PWM 105 FAN 651 (probably incorrect)
>     PWM 90 FAN 573 (probably incorrect)
>     PWM 75 FAN 485 (probably incorrect)
>     PWM 60 FAN 382 (probably incorrect)
>     PWM 45 FAN 188
>     PWM 30 FAN 0
>     Fan Stopped at PWM = 30
>
Seems to be ok to me, except the system doesn't seem to like pwm values
above 165 or doesn't measure fan speed correctly for those values.
Does the fan get faster when the script sets pwm values above 165 ?

So you can control fan1 with pwm1, and fan2 with pwm2.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
