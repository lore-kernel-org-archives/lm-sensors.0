From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Jan 2012 17:16:52 +0000
Subject: Re: [lm-sensors] [PATCH v2] Add support for new attributes to
Message-Id: <20120109181652.5bbe92d3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111106224622.GA28914@ericsson.com>
In-Reply-To: <20111106224622.GA28914@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 9 Jan 2012 08:40:31 -0800, Guenter Roeck wrote:
> On Mon, 2012-01-09 at 11:23 -0500, Jean Delvare wrote:
> > Well that was a long speech for a short conclusion: as far as I can
> > see, all we have to do is duplicate power_avg_sensors[] at the end of
> > power_inst_sensors[] and adjust the labels to avoid ambiguous
> > duplicates. As far as I can see you don't even need to touch the code
> > itself, except for stripping out the comment which claims that power
> > sensor flavors are assumed to be mutually exclusive.
> 
> Makes sense. Something like the following ?
> 
> static const struct sensor_subfeature_list power_avg_sensors[] = {
>         { SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST, NULL, 0,
> "avg_lowest" },
>         { SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST, NULL, 0,
> "avg_highest" },
>         { SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL, NULL, 0,
>                 "interval" },
>         { -1, NULL, 0, NULL }
> };
> 
> static const struct sensor_subfeature_list power_inst_sensors[] = {
>         { SENSORS_SUBFEATURE_POWER_AVERAGE, power_avg_sensors, 0,
> "avg" },
>         { SENSORS_SUBFEATURE_POWER_INPUT_LOWEST, NULL, 0, "lowest" },
>         { SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST, NULL, 0, "highest" },
>         { -1, NULL, 0, NULL }
> };
> 
> Any good idea how to name the labels ?

Well, currently we simply use "lowest" and "highest" when a given
sensor only supports one flavor. I think we want to keep things that
way, as this avoids long/confusing labels in the most common cases. I
expect the multi-flavor sensors case with both sets of limits to be
rare.

Of course the drawback is that we can't reuse power_avg_sensors. But
I'd say this is a fairly minor cost. So what I had in mind was more
along the lines of:

static const struct sensor_subfeature_list power_inst_sensors[] = {
	{ SENSORS_SUBFEATURE_POWER_INPUT_LOWEST, NULL, 0, "lowest" },
	{ SENSORS_SUBFEATURE_POWER_INPUT_HIGHEST, NULL, 0, "highest" },
	{ SENSORS_SUBFEATURE_POWER_AVERAGE, power_avg_sensors, 0, "avg" },
	{ SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST, NULL, 0, "avg lowest" },
	{ SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST, NULL, 0, "avg highest" },
	{ SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL, NULL, 0,
		"interval" },
	{ -1, NULL, 0, NULL }
};

static const struct sensor_subfeature_list power_avg_sensors[] = {
	{ SENSORS_SUBFEATURE_POWER_AVERAGE_LOWEST, NULL, 0, "lowest" },
	{ SENSORS_SUBFEATURE_POWER_AVERAGE_HIGHEST, NULL, 0, "highest" },
	{ SENSORS_SUBFEATURE_POWER_AVERAGE_INTERVAL, NULL, 0,
		"interval" },
	{ -1, NULL, 0, NULL }
};

I.e. power_avg_sensors is unchanged.

Note that I avoided underscores in labels on purpose and for
consistency, as we don't have any currently.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
