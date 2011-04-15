From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 15 Apr 2011 11:20:12 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] i8k: Integrate with the hwmon subsystem
Message-Id: <20110415112012.GB23594@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110413172856.06682baf@endymion.delvare>
In-Reply-To: <20110413172856.06682baf@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Fri, Apr 15, 2011 at 03:37:58AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> Thanks for the review.
> 
> On Thu, 14 Apr 2011 11:41:47 -0700, Guenter Roeck wrote:
> > On Wed, 2011-04-13 at 11:28 -0400, Jean Delvare wrote:
> > > @@ -590,6 +732,11 @@ static int __init i8k_init(void)
> > >  	if (!proc_i8k)
> > >  		return -ENOENT;
> > >  
> > > +	if (i8k_init_hwmon()) {
> > > +		remove_proc_entry("i8k", NULL);
> > > +		return -ENODEV;
> > > +	}
> > > +
> > Should that be something like
> > 	err = i8k_init_hwmon();
> > 	if (err)
> > 		goto remove_proc;
> > 
> > 	...
> > 
> > remove_proc:
> > 	remove_proc_entry("i8k", NULL);
> > 	return err;
> 
> I would have done exactly this if it were my driver. However I noticed
> that the error code from i8k_probe() is not preserved, so I decided to
> follow the same logic for consistency.
> 
Both are independent of each other. If a rule is not followed at one place 
it doesn't mean that it should not be followed elsewhere. Besides, my main point
was to follow the one-function-exit rule; retaining the error code was a side
effect as 

	err = i8k_init_hwmon();
	if (err) {
		err = -ENODEV;
		goto remove_proc;
	}

didn't seem to make much sense.

Is there a generic rule that error codes shall be retained ? I looked for it,
but did not find it. If not I should add it to the hwmon driver guidelines.

> If you think this is a blocker, then I'll write a preliminary patch to
> preserve the error code returned by i8k_probe(), and then update my own
> patch in the way you suggested above.
> 
I'll leave it up to you. 

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

for both patches.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
