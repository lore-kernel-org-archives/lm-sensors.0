From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 05 Feb 2008 21:24:14 +0000
Subject: Re: [lm-sensors] pwmconfig with k8temp
Message-Id: <20080205222414.5a822154@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47A27D33.2080805@gmx.de>
In-Reply-To: <47A27D33.2080805@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Heinz,

Please keep the lm-sensors list in Cc.

On Tue, 05 Feb 2008 02:58:49 +0100, Heinz Schuster wrote:
> I have tested your pwmconfig-version (lm-sensors 3.0.1) and its the same 
> proplem.
> 
> http://www.lm-sensors.org/browser/lm-sensors/tags/V3-0-1/prog/pwm/pwmconfig?format=raw
> 
> In this Version i have changed the line 228:  
> 
> *original:
> *
>         pwmdisable $i
>         if [ $? -ne 0 ]
>         then
>             echo "Manual control mode not supported, skipping $i."
>         elif [ "$GOODPWM" = "" ]
>         then
>             GOODPWM=$i
>         else
>             GOODPWM="$GOODPWM $i"
>         fi
>     else
>         NOTROOT=1
>     fi
> done
> 
> 
> *my change:
> *
> 
>         pwmdisable $i
>         if [ $? -ne 1 ]
>         then
>             echo "Manual control mode not supported, skipping $i."
>         elif [ "$GOODPWM" = "" ]
>         then
>             GOODPWM=$i
>         else
>             GOODPWM="$GOODPWM $i"
>         fi
>     else
>         NOTROOT=1
>     fi
> done
> 
> /*The outputs:
> 
> */*original:
> 
> *This program will search your sensors for pulse width modulation (pwm)
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
>    hwmon0/device is k8temp
>    hwmon1/device is w83627ehf
> 
> Found the following PWM controls:
>    hwmon1/device/pwm1
> hwmon1/device/pwm1 stuck to 0
> Manual control mode not supported, skipping hwmon1/device/pwm1.
>    hwmon1/device/pwm2
> hwmon1/device/pwm2 stuck to 0
> Manual control mode not supported, skipping hwmon1/device/pwm2.
>    hwmon1/device/pwm3
> hwmon1/device/pwm3 stuck to 0
> Manual control mode not supported, skipping hwmon1/device/pwm3.
> There are no usable PWM outputs.
> 
> 
> *after my change:
> *
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
>    hwmon0/device is k8temp
>    hwmon1/device is w83627ehf
> 
> Found the following PWM controls:
>    hwmon1/device/pwm1
> hwmon1/device/pwm1 stuck to 0
>    hwmon1/device/pwm2
> hwmon1/device/pwm2 stuck to 0
>    hwmon1/device/pwm3
> hwmon1/device/pwm3 stuck to 0
> 
> Giving the fans some time to reach full speed...
> Found the following fan sensors:
>    hwmon1/device/fan1_input     current speed: 1622 RPM
>    hwmon1/device/fan2_input     current speed: 1288 RPM
>    hwmon1/device/fan3_input     current speed: 0 ... skipping!
>    hwmon1/device/fan5_input     current speed: 0 ... skipping!
> 
> Warning!!! This program will stop your fans, one at a time,
> for approximately 5 seconds each!!!
> This may cause your processor temperature to rise!!!
> If you do not want to do this hit control-C now!!!
> Hit return to continue:
> 
> Now its runs normally.

What do you mean by "runs normally"? According to the error messages
above, the pwm controls are stuck to 0, so they won't actually control
anything. Thus I suspect that pwmconfig then doesn't find any
correlation. You changed the script to ignore the error, but I fail to
see what good it is doing, as the root problem is still there.

I am curious why the w83627ehf driver fails to set the pwm values. I
have such a chip here and I've been testing pwmconfig on it and it
works just fine. What kernel version is this? Can you please provide
the output of:

(cd /sys/class/hwmon/hwmon1/device && grep . pwm*)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
