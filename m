From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 29 May 2005 08:42:39 +0000
Subject: [lm-sensors] RFC PATCH I2C: w83781d: remove non-i2c w83697hf,
Message-Id: <20050529084253.053a7259.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <m21i91l3t8424en9l05pgijanhm1h5es6v@4ax.com>
In-Reply-To: <m21i91l3t8424en9l05pgijanhm1h5es6v@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> This patch removes non-i2c w83697hf, w83627thf sensor chips from the 
> w83781d driver.  Compile tested.

See my comments inline.

>  w83781d.c |   66 ++++++++++++++++++++------------------------------------------
>  1 files changed, 22 insertions(+), 44 deletions(-)

For completeness, your patch should include changes to the documentation
(see Rudolf Marek's recent patches adding it) and Kconfig.

> @@ -998,7 +996,7 @@ w83781d_detect(struct i2c_adapter *adapt
>  		err = -EINVAL;
>  		goto ERROR0;
>  	}
> -	if (!is_isa && kind = w83697hf) {
> +	if (!is_isa) {
>  		dev_err(&adapter->dev,
>  			"Cannot force ISA-only chip for I2C address 0x%02x.\n",
>  			address);

This change isn't correct. After your changes, there won't be any
ISA-only chip left (that's the whole point actually), so this check can
be removed entirely.

> @@ -1160,15 +1156,10 @@ w83781d_detect(struct i2c_adapter *adapt
>  		client_name = "w83782d";
>  	} else if (kind = w83783s) {
>  		client_name = "w83783s";
> -	} else if (kind = w83627hf) {
> -		if (val1 = 0x90)
> -			client_name = "w83627thf";
> -		else
> -			client_name = "w83627hf";
> +	} else if (kind = w83627hf && val1 != 0x90) {
> +		client_name = "w83627hf";
>  	} (...)

This ain't correct. If a W83627THF chip is found, instead of being
discarded, it will be detected, but then won't get a client_name. That's
obviously not what we want. We want W83627THF chips not to be recognized
at all.

Please submit an updated patch addressing these issues.

Thanks,
-- 
Jean Delvare
