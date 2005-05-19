From: andi@rhlx01.fht-esslingen.de (Andreas Mohr)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: 2.6.4: strange (?) include path order
Message-Id: <20020807220741.A30347@rhlx01.fht-esslingen.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020807205413.A23077@rhlx01.fht-esslingen.de>
In-Reply-To: <20020807205413.A23077@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 07, 2002 at 09:43:17PM +0200, Jean Delvare wrote:
> > Currently having a look at the perl script detection code...
> > Hmm, weird stuff. Not sure yet what can be done about that.
> 
> I don't get you. What do you mean?
I was thinking out loud.

I hope I'll be able to come up with a solution to this problem
(i.e. maybe scan *twice* for problematic PCI IDs, once to detect the
chipset and once for finding out about the *real* chip, e.g. by
searching for other IDs on the board that indicate such-and-such chip)

We could also add an "advice" string for each entry in the pci_adapters list
maybe.
That way we could print some warnings/hints for certain adapters.
(such as "try using it87 chip driver for misdetected SiS 8895 modules")

-- 
Microsoft Licensing 6.0: "Pay us now in advance, so that we can own you later."
