From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 04 Mar 2011 19:17:24 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: Add support for fanX_pulses
Message-Id: <1299266244.18605.40.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110304150946.GA1804@ericsson.com>
In-Reply-To: <20110304150946.GA1804@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2011-03-04 at 13:41 -0500, Jean Delvare wrote:
> On Fri, 4 Mar 2011 07:09:46 -0800, Guenter Roeck wrote:
> > This patch adds support for the fanX_pulses sysfs attribute.
> > 
> > --
> > Index: lib/sensors.h
> > =================================> > --- lib/sensors.h	(revision 5937)
> > +++ lib/sensors.h	(working copy)
> > @@ -170,6 +170,7 @@
> >  	SENSORS_SUBFEATURE_FAN_FAULT,
> >  	SENSORS_SUBFEATURE_FAN_DIV,
> >  	SENSORS_SUBFEATURE_FAN_BEEP,
> > +	SENSORS_SUBFEATURE_FAN_PULSES,
> >  
> >  	SENSORS_SUBFEATURE_TEMP_INPUT = SENSORS_FEATURE_TEMP << 8,
> >  	SENSORS_SUBFEATURE_TEMP_MAX,
> > Index: lib/sysfs.c
> > =================================> > --- lib/sysfs.c	(revision 5937)
> > +++ lib/sysfs.c	(working copy)
> > @@ -265,6 +265,7 @@
> >  	{ "input", SENSORS_SUBFEATURE_FAN_INPUT },
> >  	{ "min", SENSORS_SUBFEATURE_FAN_MIN },
> >  	{ "div", SENSORS_SUBFEATURE_FAN_DIV },
> > +	{ "pulses", SENSORS_SUBFEATURE_FAN_PULSES },
> >  	{ "alarm", SENSORS_SUBFEATURE_FAN_ALARM },
> >  	{ "fault", SENSORS_SUBFEATURE_FAN_FAULT },
> >  	{ "beep", SENSORS_SUBFEATURE_FAN_BEEP },
> > 
> 
> Looks good. Please don't forget to update doc/libsensors-API.txt and
> CHANGES too.
> 
Do you want to include the new attribute in the upcoming version of the
sensors code ?

Reason for asking is that I plan to commit the sysfs ABI changes into
2.6.39, so the attribute won't be documented yet if you release a new
version of the sensors code this weekend (ie prior to the Linux merge
window).

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
