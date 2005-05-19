From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: Patch for I2C + sysfs
Message-Id: <20040109231841.GD4693@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040109231724.GC4693@kroah.com>
In-Reply-To: <20040109231724.GC4693@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 09, 2004 at 07:13:10AM -0700, Matthew Mastracci wrote:
> This patch names the subclients of the w83781d with
> unique names to support the I2C device in HAL.  I2C devices need to have
> unique names since there are no other unique identifiers.
> 
> --- drivers/i2c/chips/w83781d.c.orig    2004-01-08 23:31:54.296510000
> -0700
> +++ drivers/i2c/chips/w83781d.c 2004-01-08 23:25:57.616510000 -0700
> @@ -1134,8 +1134,8 @@
>                 data->lm75[i]->adapter = adapter;
>                 data->lm75[i]->driver = &w83781d_driver;
>                 data->lm75[i]->flags = 0;
> -               strlcpy(data->lm75[i]->name, client_name,
> -                       I2C_NAME_SIZE);
> +               snprintf(data->lm75[i]->name, I2C_NAME_SIZE, "%s %d",
> +                       client_name, i);
>                 if ((err = i2c_attach_client(data->lm75[i]))) {
>                         dev_err(&new_client->dev, "Subclient %d "
>                                 "registration at address 0x%x "


No, their path in sysfs is a "unique identifier".  They can have the
same "name" but be in different places, right?  Can you show me a sysfs
tree that has a problem that this patch fixes?

thanks,

greg k-h
