From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Kconfig patch
Message-Id: <20040207201818.6522e689.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've attached small patch for linux/drivers/i2c/busses/Kconfig which
> permit to select "ISA bus" in "I2C hardware bus support" wihout
> selecting "ISA support". It's working, and it can safe few kernel
> bytes.
> (...)
> --- Kconfig.old	2004-02-06 19:02:57.000000000 +0100
> +++ Kconfig	2004-02-07 19:18:27.008230488 +0100
> @@ -112,7 +112,7 @@ config I2C_IOP3XX
>  
>  config I2C_ISA
>  	tristate "ISA Bus support"
> -	depends on I2C && EXPERIMENTAL
> +	depends on EXPERIMENTAL
>  	help
>  	  If you say yes to this option, support will be included for
>  	  i2c interfaces that are on the ISA bus.

Working? You must be kidding. Your patch does not do what you say it
does. And I2C_ISA *does* depend on I2C, although it doesn't depend on
ISA, as previous kernels pretended. I suspect that your patch was meant
to fix that already solved problem.

Let me know if I missed something.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
