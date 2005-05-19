From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <20050426075453.GC6795@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 26, 2005 at 02:45:06AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> On Monday 25 April 2005 00:36, Yani Ioannou wrote:
> > Hi all,
> > 
> > I'm sending this driver sysfs callback patch to the lm-sensors list to
> > get more of the sensor driver maintainer's comments on the patch
> > (specifically the type to be associated with each sysfs entry) before
> > submitting to LKML. Jean and Greg have already given me invaluable
> > feedback and are supportive of the general idea of the patch (the
> > problem of which is epitomized by the kludge the 2.6 bmcsensors driver
> > is at the moment - see previous discussions in the list archive).
> > 
> > Included is a patch against drivers/base/core.c and
> > include/linux/driver.h that adds a void * to the device attribute
> > struct and passes it back to the two sysfs callbacks show/store.
> 
> If void is added directly to the attribute structure that means that same
> attribute can not be shared between several instances of the same device
> -> unexpected. So far all attributes could be statically created.

One reason I will not accept such a patch, without seeing how it will be
used :)

thanks,

greg k-h
