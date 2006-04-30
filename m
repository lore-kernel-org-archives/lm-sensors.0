From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 30 Apr 2006 12:17:07 +0000
Subject: [lm-sensors] Address configuration for scx200_acb
Message-Id: <20060430141707.28c6ea66.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427234114.941c9657.khali@linux-fr.org>
In-Reply-To: <20060427234114.941c9657.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thomas,

[Jean Delvare]
> > Looks like standard LPC/Super-IO register mapping. Are the SC1100 and
> > SCx200 LPC chips? What are the values of CFG_INDEX and CFG_DATA in the
> > code snippet above? I'd guess/hope 0x2e and 0x2f respectively (or 0x4e
> > and 0x4f.)
> > 
> > I don't have much time to work on that myself, especially when I have
> > no hardware to test this on, but if you or anyone else could prepare a
> > patch implementing the idea above in the scx200_acb driver, so that
> > other users can give it some testing, this would be great.

[Thomas Andrews]
> I don't actually know what "LPC/Super-IO" means, but the data-sheet for
> the SC1100 seems to indicate that it is so:
> 
>     "The LPC interface of the Core Logic module is based on the Intel Low
>     Pin Count (LPC) Interface specification, revision 1.0."
> 
> and also:
> 
>     "LPC SuperI/O Addressing. SuperI/O control addresses I/O Ports 2Eh-2Fh.
>     See bit 16 for decode"
> 
> And as you suggested, there is another address pair that can be used:
> 
>     "LPC Alternate SuperI/O Addressing. Alternate SuperI/O control addresses
>     4Eh-4Fh. See bit 16 for decode."
> 
> In the code snippet above, I used 0x2e & x2f. I don't know how you
> determine which pair to use. I just tried the first one. Is there a
> "standard" way to select it?

Usually the address is selected by hardware, by latching the state of
one pin of the chip at power-up. So, most of the time you just have to
try both address pairs. See function w83627hf_find in
drivers/hwmon/w83627hf.c for an example. 0x2e/0x2f is almost always
the right address pair.

> I will submit a patch once I have a better understanding.

Great, thanks.

-- 
Jean Delvare

