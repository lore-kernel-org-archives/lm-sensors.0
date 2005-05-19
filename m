From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <20050505061105.GB465@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 04, 2005 at 03:16:11PM -0400, Yani Ioannou wrote:
> > > I've included a modified version of the previous dynamic callback
> > > patch where I defined a DEVICE_ATTR_DATA macro which becomes useful in
> > > these cases, likely in any real patch this would be rolled into the
> > > DEVICE_ATTR macro but for simplicity (i.e. not breaking everything
> > > else that uses DEVICE_ATTR out there) I'm using a separate one for
> > > now.
> > 
> > Try modifying __ATTR() to have the data pointer and then make
> > DEVICE_ATTR pass a NULL for the data field.
> > 
> 
> This would work except __ATTR is used by all the attribute macros not
> just DEVICE_ATTRIBUTE. Would a void * field in those attributes be
> useful too?

Wait, are you only changing the device attribute?  What about the
general sysfs attributes?  That is where this should be changed.

thanks,

greg k-h
