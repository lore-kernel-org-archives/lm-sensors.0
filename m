From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 02 Jun 2011 16:26:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: new max1668 driver
Message-Id: <20110602162648.GA9665@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110602132620.GC4230@lapster.kat.ac.za>
In-Reply-To: <20110602132620.GC4230@lapster.kat.ac.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jun 02, 2011 at 09:26:20AM -0400, David George wrote:
> Hi Guenter.
> 
> Hopefully this is more to your liking. I have made the changes you recommended,
> except adding max1668_sysfs_cleanup(). I didn't 100% follow how it would help.
> 

Hi David,

I should have phrased it differently.

[ ... ]

> +
> +       data->hwmon_dev = hwmon_device_register(&client->dev);
> +       if (IS_ERR(data->hwmon_dev)) {
> +               err = PTR_ERR(data->hwmon_dev);
		goto error_sysrem1;

> +               if (data->type = max1668 || data->type = max1989)
> +                       goto error_sysrem1;
> +               else
> +                       goto error_sysrem0;

Delete those four lines

> +       }
> +
> +       return 0;
> +
> +error_sysrem1:
Add here:
	if (data->type = max1668 || data->type = max1989)

In other words, leave error path complexity for the error path.

Besides that, your patch has an empty last line in Documentation/hwmon/max1668,
which git complains about. Also, MODULE_PARM_DESC should be next to module_param().
Sorry, guess I wasn't entirely clear on that before.

No need to resubmit - I'll make those changes myself.

Applied, thanks.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
