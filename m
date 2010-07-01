From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 01 Jul 2010 03:01:25 +0000
Subject: Re: [lm-sensors] Nuvoton W83667HG-B support request
Message-Id: <20100701030125.GA7135@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <295942.63235.qm@web120612.mail.ne1.yahoo.com>
In-Reply-To: <295942.63235.qm@web120612.mail.ne1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 30, 2010 at 03:45:33PM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> Please don't top-post.
> 
Sorry

> On Wed, 30 Jun 2010 10:27:46 -0700, Guenter Roeck wrote:
> > I don't have a datasheet, but from looking into the "Open Hardware Monitor" source
> > it seems that W83667HG and W83667HG-B are identical from a programming perspective.
> > Only difference is the chip ID, which should be 0xb350 instead of 0xa510.
> 
> I have a datasheet, which unfortunately I can't share. I never had the
> time to read it, but as far as I know, the monitoring part is
> compatible with the -A variant, while the automatic fan speed control
> isn't. So a safe approach would be to only enable monitoring and
> disabling the fan speed control interface.
> 
The folks at Nuvoton are actually quite nice and sent me a copy.
I browsed through it, specifically the fan control section, but I don't see
what might be different to the current implementation. Of course it would help
to have a copy of the W83667HG datasheet to be able to compare .. I'll see
if I can get that one as well.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
