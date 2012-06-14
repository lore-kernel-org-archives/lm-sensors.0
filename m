From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Jun 2012 14:26:11 +0000
Subject: Re: [lm-sensors] lm75_remove: LM75 Device remove using sysfs delete_device
Message-Id: <20120614162611.266db199@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
In-Reply-To: <CAOJFanUqFZPih6puAy2DWPWPQMs6ZZz_DFgO9wnRttnP5mCPZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 14 Jun 2012 19:10:27 +0530, Sasikanth babu wrote:
> After making the following changes, It is working fine on soft reboot too.
> 
> diff -urpN orig/linux-2.6.39.4/drivers/i2c/muxes/pca954x.c
> linux-2.6.39.4/drivers/i2c/muxes/pca954x.c
> --- orig/linux-2.6.39.4/drivers/i2c/muxes/pca954x.c     2011-08-03
> 15:43:28.000000000 -0400
> +++ linux-2.6.39.4/drivers/i2c/muxes/pca954x.c  2012-06-14
> 08:37:52.572107218 -0400
> @@ -174,6 +174,7 @@ static int pca954x_deselect_mux(struct i
>         struct pca954x *data = i2c_get_clientdata(client);
> 
>         /* Deselect active channel */
> +       printk (KERN_INFO"pca954x_deselect_mux: called ...\n");
>         data->last_chan = 0;
>         return pca954x_reg_write(adap, client, data->last_chan);
>  }
> @@ -228,8 +229,7 @@ static int pca954x_probe(struct i2c_clie
>                 data->virt_adaps[num] >                         i2c_add_mux_adapter(adap, client,
>                                 force, num, pca954x_select_chan,
> *-                               (pdata &&
> pdata->modes[num].deselect_on_exit)
> -                                       ? pca954x_deselect_mux : NULL);
> +                               pca954x_deselect_mux);*
> 
>                 if (data->virt_adaps[num] = NULL) {
>                         ret = -ENODEV;
> 
> No one  is setting the "deselect_on_exit" for pca954x devices (verified in
> 3.5.0-rc2 too). Does the* pca954x_deselect_mux *not required for PCA mux
> devices* *for every bus transfer?*.

Whether deselecting after bus transfer is needed or not depends on the
I2C bus topology. If you have a single PCA954x chip on the bus then it
is normally not needed, and omitting it speeds transactions up. But if
you have more than one PCA954x chip on the bus, and the bus segments
behind these PCA954x chips use common device addresses, then you must
deselect after each bus transfer otherwise you risk addressing several
slaves at once. Same holds if you mix a PCA954x chip with another
multiplexing strategy.

Why this would cause the symptoms you reported is beyond me though. But
if setting deselect_on_exit fixes it, then just do that!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
