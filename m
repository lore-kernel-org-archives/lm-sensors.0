From: Samuel Ortiz <sameo@linux.intel.com>
Date: Thu, 17 Sep 2009 14:34:45 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090917143444.GA5119@sortiz.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Thu, Sep 17, 2009 at 03:34:50PM +0200, Jean Delvare wrote:
> Hi Rodolfo,
> 
> On Fri, 11 Sep 2009 17:07:05 +0200, Rodolfo Giometti wrote:
> > The file has been splitted up into two parts:
> 
> Spelling: split (it's an irregular verb.)
> 
> > 
> > * drivers/mfd/w83627hf-core.c      - detects the chip and define proper
> >                                      platform devices into mfd support
> > 
> > * drivers/hwmon/w83627hf.c         - implements the driver for hwmon
> >                                      functionality only
> > 
> > The patch also fixes up some non reentrant code and some C-style issues.
> 
> Sounds wrong. Mixing coding style cleanups with real changes makes
> reviewing much harder. You'll have to move these changes to a separate
> patch I'm afraid.
> 
> > 
> > Signed-off-by: Rodolfo Giometti <giometti@linux.it>
> > ---
> >  drivers/hwmon/w83627hf.c     |  373 +++++++++---------------------------------
> >  drivers/mfd/Kconfig          |   14 ++
> >  drivers/mfd/Makefile         |    1 +
> >  drivers/mfd/w83627hf-core.c  |  251 ++++++++++++++++++++++++++++
> >  include/linux/mfd/w83627hf.h |   68 ++++++++
> >  5 files changed, 409 insertions(+), 298 deletions(-)
> >  create mode 100644 drivers/mfd/w83627hf-core.c
> >  create mode 100644 include/linux/mfd/w83627hf.h
> 
> Review:
Thanks a lot for the review. Here go my comments: 

> > @@ -1532,37 +1381,39 @@ static int __devinit w83627thf_read_gpio5(struct platform_device *pdev)
> >  	}
> >  
> >  	dev_info(&pdev->dev, "Reading VID from GPIO5\n");
> > -	res = superio_inb(W83627THF_GPIO5_DR) & sel;
> > +	res = superio_inb(sio_data, W83627THF_GPIO5_DR) & sel;
> >  
> >  exit:
> > -	superio_exit();
> > +	superio_exit(sio_data);
> >  	return res;
> >  }
> 
> This looks wrong. The whole point of the MFD infrastructure is to
> control who is accessing the common registers. Here you let the hwmon
> driver access the Super-I/O configuration registers without any kind of
> synchronisation. What if another user of w83627hf-core does the same at
> the same moment?
> 
> You need a way to protect common registers. You'll need a mutex, for
> sure. Then you can either export this mutex and count on all "children"
> drivers' cooperation to properly request and release it. Or you can
> move all the code accessing the common registers into w83627hf-core,
> and stop exporting the superio_* functions. I don't know if there is a
> recommended practice for MFD drivers. Samuel?
The recommended practice is definitely to have your register accessing
routines defined from the MFD core. That's what all MFD drivers do.

 
> 
> > +	  enable the drivers of Winbond chip's functionalities.
> > +
> > +	  This driver can also be built as a module.  If so, the module
> > +	  will be called w83627hf-core.
> > +
> 
> Shouldn't this option be selected automatically by the w83627hf (hwmon)
> driver? Currently it is possible to select only the hwmon driver, but
> that driver will never work because the required platform driver won't
> be created. This is a problem for current users upgrading to a new
> kernel, as CONFIG_MFD_W83627HF defaults to N.
> 
> But then again I don't know if there is already a policy regarding this
> for MFD drivers. Samuel?
If your subdevice driver is calling some of the MFD core routines, or if
there's a platform dependency, then your subdevice driver (w83627hf in that
case) Kconfig should depend on MFD_W83627HF.

Cheers,
Samuel. 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
