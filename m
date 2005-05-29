From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 29 May 2005 10:43:09 +0000
Subject: [lm-sensors] RFC PATCH I2C: w83781d: remove non-i2c w83697hf,
Message-Id: <20050529104320.534212b5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <m21i91l3t8424en9l05pgijanhm1h5es6v@4ax.com>
In-Reply-To: <m21i91l3t8424en9l05pgijanhm1h5es6v@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> >.. and Kconfig.
> 
> I can't see what needs changing?  w83627thf and w83697hf not
> mentioned under w83781d entry and w83627hf still valid i2c choice?
> Or me blind?

No, you're correct. I assumed that the Kconfig entry was up-to-date and
would need to be modified, but it happens not to be. That's even better,
that way we remove support that wasn't officially existing ;)

> appended, if I'm okay here I'll look at the documentation, submit 
> again fresh subject.

Minor nitpicking:

> @@ -998,14 +996,6 @@ w83781d_detect(struct i2c_adapter *adapt
>  		err = -EINVAL;
>  		goto ERROR0;
>  	}
> -	if (!is_isa && kind = w83697hf) {
> -		dev_err(&adapter->dev,
> -			"Cannot force ISA-only chip for I2C address 0x%02x.\n",
> -			address);
> -		err = -EINVAL;
> -		goto ERROR0;
> -	}
> -	
>  	if (is_isa)
>  		if (!request_region(address, W83781D_EXTENT,
>  				    w83781d_driver.name)) {

I wouldn't kill that innocent blank line.

Rest looks all OK to me.

Thanks,
-- 
Jean Delvare
