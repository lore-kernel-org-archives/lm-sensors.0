From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Apr 2008 20:41:11 +0000
Subject: Re: [lm-sensors] D201GLY2 Ubuntu 7.10 fan control
Message-Id: <20080412224111.18cde018@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
In-Reply-To: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 13 Apr 2008 01:57:22 +0800, Mini Stac wrote:
> pwmconfig was being run with sudo.
> echo to pwm1_enable and pwm2_enable results in:
>       bash: /sys/class/hwmon/hwmon0/device/pwm1_enable: Permission denied
> pwm1_enable is set at 2, pwm2_enable 1

Beware of sudo, it doesn't play well with shell output redirection.
Please try again (both pwmconfig and the echo tests) without sudo.

> 
> I guess this means its a driver issue? Sensors detect identifies:
>     Driver `w83627ehf' (should be inserted):
>       Detects correctly:
>       * ISA bus, address 0x290
>         Chip `Winbond W83627DHG Super IO Sensors' (confidence: 9)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
