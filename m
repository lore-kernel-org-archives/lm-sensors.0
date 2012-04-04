From: Kyle McMartin <kyle@mcmartin.ca>
Date: Wed, 04 Apr 2012 15:32:11 +0000
Subject: Re: [lm-sensors] [PATCH 0/5] acpi_power_meter: clean up duplicate code
Message-Id: <20120404153211.GA15318@bombadil.infradead.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1333390501.git.kyle@mcmartin.ca>
In-Reply-To: <cover.1333390501.git.kyle@mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 03, 2012 at 08:39:18AM -0700, Guenter Roeck wrote:
> nice cleanup series.
> 
> Couple of comments / questions. That won't prevent me from applying the series, just some things
> to think about.
> 
> - You could have used a single macro instead of two, with _set set to NULL for read-only attributes.
> - Why not just use SENSOR_DEVICE_ATTR, struct attribute, and sysfs_create_group/sysfs_remove_group ?
> - I think there may be a race condition in acpi_power_meter_notify(), in the METER_NOTIFY_CONFIG path.
>   It frees some data, re-allocates it, then removes the attributes and re-creates them. If someone
>   were to read the power1_model_number attribute after the call to free_capabilities, show_str()
>   might potentially access freed memory.
> 

Thanks for the review, Guenter. I'll take a look at some of these
other fixes this week.

regards, Kyle

> Thanks,
> Guenter
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
