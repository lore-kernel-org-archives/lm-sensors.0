From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 20 Jan 2012 14:51:20 +0000
Subject: Re: [lm-sensors] [PATCH 29/82] hwmon: (hwmon) Fix multi-line comments
Message-Id: <20120120145120.GB353@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327017376-20466-30-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327017376-20466-30-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 20, 2012 at 08:57:04AM -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> On Thu, 19 Jan 2012 15:55:23 -0800, Guenter Roeck wrote:
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/hwmon.c |   24 ++++++++++++------------
> >  1 files changed, 12 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> > index b58a0ff..c0b05ca 100644
> > --- a/drivers/hwmon/hwmon.c
> > +++ b/drivers/hwmon/hwmon.c
> > (...)
> > @@ -29,7 +29,7 @@ static struct class *hwmon_class;
> >  
> >  static DEFINE_IDA(hwmon_ida);
> >  
> > -/**
> > +/*
> >   * hwmon_device_register - register w/ hwmon
> >   * @dev: the device to register
> >   *
> > @@ -57,7 +57,7 @@ struct device *hwmon_device_register(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(hwmon_device_register);
> >  
> > -/**
> > +/*
> >   * hwmon_device_unregister - removes the previously registered class device
> >   *
> >   * @dev: the class device to destroy
> 
> These are markers for DocBook documentation, you shouldn't remove them.
> As a matter of fact checkpatch doesn't complain about them.
> 
No problem, will do.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
