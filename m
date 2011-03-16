From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 16 Mar 2011 17:03:08 +0000
Subject: Re: [lm-sensors] [PATCH v3 resend] sensors: Add support for
Message-Id: <20110316170308.GB29453@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110316151522.GB28824@ericsson.com>
In-Reply-To: <20110316151522.GB28824@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 16, 2011 at 12:34:09PM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Wed, 16 Mar 2011 08:15:22 -0700, Guenter Roeck wrote:
> > [ copied mailing list this time ]
> >
> > This patch adds support for additional sensor attributes to the sensors command.
> >
> > v3:
> > - Print detailed alarms (if supported) even if the "alarm" flag exists as well.
> >   [ With this change, the nexists field in struct sensor_subfeature_list is unused.
> >     Question is if we should keep it, or remove it and add it back in if needed
> >     at a later time. ]
> 
> I would remove it. We might as well never need it later.
> 
Ok, removed.

> > - Always use alarms_printed flag to determine if alarms need to be printed.
> > - Document that *num_limits and *num_alarms must be initialized by the caller.
> > - Don't create a core dump if subfeature arrays are too small.
> > - Use %s in error message to save some binary space.
> > - Use ARRAY_SIZE where appropriate.
> > - Add missing spaces before "sensor = <type>" output.
> > - Add missing SENSORS_SUBFEATURE_POWER_AVERAGE.
> > - Replace power_max with power_common_sensors and call get_sensor_limit_data()
> >   with it as argument to add common power sensors to list of limits.
> > - Replace "limit" with "subfeature" in comments.
> > - Commit "If an attribute value is 0, display the value with its base unit,
> >   not with the minumum supported unit" separately.
> >
> > v2:
> > - Changed several variable and function names to better match functionality
> > - Removed unnecessary conditionals
> > - Modified output to better match original code alignments
> > - Always print alarms if set, even if there are no limit registers
> > - Added range check to get_sensor_limit_data() to avoid buffer overruns.
> >   If an overrun occurs, display an error message and try to write a core dump.
> > - Added comment explaining when alarms are queued, and why alarm values are
> >   not queued.
> > - Avoid use of strcpy() and strcat(). Instead, use patch from Jean's
> >   review to attach temperature units to limit values.
> > - Print highest/lowest as well as max/crit power attributes if provided.
> > - Replace MIN/MAX temperature alarms with LOW/HIGH
> > - If an attribute value is 0, display the value with its base unit,
> >   not with the minumum supported unit
> > - Replace "emergency" with "emerg" for emergency high temperature attributes.
> >
> > --
> 
> Only minor comments left, and then you can commit:
> 
All fixed. Ok to commit, or should I resend the diffs ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
