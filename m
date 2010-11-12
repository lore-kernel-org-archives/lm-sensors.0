From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Nov 2010 16:41:33 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] intel medfield: thermal_driver
Message-Id: <20101112174133.0ce2db6f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101111154902.12776.31489.stgit@localhost.localdomain>
In-Reply-To: <20101111154902.12776.31489.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 12 Nov 2010 06:57:03 -0800, Guenter Roeck wrote:
> On Fri, Nov 12, 2010 at 05:38:21AM -0500, Alan Cox wrote:
> > On Thu, 11 Nov 2010 12:56:54 -0800
> > Guenter Roeck <guenter.roeck@ericsson.com> wrote:
> > 
> > > On Thu, 2010-11-11 at 10:49 -0500, Alan Cox wrote:
> > > > From: Durgadoss <durgadoss.r@intel.com>
> > > > 
> > > > This is the basic thermal sensor driver for Intel MID platform using the
> > > > Medfield chipset. It plugs in via the thermal drivers and provides sensor
> > > > readings for the device sensors.
> > > > 
> > > > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> > > > Signed-off-by: Alan Cox <alan@linux.intel.com>
> > > > ---
> > > > 
> > > As a thermal driver, shouldn't this driver be in drivers/thermal ?
> > 
> > drivers/thermal doesn't contain any drivers at all but I have no problem
> > with being there or hwmon - whichever is best.
> 
> So far, all thermal drivers, including the Intel Medfield driver, are in
> platform directories. Not sure if that is a good location either.
> drivers/thermal seems to be the natural place. That there are no drivers
> in drivers/thermal should not be a reason to move it elsewhere.
> One driver has to be the first, after all.
> 
> hwmon just doesn't seem right, since hwmon support for thermal devices is optional.
> 
> Jean, any opinion ?

I don't really have time to formulate an educated opinion, sorry. So
I'll trust you :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
