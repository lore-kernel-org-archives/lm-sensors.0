From: Michael Lawnick <ml.lawnick@gmx.de>
Date: Mon, 13 Sep 2010 09:22:02 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: lm75: Add __devinit and
Message-Id: <4C8DED3A.5080300@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284365862-20438-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1284365862-20438-1-git-send-email-shubhrajyoti@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Shubhrajyoti D said the following:
...

> -static int
> +static int __devinit
>  lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
Are you sure?
If I understand correctly, this function will be thrown away after
system/module init. But what's about devices that are added later?
I would expect them to crash on init...

-- 
KR
Michael

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
