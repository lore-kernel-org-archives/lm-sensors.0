From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Apr 2008 17:54:04 +0000
Subject: Re: [lm-sensors] D201GLY2 Ubuntu 7.10 fan control
Message-Id: <20080409195404.39e1dfa0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
In-Reply-To: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 7 Apr 2008 08:37:44 +0800, Mini Stac wrote:
> I would like to get fan control working, but when running pwmconfig, I get
> the following message:
> 
> Found the following devices:
>    hwmon0/device is w83627dhg
> 
> Found the following PWM controls:
>    hwmon0/device/pwm1
> hwmon0/device/pwm1_enable stuck to 2
> Failed to set pwmhwmon0/device/pwm1 to full speed
> Something's wrong, check your fans!
> 
> 
> There is no fan control options that can be set in BIOS, however using
> Speefan under Windows I was able to control the Case fan speed although CPU
> fan speed is fixed.
> I installed lm-sensors v2.10.4 using Synaptic. Sensors shows fan speeds for
> both case and cpu. I tried reloading the driver with modprobe using
> reset/init but seems these parameters are not supported for this driver.

Which kernel version are you using?

Note that pwmconfig was improved a lot in lm-sensors 2.10.6, so you
could try this and see if it helps. This is a standalone script, so you
don't have to install anything to test it, just grab the lm-sensors
2.10.6 (or 3.0.1) source package [1], unpack it and run pwmconfig in
place.

[1] http://dl.lm-sensors.org/lm-sensors/releases/

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
