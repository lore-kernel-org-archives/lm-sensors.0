From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 09 Jan 2011 20:56:12 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon (dme1737): add support for in7
Message-Id: <20110109215612.2442513c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Thu, 16 Dec 2010 11:19:37 +0100, Juerg Haefliger wrote:
> This patch adds support for the 1.5V voltage monitoring input (in7) of
> the SMSC SCH5127 chip.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

Looks very good, and thanks for updating the documentation too. Minor
comments on that part:

> Index: linux-2.6.36/Documentation/hwmon/dme1737
> =================================> --- linux-2.6.36.orig/Documentation/hwmon/dme1737	2010-12-10 10:29:14.552904312 +0100
> +++ linux-2.6.36/Documentation/hwmon/dme1737	2010-12-10 10:32:25.072431720 +0100
> @@ -42,7 +42,7 @@
>  This driver implements support for the hardware monitoring capabilities of the
>  SMSC DME1737 and Asus A8000 (which are the same), SMSC SCH5027, SCH311x,
>  and SCH5127 Super-I/O chips. These chips feature monitoring of 3 temp sensors
> -temp[1-3] (2 remote diodes and 1 internal), 7 voltages in[0-6] (6 external and
> +temp[1-3] (2 remote diodes and 1 internal), 8 voltages in[0-7] (7 external and

It would be more correct to write: "up to 8 voltages", as most chips
only have 7.

>  1 internal) and up to 6 fan speeds fan[1-6]. Additionally, the chips implement

1 internal only, really? Aren't VTR (+3.3V standby) and Vbat internal
too? I thought they were used as power sources for the chip itself.

>  up to 5 PWM outputs pwm[1-3,5-6] for controlling fan speeds both manually and
>  automatically.

I've applied your patch nevertheless, as it is good enough as is.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
