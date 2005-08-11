From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 11 Aug 2005 19:12:22 +0000
Subject: [lm-sensors] Re: I2C block reads with i2c-viapro: testers wanted
Message-Id: <20050811191223.4294c57b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050809231328.0726537b.khali@linux-fr.org>
	<42FA6406.4030901@cetrtapot.si>
	<20050810230633.0cb8737b.khali@linux-fr.org>
	<Pine.LNX.4.60.0508110022030.3532@kepler.fjfi.cvut.cz>
In-Reply-To: <Pine.LNX.4.60.0508110022030.3532@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Martin,

> > But I don't know where the VT8231, VT8233 and VT8233A should be
> > inserted in this list. If anyone can tell me...
> 
> I guess it's just the way it seems:
> 
> VT82C596
> VT82C596B
> VT82C686A
> VT82C686B
> VT8231
> VT8233
> VT8233A
> VT8235
> VT8237

I'd agree for VT8233 and VT8233A according to some searches I did this
morning. However, the VT8231 doesn't seem to fit in the list. Here are
the facts I am aware of that led me to this conclusion:

* It seems to appear only on specific boards, such as the Epia ones, and
is rarely mentioned on common hardware sites, compared to all the other
ones.

* It was presented by VIA at the Cebit in march 2002, which corresponds
to the release of the VT8233A.

* The support was added to the i2c-viapro driver in May 2002, that is,
after VT8233 (October 2001) and VT8233A (March 2002.)

* Its PCI ID is completely different (0x8231, while all other supported
devices are in the 0x3000-0x31FF range.)

So I think it doesn't exactly fit in the release timeline, and is more
likely a custom product derived from the VT82C686 (A or B) rather than a
linear evolution.

For this reason, I won't extrapolate the results to the VT8231. I will
only enable I2C block support for it if someone with such a chip agrees
to test the support first.

Thanks,
-- 
Jean Delvare
