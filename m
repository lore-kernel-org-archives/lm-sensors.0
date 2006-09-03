From: greg@kroah.com (Greg KH)
Date: Sun, 03 Sep 2006 01:46:45 +0000
Subject: [lm-sensors] TODO: "dynamic" sysfs callbacks
Message-Id: <20060903014645.GC2481@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F1E5B6.1080105@gmail.com>
In-Reply-To: <44F1E5B6.1080105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 02, 2006 at 10:57:03PM +0200, Jean Delvare wrote:
> > On Sat, Sep 02, 2006 at 04:24:01PM +0200, Jean Delvare wrote:
> > > I don't have the time to even try measuring it. I just thought I would
> > > mention performance in the conversation, after I noticed with a user
> > > some days ago that logging sensors data using "sensors" every other
> > > second would put 15% of load on the system, while I expected it
> > > to be unnoticeable.
> > 
> > This is probably just due to an interruptable sleep happening, which
> > artificially increases the load average.  I would be supprised if the
> > CPU usage really goes up by that much.
> 
> The bus driver msleep()s, so it's rather an uninterruptible sleep?

Yes it is.

> Not that I know what different it makes in that context.

When you sleep in the kernel, in an uninterruptable state, it increases
the load average spit out by the kernel by 1.  Now this really doesn't
make that much sense, as the code is sleeping and not doing anything at
all, but it plays havoc on tools that look at the load average of the
machine to see what is going on.

That might be why users think the driver is taking up more cpu time than
it really is, but it all depends on how they were measuring it.

thanks,

greg k-h

