From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: 2.6.4-rc2-mm1: IPMI_SMB doesnt compile
Message-Id: <20040310211238.GB21966@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040307223221.0f2db02e.akpm@osdl.org> <20040309013917.GH14833@fs.tum.de> <404F3BC3.2090906@acm.org> <20040310185105.GS14833@fs.tum.de> <20040310190648.GB18892@kroah.com> <404F7EF8.5020402@acm.org>
In-Reply-To: <404F7EF8.5020402@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Corey Minyard <minyard@acm.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, "Davis, Todd C" <todd.c.davis@intel.com>, sensors@stimpy.netroedge.com, "Simon G. Vogl" <simon@tk.uni-linz.ac.at>

On Wed, Mar 10, 2004 at 02:47:52PM -0600, Corey Minyard wrote:
> Greg KH wrote:
> 
> >On Wed, Mar 10, 2004 at 07:51:05PM +0100, Adrian Bunk wrote:
> > 
> >
> >>On Wed, Mar 10, 2004 at 10:01:07AM -0600, Corey Minyard wrote:
> >>   
> >>
> >>>...
> >>>I have included a patch from Todd Davis at Intel that adds this function 
> >>>to the I2C driver.  I believe Todd has been working on getting this in 
> >>>through the I2C driver writers, although the patch is fairly 
> >>>non-intrusive.
> >>>
> >>>However, I have no real way to test this patch.
> >>>...
> >>>     
> >>>
> >>I can only confirm that it fixes the compilation...
> >>
> >>
> >>The patch to i2c-core.c is strange:
> >>   
> >>
> >
> >And dumb, and incorrect :(
> >
> > 
> >
> Wrong as in: "This code will not work" or wrong as in: "don't export the 
> variable and the function", or both?

Wrong as in "don't export the variable, the function, and on top of
that, not document what you are trying to do."

> I certainly agree that exporting both is wrong, there should really be
> two inline functions with only the variable exported, or only
> functions exported and the variable hidden.  That's an easy change.
> 
> However, if the code does not work, that is a bigger deal.  I'm fairly 
> sure it works in some cases, but not sure about all.
> 
> The patch I posted is for 2.6, BTW.

But you never sent it to the i2c maintainers, right?

I understand what you are trying to accomplish with this type of patch,
but if you _really_ need to make this kind of change, please change the
name to something that really stands out as being not the thing you ever
would want to do.

Something like:
	i2c_we_just_paniced_and_can_not_sleep_anymore()

thanks,

greg k-h
