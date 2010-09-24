From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 24 Sep 2010 04:45:58 +0000
Subject: Re: [lm-sensors] Intel ICH8/QST Support
Message-Id: <20100924044558.GA16034@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik6Lo4Y+pRGN=sP39dndeQc9tHRpYKt60NqdiMt@mail.gmail.com>
In-Reply-To: <AANLkTik6Lo4Y+pRGN=sP39dndeQc9tHRpYKt60NqdiMt@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Sep 24, 2010 at 12:09:52AM -0400, Maxim Levitsky wrote:
> On Tue, 2010-09-14 at 18:49 -0700, Guenter Roeck wrote:
> > On Tue, Sep 14, 2010 at 09:35:19PM -0400, Matthew Manuel wrote:
> > > Should it be possible to add support for these now that the SDK was released?
> > > 
> > > http://software.intel.com/en-us/articles/Intel_Quiet_System_Technology_Software_Development_Kit/
> > > 
> > The programmer's reference manual points to http://www.openamt.org for a linux driver.
> 
> The driver just does a transport of commands from/to the firmware.
> It pity though it was never merged upstream.
> 
> The so long waited QST SDK however specifies what to send, and it looks
> good.
> The PDF included nice detailed description of QST 2.0, while SDK sources
> (which are more or less useless other that a good source of
> documentation, contain headers that declare commands for QST 1.0, so it
> really all covered. More that that, I see that it even included
> description on how to manually control the fans if BIOS didn't lock that
> up, and passthrough mode to talk to sensors (again if bios didn't lock
> that).
> 
> Cool stuff it seems.
> Too bad it took so many years, my desktop is quite old now.
> 
Usually Intel is pretty good nowadays in pushing code into the kernel.
They would be the natural entity to do it ...

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
