From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [patch] fscpos driver
Message-Id: <20050120184119.75975ffa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050104185338.3296d72d.khali@linux-fr.org>
In-Reply-To: <20050104185338.3296d72d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stefan,

> As I was using the old sensor lib I didn't realize my inN_input values
> were using the wrong units. Sorry for this.
> 
> Signed-off-by: Stefan Ott <stefan@xxxxxxxxx>
> 
> --- fscpos.c-orig	2005-01-20 18:21:01.000000000 +0100
> +++ fscpos.c	2005-01-20 18:21:33.000000000 +0100
> @@ -239,7 +239,7 @@
>  }
>  
>  /* Volts */
> -#define VOLT_FROM_REG(val, mult)	((val) * (mult) / 255)
> +#define VOLT_FROM_REG(val, mult)	(((val) * (mult) / 255) * 10)
>  
>  static ssize_t show_volt_12(struct device *dev, char *buf)
>  {
> 

Hmm, wouldn't it more efficient to multiply all "mult" constants by 10
directly?

-- 
Jean Delvare
http://khali.linux-fr.org/
