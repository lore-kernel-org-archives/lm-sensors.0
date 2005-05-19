From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: add eeprom i2c driver
Message-Id: <3E822AF7.56E8EF7E@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030325172024.GC15823@kroah.com>
In-Reply-To: <20030325172024.GC15823@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As I just put in my other email, here's the /proc standards.
The other email has info on why it should stay the same.

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/developers/proc

See lib/chips.c in our package for an example of what has to change if
we can't keep things the same...
I'm not defending lib/chips.c or libsensors as a thing of beauty.
I'm just pointing out the obvious. Change things and it all breaks.

mds



Greg KH wrote:
> 
> On Wed, Mar 26, 2003 at 10:42:23AM +0100, Jan Dittmer wrote:
> > Greg KH wrote:
> >  As an example of the changes necessary, here's a patch against the i2c
> > >cvs version of the eeprom.c driver that converts it over to use sysfs,
> > >instead of the /proc and sysctl interface.  It's still a bit rough, but
> > >you should get the idea of where I'm wanting to go with this.  As you
> > >can see, it takes about 100 lines of code off of this driver, which is
> > >nice.
> > >
> > I thought about doing something like this for adding sysfs support.
> > Should the voltages and other data appear as integer or as floats in
> > sysfs tree? (ie. 1.20V or 120cV)
> 
> floats are a pain!
> 
> As we should have only one value per file, why not just "know" the units
> of the file, so that we don't have to mess with a decimal point.  Makes
> the kernel a lot simpler and smaller, and then userspace can easily
> parse the number and do any needed conversions.
> 
> > And what should be written back? I think the /proc interface expects
> > floats...
> 
> Again, I would vote for simple integers.
> 
> And good documentation about what each file's units are :)
> 
> thanks,
> 
> greg k-h
