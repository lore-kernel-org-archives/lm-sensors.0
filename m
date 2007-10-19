From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Oct 2007 12:47:39 +0000
Subject: Re: [lm-sensors] [PATCH] lm-sensors: update info for SMSC LPC47B357
Message-Id: <20071019144739.54283550@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0710181457h15f781a9o72f767e7f0734168@mail.gmail.com>
In-Reply-To: <191fb4ca0710181457h15f781a9o72f767e7f0734168@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Thu, 18 Oct 2007 14:57:55 -0700, Juerg Haefliger wrote:
> Update the info for the SMSC LPC47B357 in sensors-detect.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

> Index: lm-sensors/prog/detect/sensors-detect
> =================================> --- lm-sensors.orig/prog/detect/sensors-detect	2007-10-18 14:54:16.417255000 -0700
> +++ lm-sensors/prog/detect/sensors-detect	2007-10-18 14:55:16.105166000 -0700
> @@ -1752,8 +1752,8 @@
>  	devid => 0x56,
>        },
>        {
> -	name => "SMSC LPC47B357 Super IO",
> -	# no datasheet
> +	name => "SMSC LPC47B357/M967 Super IO",
> +	driver => "not-a-sensor",
>  	devid => 0x5d,
>        },
>        {

Are you sure of yourself? I've found this article:
http://www.digit-life.com/articles2/roundupmobo/fs-d1627-a-i865pe.html

"System monitoring is supported by the SMSC LPC47M967-NC chip (this
chip (Hardware Monitor + Super I/O) is rarely used, we happened to see
it only on Intel and FIC models). It controls: 

    * processor, AGP bus voltages, +3.3, +5 and +12 V;
    * rotation speed of 2 ordinary fans and one in the power supply
      unit (it requires a special cable connected to the board);
    * temperatures of the processor (built-in sensor), the board
      (built-in sensor) and an external temperature sensor (supplied)."

Could it be that LPC47M967 = LPC47B357 + hardware monitoring?

Of course it's also possible that the article is completely wrong...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
