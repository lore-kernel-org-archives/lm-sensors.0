From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Mon, 20 Dec 2010 15:37:44 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 V3] applesmc: Use PnP rather than
Message-Id: <20101220153744.GA20068@polaris.bitmath.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101218110954.7a2ca190@endymion.delvare>
 <20101218103139.GA1668@polaris.bitmath.org>
 <878vzngvyn.fsf@sonic.technologeek.org>
 <20101218115742.GA2063@polaris.bitmath.org>
 <1292852674.2118.10.camel@mike-laptop>
 <20101220145721.4c58ff3e@endymion.delvare>
 <20101220142344.GA19566@polaris.bitmath.org>
 <20101220142815.GA23998@srcf.ucam.org>
 <20101220150648.GA19922@polaris.bitmath.org>
 <20101220151258.GA25008@srcf.ucam.org>
In-Reply-To: <20101220151258.GA25008@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jean Delvare <khali@linux-fr.org>, Mikael =?iso-8859-1?Q?Str=F6m?= <mikael@sesamiq.com>, Julien BLACHE <jb@jblache.org>, Guenter Roeck <guenter.roeck@ericsson.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Dec 20, 2010 at 03:12:58PM +0000, Matthew Garrett wrote:
> On Mon, Dec 20, 2010 at 04:06:48PM +0100, Henrik Rydberg wrote:
> > On Mon, Dec 20, 2010 at 02:28:15PM +0000, Matthew Garrett wrote:
> > > 
> > > There is one, you just need to hook into the thermal device interface.
> > 
> > Right. The fans and the right sensors need to be plugged in, which
> > seems like it should happen at the same time the platform device is
> > removed. Thanks to macfanctld, there might even be enough information
> > regarding what sensors to use. Just about.
> 
> I've been looking into this. The thermal control code under MacOS seems 
> to tie into the GPU and CPU power management as well, and I suspect that 
> this has more to do with the thermal issues we're seeing than the fan 
> control alone.

Yes, I think you are right. To conclude so far, I think it is great
that there is an effort to elevate apple hardware support in general.
I just do not see it happening overnight. If we tread lightly, we
should be able to start off by removing dmi matching and properly
support efi booting, and take it from there.

Thanks,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
