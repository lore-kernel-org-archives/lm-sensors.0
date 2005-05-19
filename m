From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: add eeprom i2c driver
Message-Id: <20030326212923.GB26886@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E806AC6.30503@portrix.net> <20030325172024.GC15823@kroah.com> <3E8175FF.7060705@portrix.net>
In-Reply-To: <3E8175FF.7060705@portrix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

On Wed, Mar 26, 2003 at 10:42:23AM +0100, Jan Dittmer wrote:
> Greg KH wrote:
>  As an example of the changes necessary, here's a patch against the i2c
> >cvs version of the eeprom.c driver that converts it over to use sysfs,
> >instead of the /proc and sysctl interface.  It's still a bit rough, but
> >you should get the idea of where I'm wanting to go with this.  As you
> >can see, it takes about 100 lines of code off of this driver, which is
> >nice.
> >
> I thought about doing something like this for adding sysfs support.
> Should the voltages and other data appear as integer or as floats in 
> sysfs tree? (ie. 1.20V or 120cV)

floats are a pain!

As we should have only one value per file, why not just "know" the units
of the file, so that we don't have to mess with a decimal point.  Makes
the kernel a lot simpler and smaller, and then userspace can easily
parse the number and do any needed conversions.

> And what should be written back? I think the /proc interface expects 
> floats...

Again, I would vote for simple integers.

And good documentation about what each file's units are :)

thanks,

greg k-h
