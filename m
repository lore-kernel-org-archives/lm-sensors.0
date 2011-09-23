From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 23 Sep 2011 16:03:38 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: avoid leaving around dangling
Message-Id: <1316793818.3888.22.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E7C7C710200007800057854@nat28.tlf.novell.com>
In-Reply-To: <4E7C7C710200007800057854@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2011-09-23 at 11:55 -0400, Jan Beulich wrote:
> >>> On 23.09.11 at 17:35, Guenter Roeck <guenter.roeck@ericsson.com> wrote:
> > On Fri, 2011-09-23 at 06:32 -0400, Jan Beulich wrote:
> >> Storing the struct temp_data pointer allocated from create_core_data()
> >> before passing the last 'goto exit_free' has the potential of leaving
> >> around a pointer to freed memory. As there's no need for the pointer to
> >> be stored before calling create_core_attrs(), simply move the storing
> >> past that call.
> >> 
> >> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> >> Cc: stable@kernel.org 
> >> 
> >> ---
> >>  drivers/hwmon/coretemp.c |    3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> --- 3.1-rc7-coretemp.orig/drivers/hwmon/coretemp.c
> >> +++ 3.1-rc7-coretemp/drivers/hwmon/coretemp.c
> >> @@ -609,13 +609,14 @@ static int create_core_data(struct platf
> >>  				  THERM_SHIFT_THRESHOLD1) * 1000;
> >>  	}
> >>  
> >> -	pdata->core_data[attr_no] = tdata;
> >>  
> >>  	/* Create sysfs interfaces */
> >>  	err = create_core_attrs(tdata, &pdev->dev, attr_no);
> >>  	if (err)
> >>  		goto exit_free;
> >>  
> >> +	pdata->core_data[attr_no] = tdata;
> >> +
> > Problem with this patch is that core_data can be accessed after the call
> > to create_core_attrs() (since the attributes now exist). So the patch
> > introduces a small window where an access to core_data[] can result in a
> > NULL pointer access.
> > 
> >>  	return 0;
> >>  exit_free:
> > 
> > Any problem with just resetting pdata->core_data[attr_no] to NULL here ?
> 
> Certainly not - I just didn't realize the dependency you point out above,
> and without that it seemed more clean to just move the assignment.
> 
> Will send an updated patch in a little while, unless you want to go
> ahead and fix this the right way before I would get to it.
> 
I'll wait for your updated patch.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
