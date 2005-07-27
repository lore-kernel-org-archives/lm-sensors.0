From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 27 Jul 2005 12:24:34 +0000
Subject: [lm-sensors] [PATCH] I2C W83792D add hwmon class register 2/3
Message-Id: <af9TLhXp.1122459497.3421600.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050727092507.28687.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20050727092507.28687.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rudolf,

> +	data->class_dev = hwmon_device_register(&new_client->dev);
> +	if (IS_ERR(data->class_dev)) {
> +		err = PTR_ERR(data->class_dev);
> +		goto ERROR2;
> +	}

I do not think this is sufficient. If an error occurs at this point, and
you go to ERROR2, you will not free the subclients you might have
allocated. I guess they could be freed later on module unload, but it's
probably safer and cleaner to free them now, just like asb100 does for
example.

Thanks,
--
Jean Delvare
