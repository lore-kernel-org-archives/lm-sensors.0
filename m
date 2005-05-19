From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6.12-rc4 3/3] (dynamic sysfs callbacks) device_attribute
Message-Id: <25381867050511125761fcfad0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705051100583c6b1ffb@mail.gmail.com>
	 <20050511170600.GD15398@kroah.com>
In-Reply-To: <20050511170600.GD15398@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org, Justin Thiessen <jthiessen@penguincomputing.com>

On 5/11/05, Greg KH <greg@kroah.com> wrote:
> On Wed, May 11, 2005 at 03:58:35AM -0400, Yani Ioannou wrote:
> > -static ssize_t show_in(struct device *dev, char *buf, int nr)
> > +static ssize_t show_in(struct device *dev, char *buf, void *private)
> >  {
> > +     int nr = *((int*)private);
> 
> What's wrong with a simple:
>         int nr = (int)private;

Ouch, yes thanks for catching that, that's horribly wrong. Its a
leftover from a previous example where I was actually was passing int*
not int. I'll fix up the example and resend it. That is what comes
from not being able to test it I guess.

> Sorry, but I need a real patch in email form so I can apply it.  I can
> handle a 300K+ email :)
> 
> Or you can break it up into smaller pieces, like one per major part of
> the kernel.  That is the preferred way.

I'd like to break it up, but I think even broken up by major part of
the kernel it one piece will still be too large since the majority of
the changes take place in drivers & drivers/i2c and are very
asymmetric :-(. I'll send you the patch inline privately for now.

> We should make a __ATTR macro instead, right?

Well another __ATTR macro (e.g. ATTR_PRIVATE) would make declaring the
new DEVICE_ATTR_PRIVATE macro, etc, easier. We can't really use __ATTR
nicely though when declaring static attributes and wanting to set the
private data, hence why I think there is the need for a macro (see
http://archives.andrew.net.au/lm-sensors/msg31399.html).

The question really is, is it better to just add that new parameter to
the DEVICE_ATTR macro, or to declare a new DEVICE_ATTR_PRIVATE macro
instead. The former obviously breaks a lot of code although my scripts
can generate another large patch for that too...

Thanks,
Yani
