From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 22:47:23 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
Message-Id: <20050519205222.GA311@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705051703479bd0c29@mail.gmail.com> <e9iUj0EZ.1116327879.1515720.khali@localhost> <2538186705051704181a70dbbf@mail.gmail.com> <253818670505172136613abb43@mail.gmail.com> <20050519220235.3946f880.khali@linux-fr.org>
In-Reply-To: <20050519220235.3946f880.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Yani Ioannou <yani.ioannou@gmail.com>, LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, May 19, 2005 at 10:02:35PM +0200, Jean Delvare wrote:
> If we are into code refactoring and driver size shrinking, you may want
> to take a look at the following patch, which makes it87 even smaller
> (from 18976 bytes down to 16992 bytes on my system) and IMHO more
> cleaner.

But this doesn't reduce the binary size of the module, right?

>  	/* Register sysfs hooks */
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in0_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in1_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in2_input.dev_attr);
> -	device_create_file(&new_client->dev, &sensor_dev_attr_in3_input.dev_attr);

<snip>

You know, we do have arrays of attributes that can be registered with a
single call...

I'd recommend using that over this mess anyday :)

> +#define SENSOR_DEVICE_ATTR_ARRAY_HEAD(_name,_size)		\
> +struct sensor_device_attribute sensor_dev_attr_##_name[_size] = {
> +
> +#define SENSOR_DEVICE_ATTR_ARRAY_ITEM(_name,_mode,_show,_store,_index)	\
> +	{ .dev_attr=__ATTR(_name,_mode,_show,_store),		\
> +	  .index=_index, },
> +
> +#define SENSOR_DEVICE_ATTR_ARRAY_TAIL				\
> +}

No, I hate HEAD and TAIL macros.  This really isn't buying you much code
savings, you could do it yourself with the __ATTR() macro yourself with
the same ammount of code I bet...

Or use the new macro that Yani created, that will make it even smaller
:)

thanks,

greg k-h
