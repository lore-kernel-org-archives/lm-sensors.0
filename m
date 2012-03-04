From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 04 Mar 2012 15:16:24 +0000
Subject: Re: [lm-sensors] [PATCH] sensors: Fix power interval output
Message-Id: <20120304151624.GA1836@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326472342-3345-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326472342-3345-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 04, 2012 at 08:11:21AM -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> Sorry for the very late reply. D'oh, I can't believe it has been 7
> weeks already :(
> 
Time goes by ...

> On Fri, 13 Jan 2012 08:32:22 -0800, Guenter Roeck wrote:
> > Power interval is measured in seconds, not Watt.
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > Untested. Maybe a bit kludgy but should work.
> 
> I recall testing it with a fake driver and it was working. But I don't
> like it much. It's sad to have defined data structures to abstract
> things as much as possible and then end up with a hack like this one. I
> would prefer a more generic solution if we can come up with one. OTOH
> delaying lm-sensors 3.3.2 further just for this makes little sense. So,
> if you don't hear from me in the next 2 days, please just commit this
> fix and I'll release 3.3.2.
> 
Ok. I wasn't too happy with it either, but I didn't find a better solution.

> >  prog/sensors/chips.c |   22 ++++++++++++++++++----
> >  1 files changed, 18 insertions(+), 4 deletions(-)
> > 
> > diff --git a/prog/sensors/chips.c b/prog/sensors/chips.c
> > index 677a617..fde33f6 100644
> > --- a/prog/sensors/chips.c
> > +++ b/prog/sensors/chips.c
> > @@ -574,11 +574,25 @@ static void print_chip_power(const sensors_chip_name *name,
> >  	} else
> >  		printf("     N/A  ");
> >  
> > -	for (i = 0; i < sensor_count; i++)
> > -		scale_value(&sensors[i].value, &sensors[i].unit);
> > -
> > +	for (i = 0; i < sensor_count; i++) {
> > +	    	/*
> > +		 * Unit is W and needs to be scaled for all attributes except
> > +		 * interval, which does not need to be scaled and is reported in
> > +		 * seconds.
> > +		 */
> > +	    	if (strcmp(sensors[i].name, "interval")) {
> > +		    	char *tmpstr;
> > +			
> > +			tmpstr = alloca(4);
> 
> I didn't even know about this function. Interesting one. I'm not sure
> how portable it is, but that shouldn't be an issue for lm-sensors.
> 
Been there forever. I didn't know that its usage is discouraged nowadays.
Looks like it was in C90, but was removed from C99. It is perfect for situations
like this, but one has to be careful (which I guess is why its use is discouraged). 

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
