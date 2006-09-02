From: greg@kroah.com (Greg KH)
Date: Sat, 02 Sep 2006 07:08:09 +0000
Subject: [lm-sensors] TODO: "dynamic" sysfs callbacks
Message-Id: <20060902070809.GA11895@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F1E5B6.1080105@gmail.com>
In-Reply-To: <44F1E5B6.1080105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 02, 2006 at 08:52:47AM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> > On Fri, Sep 01, 2006 at 02:33:42PM +0200, Jean Delvare wrote:
> > > Beyond the readability of the code, there are some performance issues
> > > to consider. For example I wonder how the code above interacts with the
> > > CPU cache, compared to 1-level-indexed callbacks, in the typical
> > > "sensors" scenario. I don't really have the time to investigate this,
> > > unfortunately. Switch/case is usually not recommended in performance
> > > terms, even though I'd expect gcc to optimize it relatively nicely if
> > > the "func" values are chosen wisely.
> > 
> > I don't really think it maters at all.  This code is not cache "hot" by
> > any means.  It's doing something pretty infrequently,
> 
> Could happen once every second or every other second, if the user has a
> GUI with sensors data (gkrellm, ksensors, xsensors...) I think it
> qualifies as "frequent".

No, that's not "frequent" at all for cache related things.  A processor
can do an lot in a second or two :)

> >                                                       and the i2c
> > protocol is _so_ slow it's not funny.  These are not high-performance
> > things we are dealing with at all.
> 
> Not all hardware monitoring chips are i2c-based. I agree that all hwmon
> drivers do quite a lot of I/O though, be it on the SMBus or ISA bus. But
> it's hardly a reason not to make the rest of the driver code smaller
> and faster if we can.

Sure, I'm not saying that at all.  It's just that trying to optimize for
things that you can not even measure, isn't a good thing.

Size of the module, yes, that's fine, but look at percentages.  Shaving
a few bytes here and there at the expense of readablity and
maintainablity is not worth it.

Cache usage of driver code that is run every other second?  Very hard to
measure, it will be lost in the noise...

thanks,

greg k-h

