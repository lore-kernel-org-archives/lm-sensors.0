From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6.12-rc4 1/12] (dynamic sysfs callbacks) update device
Message-Id: <25381867050514163114d50e82@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705051402237a79225@mail.gmail.com>
	 <20050514112242.A24975@flint.arm.linux.org.uk>
	 <2538186705051412462d6db2d2@mail.gmail.com>
	 <20050514221838.A15061@flint.arm.linux.org.uk>
	 <20050514213421.GC5198@kroah.com>
In-Reply-To: <20050514213421.GC5198@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, LM Sensors <sensors@stimpy.netroedge.com>

On 5/14/05, Greg KH <greg@kroah.com> wrote:
> On Sat, May 14, 2005 at 10:18:38PM +0100, Russell King wrote:
> > There are two advantages to this way:
> >
> > 1. you're not having to impose the extra void * pointer in the
> >    attribute on everyone.

Well this is less of an advantage when you consider that most sysfs
attributes in the kernel should be taking advantage of it. A quick
look through the various sysfs attributes (e.g. class_attribute,
device_attribute, etc) in the kernel and how they are used quickly
convinces you that the idea doesn't just address a problem in one or
two drivers, or even one particular type of attribute, but most of the
kernel sysfs attributes. Of course that problem is more obvious in
some sections of the kernel than others.

> > 2. you allow people to add whatever data they please to the attribute
> >    in whatever format they wish - whether it be a void pointer, integer,
> >    or whatever.

You can do just as much with a void * , e.g. define a struct with
whatever in it and point to it is functionally the same thing, and my
net-sysfs.c patch did this (see lm_sensors archive again), but this is
much more obvious, transparent and less error prone (in my opinion).
However I never liked passing an int via a pointer for adm1026,
despite how 'natural' Greg claims it is ;-).

> Ah, nice, I hadn't thought about that.  But yes, it would be much
> smaller and simpler to do this, very good idea.
>
> Yani, what do you think?

I like it and think its a good idea, just not for the advantages
Russell listed :-). Functionally it does the same thing, but in a much
more semantically appropriate way:

- It is much more obvious by passing the attribute pointer to the
callbacks what that extra parameter is used for (identifying which
attribute the callback is for).
- No awkward and error-prone casting when all you want to do is pass an int.
- It will be much more transparent to an outsider reading through the
sysfs attribute code that adm1026_attribute represents an adm1026
sensors attribute, and how, etc.

> And if enough i2c drivers want to do this, just make a i2c driver
> attribute that they all use to achieve this.

This sounds like a good idea for the majority of i2c chip drivers,
however in special cases like bmcsensors it might have to use it's own
attribute type (which in bmcsensor's case would contain the sdr_data
struct).

My only present worry is that this makes the creation of a standard
method to dynamically allocate and create derived sysfs attributes a
lot harder (impossible?)...

Thanks,
Yani
