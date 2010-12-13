From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 13 Dec 2010 15:22:32 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: Add missing attributes
Message-Id: <20101213152232.GB26048@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1292010605-22089-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1292010605-22089-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 13, 2010 at 05:19:10AM -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> I forgot something during my review yesterday:
> 
> On Fri, 10 Dec 2010 11:50:05 -0800, Guenter Roeck wrote:
> > The attributes added in this patch are listed in the current version
> > of the hwmon sysfs ABI, but not yet supported by libsensors.
> > 
> > This patch only adds the new attributes to libsensors. The sensors command
> > will be updated in a separate patch.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> > (...)
> > Index: lib/sensors.h
> > =================================> > --- lib/sensors.h	(revision 5889)
> > +++ lib/sensors.h	(working copy)
> > (...)
> > @@ -170,6 +172,9 @@
> >  	SENSORS_SUBFEATURE_TEMP_MIN,
> >  	SENSORS_SUBFEATURE_TEMP_CRIT,
> >  	SENSORS_SUBFEATURE_TEMP_CRIT_HYST,
> > +	SENSORS_SUBFEATURE_TEMP_LCRIT,
> > +	SENSORS_SUBFEATURE_TEMP_EMERGENCY,
> > +	SENSORS_SUBFEATURE_TEMP_EMERGENCY_HYST,
> 
> Please double-check the value of MAX_SUBFEATURES after that. I think
> you'll have to increase it from 8 to 9.
> 
Yes, you are right.

> We want to either add code to check for such overflows (I have a patch
> ready) or compute MAX_SUBFEATURES dynamically (see ticket #2378,
> probably a better move) to avoid such problems again and again in the
> future.
> 
Dynamic computation is definitely much better. I'll wait for your commit 
before I commit my changes.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
