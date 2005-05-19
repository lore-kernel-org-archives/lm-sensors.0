From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: smartbatt
Message-Id: <3F5B53B2.67B33991@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.50.0308211355310.11405-200000@shenendoah.appalachian.home>
In-Reply-To: <Pine.LNX.4.50.0308211355310.11405-200000@shenendoah.appalachian.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I looked back and saw that I wrote smartbatt.c almost a year ago, not
two months ago :) !
Since you've obviously tested it and I never did I can't really argue
with
anything you did, other than your change from normal_i2c to
normal_i2c_range is
not correct.  _range is used only for ranges (pairs of addresses).

And of course prog/sensors/xxx needs work :)


jklaas wrote:
> 
> Here's my patch against the CVS from August 19.  I ran patch on this file
> agains the today's CVS (from about 10-15 minutes ago) and it didn't
> complain (aside from some offsets).  I would also welcome any comments
> about my coding capability and style.
> 
> ===================================> 
> diff -u2 -r lm_sensors2.old/kernel/chips/smartbatt.c lm_sensors2.new/kernel/chips/smartbatt.c
> --- lm_sensors2.old/kernel/chips/smartbatt.c    2003-06-22 19:55:05.000000000 +0200
> +++ lm_sensors2.new/kernel/chips/smartbatt.c    2003-08-22 16:20:03.000000000 +0200
> @@ -34,6 +34,6 @@
> 
>  /* Addresses to scan */
> -static unsigned short normal_i2c[] = { 0x0b, SENSORS_I2C_END };
> -static unsigned short normal_i2c_range[] = { SENSORS_I2C_END };
> +static unsigned short normal_i2c[] = { SENSORS_I2C_END };
> +static unsigned short normal_i2c_range[] = { 0x0b, SENSORS_I2C_END };
>  static unsigned int normal_isa[] = { SENSORS_ISA_END };
>  static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
