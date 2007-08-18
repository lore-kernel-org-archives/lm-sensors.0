From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 18 Aug 2007 14:07:18 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/lm70: Add a name attribute
Message-Id: <20070818160718.1607f7ca@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817173135.5eaffc0e@hyperion.delvare>
In-Reply-To: <20070817173135.5eaffc0e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kaiwan,

On Sat, 18 Aug 2007 11:44:22 +0530, Kaiwan N Billimoria wrote:
> > @@ -115,7 +123,8 @@ static int __devinit lm70_probe(struct s
> >  	}
> >  	dev_set_drvdata(&spi->dev, p_lm70);
> >  
> > -	if ((status = device_create_file(&spi->dev, &dev_attr_temp1_input))) {
> > +	if ((status = device_create_file(&spi->dev, &dev_attr_temp1_input))
> > +	 || (status = device_create_file(&spi->dev, &dev_attr_name))) {
> >  		dev_dbg(&spi->dev, "device_create_file failure.\n");
> >  		goto out_dev_create_file_failed;
> >  	}
> > @@ -123,6 +132,7 @@ static int __devinit lm70_probe(struct s
> >  	return 0;
> >  
> >  out_dev_create_file_failed:
> > +	device_remove_file(&spi->dev, &dev_attr_temp1_input);
>
> Ah. Thanks!
> 
> >  	hwmon_device_unregister(p_lm70->cdev);
> >  out_dev_reg_failed:
> >  	dev_set_drvdata(&spi->dev, NULL);

Just to make it clear: there was no bug there. This call to
device_remove_file() is now needed in the case where the temp1_input
file would be successfully created but the name file creation would
fail.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
