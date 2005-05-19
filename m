From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6.12-rc4 3/3] (dynamic sysfs callbacks) device_attribute
Message-Id: <20050511202805.GB2222@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705051100583c6b1ffb@mail.gmail.com> <20050511170600.GD15398@kroah.com> <25381867050511125761fcfad0@mail.gmail.com>
In-Reply-To: <25381867050511125761fcfad0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org, Justin Thiessen <jthiessen@penguincomputing.com>

On Wed, May 11, 2005 at 03:57:37PM -0400, Yani Ioannou wrote:
> On 5/11/05, Greg KH <greg@kroah.com> wrote:
> > On Wed, May 11, 2005 at 03:58:35AM -0400, Yani Ioannou wrote:
> > Sorry, but I need a real patch in email form so I can apply it.  I can
> > handle a 300K+ email :)
> > 
> > Or you can break it up into smaller pieces, like one per major part of
> > the kernel.  That is the preferred way.
> 
> I'd like to break it up, but I think even broken up by major part of
> the kernel it one piece will still be too large since the majority of
> the changes take place in drivers & drivers/i2c and are very
> asymmetric :-(. I'll send you the patch inline privately for now.

No, please break it up.  "too large" is a problem for someone trying to
review it too.  If the i2c parts are too big, then split them up into
multiple patches too.

> > We should make a __ATTR macro instead, right?
> 
> Well another __ATTR macro (e.g. ATTR_PRIVATE) would make declaring the
> new DEVICE_ATTR_PRIVATE macro, etc, easier.

Sorry, yes, that's what I ment.

> The question really is, is it better to just add that new parameter to
> the DEVICE_ATTR macro, or to declare a new DEVICE_ATTR_PRIVATE macro
> instead. The former obviously breaks a lot of code although my scripts
> can generate another large patch for that too...

No, use a new macro.

thanks,

greg k-h
