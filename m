From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 17 Feb 2006 10:59:04 +0000
Subject: [lm-sensors] [2.6.15 PATCH] i2c-pxa.c:LICENSE("GPL")
Message-Id: <2bCqFT6N.1140173944.2695670.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0602170953070.1049@pcgl.dsa-ac.de>
In-Reply-To: <Pine.LNX.4.63.0602170953070.1049@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Guennadi,

On 2006-02-17, Guennadi Liakhovetski wrote:
> I guess, it was just an accidental omission.
> (...)
> diff -u a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> --- a/drivers/i2c/busses/i2c-pxa.c	12 Jan 2006 16:28:19 -0000
> +++ b/drivers/i2c/busses/i2c-pxa.c	17 Feb 2006 08:52:40 -0000
> @@ -1026,3 +1026,5 @@
>
>   module_init(i2c_adap_pxa_init);
>   module_exit(i2c_adap_pxa_exit);
> +
> +MODULE_LICENSE("GPL");

Indeed, but it's already fixed in 2.6.16-rc1. Thanks for reporting
though.

--
Jean Delvare

