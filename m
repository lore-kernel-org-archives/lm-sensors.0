From: "Tc, Jenny" <jenny.tc@intel.com>
Date: Wed, 16 May 2012 08:48:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Generic ADC support for hwmon
Message-Id: <20ADAB092842284E95860F279283C56422DFB0@BGSMSX101.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1337092008-31263-1-git-send-email-jenny.tc@intel.com>
 <20120515121339.GA21600@ericsson.com>
 <4D68720C2E767A4AA6A8796D42C8EB59124E22@BGSMSX101.gar.corp.intel.com>
 <20120515134257.GA21933@ericsson.com> <4FB265C1.7060306@metafoo.de>
 <4FB268A9.5040007@cam.ac.uk>
In-Reply-To: <4FB268A9.5040007@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, "R, Durgadoss" <durgadoss.r@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Jonathan Cameron <jic23@kernel.org>


> On 5/15/2012 3:18 PM, Lars-Peter Clausen wrote:
> > On 05/15/2012 03:42 PM, Guenter Roeck wrote:
> >> On Tue, May 15, 2012 at 08:42:57AM -0400, R, Durgadoss wrote:
> >>> Hi Guenter,
> >>>
> >>> Thanks for a quick reply.
> >>>
> >>>> On Tue, May 15, 2012 at 10:26:48AM -0400, Jenny TC wrote:
> >>>>> Currently drivers are using custom APIs to communicate with ADC
> driver.
> >>>>> So it make sense to have generic APIs to commnicate with ADC
> drivers.
> >>>>> This patch introduces generic APIs to communicate with ADC drivers.
> >>>>>
> >>>>> Signed-off-by: Jenny TC<jenny.tc@intel.com>
> >>>>
> >>>> Hi Jenny,
> >>>>
> >>>> Do you have a practical use case ?
> >>>
> >>> We have some platform specific component drivers, thermal drivers,
> >>> battery drivers using this General purpose ADC in the platform.
> >>> That's why we thought of doing something like this.
> >>>
> >>>>
> >>>> Also, shouldn't those generic ADCs rather be supported through the
> >>>> IO subsystem ?
> >>>> After all, hwmon is all about hardware monitoring, not to provide
> >>>> generic ADC access.
> >>>
> >>> In this case, can we try this in iio or mfd subsystem ?
> >>> Kindly advise.
> >>>
> >> I meant iio (more specifically staging/iio/adc).
> >>
> >> I suspect it might make more sense to have a hwmon client, in
> >> parallel to the other users/clients (battery control, thermal etc),
> >> if the values reported by the ADC reflect information relevant for
> hardware monitoring.
> >>
> >
> > So there is already an experimental IIO to hwmon bridge in
> > drivers/staging/iio/, which you can use to expose a IIO ADC driver as
> > an hwmon device.
> Thanks Lars-Peter.  That bridge is currently limited to voltage reading but
> that's more because my test part didn't do anything else.
> Trivial to add other bits and bobs as needed.  In the short term, the interrupt
> driven side of things is still under review (so you are limited to polling devices
> - though this is typically fine for hwmon etc).  I'll be submitting a patch to
> move the existing hwmon bridge driver into drivers/hwmon in the next cycle
> (after the IIO core is out of staging).
> 
> Longer term plans involve reducing the connection between the IIO
> userspace front end and the backend to give cleaner support when people
> don't want generic userspace interfaces.  This means making absolutely
> everything under the sun available through generic in kernel interfaces which
> will be 'interesting' for some more interesting devices...
> 
> Jonathan

Hi Jonathan,
Thanks for your reply.
I was looking for generic ADC APIs. At present does the IIO subsystem support any kind of generic ADC APIS which can be used by drivers to read ADC samples?

-jtc


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
