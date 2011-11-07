From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 07 Nov 2011 17:39:18 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] IIO:hwmon interface client driver.
Message-Id: <4EB817C6.5070503@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1320680681-5635-1-git-send-email-jic23@kernel.org>  <1320680681-5635-5-git-send-email-jic23@kernel.org> <1320683392.2309.109.camel@groeck-laptop>
In-Reply-To: <1320683392.2309.109.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: guenter.roeck@ericsson.com
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "khali@linux-fr.org" <khali@linux-fr.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "gregkh@suse.de" <gregkh@suse.de>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "lars@metafoo.de" <lars@metafoo.de>, "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>, "zdevai@gmail.com" <zdevai@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>

>> +static int __devexit iio_hwmon_remove(struct platform_device *pdev)
>> +{
>> +	struct iio_hwmon_state *st = platform_get_drvdata(pdev);
>> +
>> +	hwmon_device_unregister(st->hwmon_dev);
>> +	sysfs_remove_group(&pdev->dev.kobj, &st->attr_group);
>> +	iio_hwmon_free_attrs(st);
>> +	kfree(st->attrs);
>> +	iio_channel_release_all(st->channels);
>> +
> 
> Either I missed it before, or I am missing something now ... should
> there be kfree(st) here ?
> 
> Thanks,
> Guenter

Gah! you are quite right.  Good spot.  I'll fix that one up and repost
this individual patch.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
