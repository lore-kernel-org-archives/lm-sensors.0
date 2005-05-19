From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: i2cdetect -l is broken
Message-Id: <20040212220929.GA3647@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040211213013.19dccfee.khali@linux-fr.org>
In-Reply-To: <20040211213013.19dccfee.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 12, 2004 at 11:04:18PM +0100, Jean Delvare wrote:
> > > i2cdetect -l is broken on drivers which handle more than a single
> > > i2c bus (radeonfb in my case). It'll print the same name for all
> > > busses, and shouldn't.
> > > 
> > > I took a look at the sysfs tree and I couldn't find any way to
> > > correct it. The fact that i2c-adapters and i2c-devs don't use the
> > > same numbering policy doesn't give us much chance.
> > 
> > But what about the linkages:
> > 
> > $ tree /sys/class/i2c-dev/
> > /sys/class/i2c-dev/
> > `-- i2c-0
> >     |-- dev
> >     |-- device -> ../../../devices/platform/i2c-0
> >     `-- driver -> ../../../bus/i2c/drivers/i2c_adapter
> > 
> > $ tree /sys/class/i2c-adapter/
> > /sys/class/i2c-adapter/
> > `-- i2c-0
> >     |-- device -> ../../../devices/platform/i2c-0
> >     `-- driver -> ../../../bus/i2c/drivers/i2c_adapter
> > 
> > 
> > You can match these devices up by looking at the 'device' symlink. 
> > This works no matter what numbering scheme there currently is, right?
> 
> Yes, it looks like it does. But this requires that we walk both dirs and
> compare the entries. Not something easy to do in C, either we introduce
> data structures and have to handle memory allocations, or we end up with
> a non-linear algorithm.

libsysfs should be able to help you out here.

> With our 2.4 system, the same operations was as simple as "cat
> /proc/bus/i2c".

What did that show? 

> > > As far as I can tell, i2c-adapters numbering policy is to use N+1
> > > for a new adapter, where N is the biggest number already use at the
> > > moment, while i2c-devs numbering policy is to use the lowest
> > > available.
> > 
> > I think this is the same for 2.4, meaning the same problem is there
> > too, right?  But for 2.4, you don't have the sysfs linkage to help you
> > out. How do you solve the problem there?
> 
> I don't know much about the details, and I don't even understand why
> there are two series of identifiers, so I can't speeak about that. But
> for 2.4, the number given by sensors was also the one you could use in
> i2cdump. It never looked like there were two distinct series of
> identifiers there. Either they were in sync, or there was only one
> series, I can't say. And we have the list in /proc/bus/i2c. No need to
> parse a complete tree.

Can you see if the numbers get out of sync:
	modprobe i2c_SOME_ADAPTER_DRIVER
	modprobe i2c_SOME_OTHER_ADAPTER_DRIVER
	modprobe i2c_dev
	rmmod i2c_SOME_ADAPTER_DRIVER
	modprobe i2c_SOME_ADAPTER_DRIVER

where you have both types of adapters in your system (like something and
i2c-isa).  That should get your numbers out of sync on 2.6, right?  What
happens on 2.4?

> What I see from a user-space developer, user and support-guy point of
> view is that this double numbering is a source of problems, and I'd like
> to see it solved if possible.

Ok, can you come up with a patch that might solve this?

thanks,

greg k-h
