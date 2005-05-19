From: afe0108@yahoo.com (*)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: support for ivtv drivers?
Message-Id: <20030731000810.22806.qmail@web41802.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030722041815.57457.qmail@web41801.mail.yahoo.com>
In-Reply-To: <20030722041815.57457.qmail@web41801.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, sorry for the late reply.  I wanted to report that this patch
works beautifully with 2.4.21!  I tried with 2.6.0-test2 and it
wouldn't compile but at least I can use the latest lm_sensors now.
Maybe I will inquire about 2.6 support on the ivtv list.

Thanks again,
Jonah


--- Jean Delvare <khali@linux-fr.org> wrote:
> 
> > Hello, thanks for your work on i2c!  I have a driver request for i2c
> > 2.8.0, when you have the time to work on it, or if enough other people
> > request it.  It's for the ivtv drivers, which are for the WinTV
> > PVR-250(TV card with hardware decoding) which are also used by MythTV:
> > 
> > http://ivtv.sourceforge.net/
> > http://sourceforge.net/projects/ivtv/
> 
> Patch attached. Note that this patch ports the driver for use with a
> 2.4.21 kernel with the i2c-2.8.0 subsystem. It is *not* meant for Linux
> 2.5/2.6. You can still try, but I fear much more work would be needed
> (and this is *not* our job, it is the driver author's one).
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
> > diff -ru ivtv-orig/driver/ivtv-i2c.c ivtv-i2c/driver/ivtv-i2c.c
> --- ivtv-orig/driver/ivtv-i2c.c	Thu Jul 24 05:48:55 2003
> +++ ivtv-i2c/driver/ivtv-i2c.c	Thu Jul 24 17:06:53 2003
> @@ -41,14 +41,13 @@
>  }
>  
>  static struct i2c_adapter ivtv_i2c_adapter_template = {
> -        "ivtv i2c driver",	/*name*/
> -        I2C_HW_B_BT848,		/*id?? (algo-bit is OR'd with this)*/
> -        NULL, 			/*algorighm (set by i2c-algo-bit)*/
> -        NULL,		 	/*algodata, filled from template*/
> -        ivtv_i2c_inc, 		/*inc usage*/
> -        ivtv_i2c_dec, 		/*dec usage*/
> -	client_register:	attach_inform,
> -	client_unregister:	detach_inform,
> +	.owner = THIS_MODULE,
> +	.name = "ivtv i2c driver",
> +	.id = I2C_HW_B_BT848, /*algo-bit is OR'd with this*/
> +	.algo = NULL, /*set by i2c-algo-bit*/
> +	.algo_data = NULL, /*filled from template*/
> +	.client_register = attach_inform,
> +	.client_unregister = detach_inform,
>  };
>  
>  static struct i2c_algo_bit_data ivtv_i2c_algo_template = {
> @@ -175,16 +174,6 @@
>  	}
>  
>  	return 0;
> -}
> -
> -void ivtv_i2c_inc(struct i2c_adapter *adapter) {
> -	IVTV_DEBUG(IVTV_DEBUG_I2C, "i2c increasing usage count\n");
> -	MOD_INC_USE_COUNT;
> -}
> -
> -void ivtv_i2c_dec(struct i2c_adapter *adapter) {
> -	IVTV_DEBUG(IVTV_DEBUG_I2C, "i2c decreasing usage count\n");
> -	MOD_DEC_USE_COUNT;
>  }
>  
>  /* init + register i2c algo-bit adapter */
> diff -ru ivtv-orig/driver/saa7115.c ivtv-i2c/driver/saa7115.c
> --- ivtv-orig/driver/saa7115.c	Thu Jul 24 05:16:53 2003
> +++ ivtv-i2c/driver/saa7115.c	Thu Jul 24 17:02:02 2003
> @@ -958,22 +958,6 @@
>  
>  /* -----------------------------------------------------------------------
> */
>  
> -static void
> -saa7114_inc_use (struct i2c_client *client)
> -{
> -#ifdef MODULE
> -	MOD_INC_USE_COUNT;
> -#endif
> -}
> -
> -static void
> -saa7114_dec_use (struct i2c_client *client)
> -{
> -#ifdef MODULE
> -	MOD_DEC_USE_COUNT;
> -#endif
> -}
> -
>  /*
>   * Generic i2c probe
>   * concerning the addresses: i2c wants 7 bit (without the r/w bit), so '>>1'
> @@ -1094,6 +1078,7 @@
>  /* -----------------------------------------------------------------------
> */
>  
>  struct i2c_driver i2c_driver_saa7114 = {
> +	.owner = THIS_MODULE,
>  	.name = "saa7115",
>  
>  	.id = I2C_DRIVERID_SAA7114,
> @@ -1102,8 +1087,6 @@
>  	.attach_adapter = saa7114_attach_adapter,
>  	.detach_client = saa7114_detach_client,
>  	.command = saa7114_command,
> -	.inc_use = saa7114_inc_use,
> -	.dec_use = saa7114_dec_use,
>  };
>  
>  EXPORT_NO_SYMBOLS;
> diff -ru ivtv-orig/driver/saa7127.c ivtv-i2c/driver/saa7127.c
> --- ivtv-orig/driver/saa7127.c	Thu Jul 24 05:16:53 2003
> +++ ivtv-i2c/driver/saa7127.c	Thu Jul 24 17:02:34 2003
> @@ -878,25 +878,6 @@
>  /* -----------------------------------------------------------------------
> */
>  
>  
> -static void saa7127_inc_use (struct i2c_client *client)
> -{
> -  #ifdef MODULE
> -    MOD_INC_USE_COUNT;
> -  #endif
> -}
> -
> -
> -/* -----------------------------------------------------------------------
> */
> -
> -static void saa7127_dec_use (struct i2c_client *client)
> -{
> -  #ifdef MODULE
> -    MOD_DEC_USE_COUNT;
> -  #endif
> -}
> -
> -
> -
>  /*
>   * Generic i2c probe
>   * concerning the addresses: i2c wants 7 bit (without the r/w bit), so '>>1'
> @@ -1071,14 +1052,13 @@
>  
>  struct i2c_driver i2c_driver_saa7127 >  {
> +  .owner          = THIS_MODULE,
>    .name           = "saa7127",
>    .id             = I2C_DRIVERID_SAA7127,
>    .flags          = I2C_DF_NOTIFY,
>    .attach_adapter = saa7127_attach_adapter,
>    .detach_client  = saa7127_detach_client,
>    .command        = saa7127_command,
> -  .inc_use        = saa7127_inc_use,
> -  .dec_use        = saa7127_dec_use,
>  };
>  
>  EXPORT_NO_SYMBOLS;
> diff -ru ivtv-orig/driver/tveeprom.c ivtv-i2c/driver/tveeprom.c
> --- ivtv-orig/driver/tveeprom.c	Tue Apr  1 06:42:35 2003
> +++ ivtv-i2c/driver/tveeprom.c	Thu Jul 24 17:02:57 2003
> @@ -450,22 +450,6 @@
>  
>  /* -----------------------------------------------------------------------
> */
>  
> -static void
> -tveeprom_inc_use (struct i2c_client *client)
> -{
> -#ifdef MODULE
> -/*	MOD_INC_USE_COUNT; */
> -#endif
> -}
> -
> -static void
> -tveeprom_dec_use (struct i2c_client *client)
> -{
> -#ifdef MODULE
> -/*	MOD_DEC_USE_COUNT; */
> -#endif
> -}
> -
>  /*
>   * Generic i2c probe
>   * concerning the addresses: i2c wants 7 bit (without the r/w bit), so '>>1'
> @@ -557,6 +541,7 @@
>  /* -----------------------------------------------------------------------
> */
>  
>  struct i2c_driver i2c_driver_tveeprom = {
> +	.owner = THIS_MODULE,
>  	.name = "tveeprom",
>  
>  	.id = I2C_DRIVERID_TVEEPROM,
> @@ -565,8 +550,6 @@
>  	.attach_adapter = tveeprom_attach_adapter,
>  	.detach_client = tveeprom_detach_client,
>  	.command = tveeprom_command,
> -	.inc_use = tveeprom_inc_use,
> -	.dec_use = tveeprom_dec_use,
>  };
>  
>  EXPORT_NO_SYMBOLS;
> 


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
