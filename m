From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: [PATCH 0/63] convert usb_control_msg() and usb_bulk_msg() to
Message-Id: <20050212023045.2008469a@zanzibar.2ka.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050209000212.GB5661@us.ibm.com>
In-Reply-To: <20050209000212.GB5661@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 9 Feb 2005 11:39:29 -0800
Nishanth Aravamudan <nacc@us.ibm.com> wrote:

[ subscribers-only mail lists removed from Cc: ]

> On Wed, Feb 09, 2005 at 10:41:44PM +0300, Evgeniy Polyakov wrote:
> > On Tue, 8 Feb 2005 16:02:12 -0800
> > Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> > 
> > > Hi,
> > > 
> > > The following patchset (affecting USB, Bluetooth, IrDA, Sound, DVB and W1 --
> > > hence the long To: an Cc: lists...) converts the usb_control_msg() and
> > > usb_bulk_msg() functions to use milliseconds in the timeout parameter instead
> > > of jiffies. This is not a problem for almost all cases, as the requested delays are usually quite long wrt. these two functions.
> > 
> > As for w1 - this changes do not break anything, but
> > I'm not sure that it will not break usb core code which can
> > depend on jiffies and thus arch specific timings.
> > 
> > So I have a question: is this change intentional and thus by design requires
> > milliseconds, or it just happens that HZ=1000 on the most of the platforms?
> 
> So the first check I did, at Greg's suggestion, was to verify the timing
> units for usbdevfs, which are milliseconds. So we should be ok there.
> Second, all of these patches don't change the fact that jiffies are
> used. They only move the usage of jiffies further into the usbcore, thus
> making the actual API be in human time-units and relying on correct
> translation from HZ-independent units (milliseconds) to HZ-dependent
> units (jiffies) in one place.
> 
> So the change is very much intentional, but it's an API change only. The
> timeout parameter is not even used until usb_start_wait_urb() and
> presuming msecs_to_jiffies() does what we want (and I've verified it
> does for the most common cases), then the timer in usb_start_wait_urb()
> will be set for the same number of jiffies.
> 
> Really, this just makes it easier for me later on to go through and
> re-audit timer usage :) If we do change the timer core (and I'm working
> on figuring out how exactly to do so), then only changing in one place
> down the road is better than all of these patches going out then *along
> with* a huge rework of core kernel code...
> 
> So, in conclusion, these patches shouldn't break anything for anyone, if
> I got my conversions correct. Most drivers were passing HZ * __some_var
> or HZ / 10, anyways, which is expressible easily in human time units via
> 1000 * __some_var or 100, respectively. So it shouldn't change anything,
> except in what units we are dealing.
> 
> Let me know if you see anything that points to the contrary (in USB core
> code, or anywhere else).
> 
> Thanks for the feedback!

Ok, I did not find anything suspicious after diagonal view, 
so I'm ok with all your changes for w1 and usb.

I will apply them to my tree when Greg pushes usb changes upstream.


Thank you.
 
> -Nish


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
