From: david.c.hubbard@gmail.com (David Hubbard)
Date: Fri, 17 Nov 2006 23:04:18 +0000
Subject: [lm-sensors] w83627ehf informations
Message-Id: <4dfa50520611171504u3e9f268ava25947b0be5c6d07@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1163284779.5555.34.camel@armageddon>
In-Reply-To: <1163284779.5555.34.camel@armageddon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Torsten,

The fix you found below may be interesting.

On 11/17/06, torsten goroll <2crazy4you at gmx.de> wrote:
> Hi David,
>
> it took me a long time, but now I habe a 2.6.19-rc5 kernel runnig. The sensors output looks OK:
>
> w83627ehf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.38 V  (min =  +0.00 V, max =  +1.74 V)
> in1:      +12.25 V  (min =  +2.53 V, max =  +3.01 V) ALARM
> AVCC:      +3.25 V  (min =  +2.19 V, max =  +0.37 V) ALARM
> 3VCC:      +3.25 V  (min =  +0.34 V, max =  +1.34 V) ALARM
> in4:       +1.64 V  (min =  +0.38 V, max =  +0.28 V) ALARM
> in5:       +1.71 V  (min =  +0.04 V, max =  +1.59 V) ALARM
> in6:       +5.50 V  (min =  +2.92 V, max =  +1.51 V) ALARM
> VSB:       +3.25 V  (min =  +2.37 V, max =  +1.68 V) ALARM
> VBAT:      +0.51 V  (min =  +0.50 V, max =  +0.72 V)
> in9:       +1.58 V  (min =  +0.06 V, max =  +0.26 V) ALARM
> Case Fan:  883 RPM  (min =  677 RPM, div = 8)
> CPU Fan:  2295 RPM  (min = 3013 RPM, div = 4) ALARM
> Aux Fan:     0 RPM  (min =   45 RPM, div = 128) ALARM
> fan5:        0 RPM  (min = 23275 RPM, div = 2) ALARM
> Sys Temp:    +27?C  (high =  -115?C, hyst =    -8?C)   ALARM
> CPU Temp:  +21.5?C  (high = +80.0?C, hyst = +75.0?C)
> AUX Temp:  +24.0?C  (high = +80.0?C, hyst = +75.0?C)
>
> But when I trie to run pwm-config I'm getting those (error)messages:
> We will attempt to briefly stop each fan using the pwm controls.
> The program will attempt to restore each fan to full speed
> after testing. However, it is ** very important ** that you
> physically verify that the fans have been to full speed
> after the program has completed.
>
> Found the following PWM controls:
>    9191-0290/pwm1
> /usr/local/sbin/pwmconfig: line 102: echo: write error: Invalid argument
>    9191-0290/pwm2
> /usr/local/sbin/pwmconfig: line 102: echo: write error: Invalid argument
>    9191-0290/pwm3
> /usr/local/sbin/pwmconfig: line 102: echo: write error: Invalid argument
>
> Found the following fan sensors:
>    9191-0290/fan1_input     current speed: 888 RPM
>    9191-0290/fan2_input     current speed: 2311 RPM
>    9191-0290/fan3_input     current speed: 0 ... skipping!
>    9191-0290/fan5_input     current speed: 0 ... skipping!
>
> Warning!!! This program will stop your fans, one at a time,
> for approximately 5 seconds each!!!
> This may cause your processor temperature to rise!!!
> If you do not want to do this hit control-C now!!!
> Hit return to continue:
>
> Testing pwm control 9191-0290/pwm1 ...
>   9191-0290/fan1_input ... speed was 888 now 883
> /usr/local/sbin/pwmconfig: line 102: echo: write error: Invalid argument
>     no correlation
>   9191-0290/fan2_input ... speed was 2311 now 2295
> /usr/local/sbin/pwmconfig: line 102: echo: write error: Invalid argument
>     no correlation
>
> Checking the script I found the error. There must not be spaces in line 102.
> not: echo 0 > $ENABLE
> better:  echo 0>$ENABLE

This is important information. Who maintains the pwmconfig script?
(Jean, I CC'ed you in case you have more information.) Is this a
genuine bug?

>
> But that doesnt solve my problem. The "no correlation message" keeps. Even if I write a 0 into pwmx_enable the fan keeps rotating.
>
> Maybe the board(Asus K8N-VM) does not support fan control? Do you have another idea?

It does not surprise me that the rpm reading is noisy. Can you
manually experiment, now that you have a working kernel and the newest
w83627ehf driver?

Here is one way to manually test the pwm control:

cd /sys # I assume this is where your sysfs is mounted
# I am not at a linux machine, so the next line may be incorrect, but it's close
cd class/hwmon/hwmon0/device

ls # do you see the pwm device files? If you do, then you're in the
correct directory.

echo 1 > pwmX_enable # manual mode
echo 0 > pwmX

Does the fan stop?

echo 255 > pwmX

Does the fan run at full RPM?

Also set several intermediate values. Can you control the fan speed
successfully?

If you would be willing to perform these manual tests, that would
help. I'm at work and can't provide you with the exact directory where
the sysfs files are located, but you should be able to find them by
looking around in /sys/class/hwmon. The last directory will be a
symlink to another place in the sysfs where the files are.

David

