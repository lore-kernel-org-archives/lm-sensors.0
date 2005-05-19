From: amalysh@web.de (Alexander Malysh)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: i2c-sis630 driver (fixed)
Message-Id: <200307310059.52973.amalysh@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307302234.43914.amalysh@web.de>
In-Reply-To: <200307302234.43914.amalysh@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

hmm, now I have undestand the problem... But it is not a right fix too (imo).
with your changes i2c-sis630 will claim ISA brigde and block others if they 
want use it or I missed anything? i2c-sis630 doesn't use isa brigde only for 
detection of acpi base address.

my proposal is to revert pci changes made by MDS and do the old detection.

On Thursday 31 July 2003 00:35, Mark M. Hoffman wrote:
> Hi Alex:
>
> * Alexander Malysh <amalysh@web.de> [2003-07-30 22:34:39 +0200]:
> > Hi again,
> >
> > the bug is fixed now... I do not know how to close the tikets.
>
> It still has a bug: the pci system will associate the 630 or 730
> device with your driver, such that no other driver (if there was
> one) which might claim that device will work.  The thread where
> this was first mentioned is here:
>
> http://archives.andrew.net.au/lm-sensors/msg03193.html
>
> So how about this patch? (against CVS, compiles, untested)
>
> Regards,

-- 
Best regards,
Dipl.-Ing.
Alexander Malysh
