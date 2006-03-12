From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 12 Mar 2006 14:56:10 +0000
Subject: [lm-sensors] [PATCH] Add ATI smbus to PIIX4
Message-Id: <20060312155610.429f68e3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4413E4B5.7010202@sh.cvut.cz>
In-Reply-To: <4413E4B5.7010202@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> This patch is just more cleaner version of the earlier. Please test it (who has ATI chipset)
> I did not compile it (lack of time), but I belive it is OK

Compiles fine, but I'd have the following comments:

> --- c-fixhstcfg/Documentation/i2c/busses/i2c-piix4	2006-03-11 21:33:37.000000000 +0100
> +++ d-add-ati/Documentation/i2c/busses/i2c-piix4	2006-03-11 22:22:25.294853000 +0100
> (...)
> +  * ATI IXP southbridges IXP200, IXP300, IXP400
> +    Datasheet: N/A

"N/A" usually stands for "not applicable", which isn't relevant here;
"Not publicly available" would be better.

> --- c-fixhstcfg/drivers/i2c/busses/Kconfig	2006-03-11 21:33:37.000000000 +0100
> +++ d-add-ati/drivers/i2c/busses/Kconfig	2006-03-11 22:18:39.728756000 +0100
> (...)
> -	tristate "Intel PIIX4"
> +	tristate "Intel PIIX4/ATI/Serverworks/Broadcom"

This formulation is a bit confusing, as it suggests that ATI,
Serverwords and Broadcom are chips made by Intel ;) I'd go for "Intel
PIIX4 and compatible".

>  	  If you say yes to this option, support will be included for the Intel
>  	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following
> -	  versions of the chipset are supported (note that Serverworks is part
> -	  of Broadcom):
> +	  versions of the chipset are supported:
>  	    Intel PIIX4
>  	    Intel 440MX
> +	    ATI IXP200
> +	    ATI IXP300
> +	    ATI IXP400
> +	    Broadcom HT-1000
>  	    Serverworks OSB4
>  	    Serverworks CSB5
>  	    Serverworks CSB6
> -	    Serverworks HT-1000
>  	    SMSC Victory66

Please back out the Serverworks vs. Broadcom changes. Not only I don't
see them as useful, but more importantly they don't belong to that
patch.

Otherwise the patch has all I wanted, thanks, good job.

-- 
Jean Delvare

