From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: i2c-sis630 driver (fixed?)
Message-Id: <20030802022453.GA15700@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030801230134.6fdf60dc.khali@linux-fr.org>
In-Reply-To: <20030801230134.6fdf60dc.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Alexander Malysh <amalysh@web.de> [2003-08-01 23:21:59 +0200]:
> Hi Jean, Mark,
> 
> i do not know what is to do here :(
> i2c-sis630 is not a pci driver and should not claim any pci devices. 
> i2c-sis630 use only io ports and pci device look up used only in order to 
> determine if it a right sis chip et all. I want to revert pci changes and 
> commit it, if nobody has any objections.

On one hand it should be a PCI driver.  After all it does read (and
potentially write) in the PCI config space of the bridge device - 
even if that's only at device init.

But then again, if there are other functions hidden there that some
other driver might use, we're back to the same problem.

> Mark, what do you think about it? Why should be such detect method not 
> accepted in 2.4.X ?

Well maybe it's not forbidden, but discouraged.  Again, I'm not sure
what is the right thing.  If we don't hear fresh advice in a few
days I'll ask on LKML.

> On Friday 01 August 2003 23:01, Jean Delvare wrote:
> > Mark, Alexander,
> >
> > Is the i2c-sis630 driver considered fixed or not? Shall I close the
> > tickets 1350 and 1351?
> >
> > (My reading of the thread makes me think there still is a discussion
> > about what should be done, but I don't know what I am supposed to do
> > with the tickets.)

The code in CVS should work just fine.  I would say the tickets can be
closed because (unless we're very sloppy) that bug won't happen again.
What we discuss above is related but more subtle.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
