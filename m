From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 01 Aug 2013 17:46:53 +0000
Subject: Re: [lm-sensors] w83627ehf: Wrong values reported after resuming from suspend/hibernation
Message-Id: <20130801174653.GA17398@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <50856051.5070803@gmx.at>
In-Reply-To: <50856051.5070803@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 01, 2013 at 04:36:43PM +0200, Harald Judt wrote:
> Hi,
> 
> Am 01.08.2013 15:42, schrieb Guenter Roeck:
> > On 08/01/2013 02:08 AM, Harald Judt wrote:
> >> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >> 
> >> Am 01.08.2013 00:11, schrieb Guenter Roeck:
> >>> On Mon, Jul 29, 2013 at 05:27:35PM +0200, Harald Judt wrote: [
> >>> ... ]
> >>>> 
> >>>> -- `Experience is the best teacher.'
> >>>> 
> >>> 
> >>>> From c3961cf2fa1d6975b9bcffeb746c57bda09e7489 Mon Sep 17
> >>>> 00:00:00 2001 From: Harald Judt <h.judt@gmx.at> Date: Mon, 29
> >>>> Jul 2013 17:00:27 +0200 Subject: hwmon: (nct6775) Add support
> >>>> for hibernate
> >>>> 
> >>> Hi Harald,
> >>> 
> >>> Signed-off-by: is missing. Ok if I add your Signed-off to the
> >>> patch ?
> >>> 
> >>> Thanks, Guenter
> >> 
> >> Sure, no problem, I didn't think about that. Also, even though 
> >> deprecated, probably a similar patch would be needed for the
> >> original w83627ehf.c. I could create, test and send you another
> >> such patch today in the evening or tomorrow. Otherwise,
> >> 
> > Yes, that would be great.
> > 
> >> Signed-off-by: Harald Judt <h.judt@gmx.at>
> >> 
> > Thanks!
> > 
> > Guenter
> 
> Attached you will find the two patches, tested and this time already
> signed-off.
> 
Both applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
