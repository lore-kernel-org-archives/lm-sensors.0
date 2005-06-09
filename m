From: greg@kroah.com (Greg KH)
Date: Thu, 09 Jun 2005 09:28:31 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 3/3] i2c: modify sensors
Message-Id: <20050609070808.GB22729@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033727.GD4906@jupiter.solarsys.private>
In-Reply-To: <20050602033727.GD4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jun 03, 2005 at 02:59:33PM -0400, Yani Ioannou wrote:
> > > I just come back to my previous line of thought that we really should
> > > be using class_device_attributes for hwmon class sensor attributes
> > > rather than assuming that every hwmon class_device has an associated
> > > device...
> > 
> > No, every hwmon class_device should have a struct device associated with
> > it.  If not, it needs to be fixed :)
> 
> Well even assuming that every hwmon class_device does have a device
> associated with it, it still makes sense to me to be using
> class_device_attributes.

It does, over time.  I can see the sensor files moving to be class
attributes instead of device attributes.  But we need to do that so we
don't break all of the userspace code at the same time :)

thanks,

greg k-h
