From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Jul 2012 18:38:40 +0000
Subject: Re: [lm-sensors] GA-Z77X-UD3H with ITE IT8728F, modprobe it87  freezes system
Message-Id: <20120711203840.6a4d22d5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJiZuY3QBnkcAsisvbg9pEzMt044aVBF+vwzrCHsGTS_N9ez1A@mail.gmail.com>
In-Reply-To: <CAJiZuY3QBnkcAsisvbg9pEzMt044aVBF+vwzrCHsGTS_N9ez1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 Jul 2012 11:31:24 -0700, Guenter Roeck wrote:
> On Wed, Jul 11, 2012 at 06:10:43PM +0200, Jean Delvare wrote:
> > The 0xb7 is from the very first version of the it87 driver by Christophe
> > Gauthron 11 years ago. I have no idea why bit 3 was explicitly cleared back
> > then.
>
> Oversight, maybe, or the bit name was confusing.
> 
> It doesn't make much sense to enable SMI interrupts while keeping global
> interrupts disabled. We may just have been lucky to never hit this problem.

I think so, yes.

> > > Replacing the 0x36 mask above with 0x3e might possibly solve the problem.
> > 
> > Indeed. I'm not too sure what to do about bit 5, BTW, it might be
> > self-clearing as bit 7.
>
> I'd keep it as-is. Not worth trying to solve a problem which may not exist.

Agreed. I'll push the fix to Linus ASAP.

Thanks Stevie for the quick test report!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
