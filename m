From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 22 Mar 2007 09:33:15 +0000
Subject: [lm-sensors] MSI K9N4 SLI-F sensors-detect says use w83627ehf
Message-Id: <20070322103315.581cea81.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0703201232150.24717@www.curtronics.com>
In-Reply-To: <Pine.LNX.4.63.0703201232150.24717@www.curtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jan,

On Wed, 21 Mar 2007 20:41:36 +0100, Jan van Tiggelen wrote:
> The chip is indeed a W83627DHG, instead of the W83627EHF. It's a good catch
> that you got it working. But, after reviewing the schematics, of which the
> W83267EHF is public via:
> http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83627EHF_EHG
> c.pdf
> 
> 1 - The W83627DHG features are at some parts very different from the
> W83627EHF: It has Intel PECI/SST interface support (why would they use that
> on an AMD mainboard?), Dual-current mode temperature sensing, 4-pin FAN
> support, alerting outputs and also a 8 VID I/O. 

You shouldn't expect the consumer board manufacturers to pick the best
chip for their board, nor to wire it in an optimal way. In general they
care more about low prices (which they achieve with high volumes) than
technical correctness.

> 2 - Derriving from (1) the pin-out purposes are very different in this case.
> E.g. pin 119 (CPUFAN) which was used as a CPU-fan connection, the 'new pin'
> used for that function is pin 121 and rated at 'Default High' (probably only
> at boot time)
> 
> 3 - From the (internal) BIOS notes I can tell you that the instruction set
> in the bios for W627EHF and W627DHG is almost similar, except for the 4-pin
> FAN feature. The rest of the instruction set is based on SMARTFAN III code.
> 
> Lastly, on a side note, I have to say that I'm not 100% sure what impact
> this has on the suggested 'changes' between 627EHF and 627DHG driver. I'll
> leave that up to someone else to determine. (David / Jean?)

On our side, we don't care that much about pins. We care about
registers. If the pinout is different but the registers are the same,
the driver doesn't need any special care. The w83627ehf driver already
differentiates between the W83627EHF and W83627DHG where it needs to. If
you see anything that is not handled properly in that respect on a
real-world motherboard, that's a bug, report it to David.

-- 
Jean Delvare

