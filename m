From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 21 Nov 2007 19:19:43 +0000
Subject: Re: [lm-sensors] broken suspend [Was: 2.6.24-rc2-mm1]
Message-Id: <200711212019.45071.rjw@sisk.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44L0.0711211053140.3226-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0711211053140.3226-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, Rudolf Marek <r.marek@assembler.cz>, Jiri Slaby <jirislaby@gmail.com>, Greg KH <greg@kroah.com>, Kernel development list <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Wednesday, 21 of November 2007, Alan Stern wrote:
> On Wed, 21 Nov 2007, Rafael J. Wysocki wrote:
> 
> > > Is it possible to unregister a driver on CPU_DOWN_PREPARE_FROZEN?
> > 
> > No.  In that case the suspend core is holding the device's mutex and your
> > attempt to unregister it will deadlock with it.
> > 
> > Do you _have_ _to_ unregister the device at all?  Why don't you just leave
> > it registered on CPU_DOWN_PREPARE_FROZEN?  The CPU is not going away
> > physically in this case and it's _guaranteed_ that _cpu_up() will be called on
> > it as soon as the hibernation image is ready or we are back from suspend.
> 
> This leaves the device registered if for some reason the number of CPUs 
> after resuming from hibernation is smaller than the number of CPUs 
> before hibernation.  Of course, in theory that's never supposed to 
> happen...

Yes, that clearly would be a bug.

Rafael

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
