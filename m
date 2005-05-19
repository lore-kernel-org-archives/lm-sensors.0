From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: it87 pwm patch for 2.6.6
Message-Id: <20040612144559.26d594c9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516205100.GA9996@nemo.sby.abo.fi>
In-Reply-To: <20040516205100.GA9996@nemo.sby.abo.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Care to provide a similar fix for 2.4?
> 
> As mentioned on IRC, I think I will stay away from 2.4.

OK, I'll try to take care of this then...

> How's this?
> 
> --- drivers/i2c/chips/lm85.c.orig.2.6.7-rc2	2004-06-08 21:23:07.000000000 +0300
> +++ drivers/i2c/chips/lm85.c	2004-06-08 21:46:21.000000000 +0300
> @@ -153,10 +153,12 @@
>  #define FAN_FROM_REG(val)	((val)=0?-1:(val)=0xffff?0:5400000/(val))
>  
>  /* Temperature is reported in .001 degC increments */
> -#define TEMP_TO_REG(val)		(SENSORS_LIMIT(((val)+500)/1000,-127,127))
> +#define TEMP_TO_REG(val)		(SENSORS_LIMIT(((val)<0?(((val)-500)/1000):\
> +					((val)+500)/1000),-127,127))

That one is OK.

>  #define TEMPEXT_FROM_REG(val,ext)	((val)*1000 + (ext)*250)
>  #define TEMP_FROM_REG(val)		(TEMPEXT_FROM_REG(val,0))
> -#define EXTTEMP_TO_REG(val)		(SENSORS_LIMIT((val)/250,-127,127))
> +#define EXTTEMP_TO_REG(val)		(SENSORS_LIMIT(((val)<0?(((val)-125)/250):\
> +					((val)+125)/250),-127,127))
>  
>  #define PWM_TO_REG(val)			(SENSORS_LIMIT(val,0,255))
>  #define PWM_FROM_REG(val)		(val)
> @@ -290,7 +292,8 @@
>  #define HYST_TO_REG(val) (SENSORS_LIMIT((-(val)+5)/10,0,15))
>  #define HYST_FROM_REG(val) (-(val)*10)
>  
> -#define OFFSET_TO_REG(val) (SENSORS_LIMIT((val)/25,-127,127))
> +#define OFFSET_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-12)/25):\
> +					((val)+13)/25),-127,127))
>  #define OFFSET_FROM_REG(val) ((val)*25)
>  
>  #define PPR_MASK(fan) (0x03<<(fan *2))

But I really wonder about these ones. the /250 makes me guess that the
temperature has a 0.25 degree resolution. So, limiting to -127,+127
means -31 to +31 degrees. It hardly makes sense. Same probably goes for
the /25. Could you please check with the datasheet and code and confirm
whether these -127,+127 limits make sense?

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
