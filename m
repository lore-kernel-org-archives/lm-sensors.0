From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Date: Wed, 11 Jun 2008 20:24:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (thmc50) Safer device detection
Message-Id: <20080611222422.51e95fbc.krzysztof.h1@poczta.fm>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080611172904.418df3a1@hyperion.delvare>
In-Reply-To: <20080611172904.418df3a1@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 Jun 2008 17:29:04 +0200
Jean Delvare <khali@linux-fr.org> wrote:

>  drivers/hwmon/thmc50.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-2.6.26-rc5.orig/drivers/hwmon/thmc50.c	2008-04-17 04:49:44.000000000 +0200
> +++ linux-2.6.26-rc5/drivers/hwmon/thmc50.c	2008-06-11 17:19:44.000000000 +0200
> @@ -295,7 +295,8 @@ static int thmc50_detect(struct i2c_adap
>  		kind = thmc50;
>  	else if (kind < 0) {
>  		err = -ENODEV;
> -		if (revision >= 0xc0 && ((config & 0x10) = 0)) {
> +		if (revision >= 0xc0 && revision <= 0xdf &&
> +		    (config & 0x10) = 0) {
>  			if (company = 0x49) {

This part of the code will be changed anyway when the support
for the thmc51/adm1028 arrives (to distinguish between 0xc0 and 
0xd0 versions).
I have already started changing the thmc50 driver.

Regards,
Krzysztof


----------------------------------------------------------------------
Podbij Dziki Zachod!Gra strategiczna online
Sprawdz >>> http://link.interia.pl/f1dff


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
