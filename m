From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Jul 2011 13:46:18 +0000
Subject: Re: [lm-sensors] RFC: Moving pmbus drivers into hwmon subdirectory
Message-Id: <20110714134618.GA6273@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110712021230.GA22766@ericsson.com>
In-Reply-To: <20110712021230.GA22766@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jul 14, 2011 at 07:52:24AM -0400, Jean Delvare wrote:
> On Tue, 12 Jul 2011 08:38:49 +0200, Jean Delvare wrote:
> > On Mon, 11 Jul 2011 19:12:30 -0700, Guenter Roeck wrote:
> > > Hi all,
> > > 
> > > since the number of PMBus slave/client drivers keeps getting larger,
> > > I have been wondering if I should move them into a separate subdirectory,
> > > most likely drivers/hwmon/pmbus/.
> > > 
> > > Any thoughts/comments about that ?
> > 
> > Seems to be a good idea, yes.
> 
> Thinking some more about this... Does PMBus fit entirely in hwmon, or
> does it cover additional functions? If it does cover additional
> functions, then maybe drivers/pmbus would be a better place.
> 
Hi Jean,

The functionality implemented today is pure hwmon functionality and thus
belongs entirely into hwmon.

It may at some point be of interest to add regulator functionality.
If so, the way to do it would be to move generic (ie chip read/write code)
functionality to mfd and implement regulator and hwmon frontends.
I would be very hesitant to do that, though. First, I have not seen an actual
use case for it, and second it is extremely dangerous to change voltages,
and very easy to literally blow up a chip or even an entire board
if a chip is programmed with values it does not like (I have blown up
several of my test boards ;).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
