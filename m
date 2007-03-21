From: den_tichel@zonnet.nl (Jan van Tiggelen)
Date: Wed, 21 Mar 2007 19:41:36 +0000
Subject: [lm-sensors] MSI K9N4 SLI-F sensors-detect says use w83627ehf
Message-Id: <20070321194138.59996529C@mta-fe.casema.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0703201232150.24717@www.curtronics.com>
In-Reply-To: <Pine.LNX.4.63.0703201232150.24717@www.curtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Curt, David, Jean, hi, (again)

The schematics are in your personal boxes. I will not post them to the list.

> 
> On Wed, 21 Mar 2007, David Hubbard wrote:
> 
> And, when you get the schematic for this MB, I would greatly appreciate it
> if you could tell me what input is what voltage. 
> I'd also lik to see if the Northbridge fan is connected to the w83627dhg. 
> 
> -Curt
> > 
> > If you were getting unknown device ID, we should probably add another
> > device ID to the driver (0xa020 ?). I'll take a look at it when I get 
> > home tonight.
> > 
> > David
> > 
> 
> Hi David, 
> 
> No I think the Device ID issue is due to the mask needing to be 0xFFE0 as 
> Jan pointed out. I'm going to change that and try it.
> 
> -Curt
> 

The chip is indeed a W83627DHG, instead of the W83627EHF. It's a good catch
that you got it working. But, after reviewing the schematics, of which the
W83267EHF is public via:
http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83627EHF_EHG
c.pdf

1 - The W83627DHG features are at some parts very different from the
W83627EHF: It has Intel PECI/SST interface support (why would they use that
on an AMD mainboard?), Dual-current mode temperature sensing, 4-pin FAN
support, alerting outputs and also a 8 VID I/O. 

2 - Derriving from (1) the pin-out purposes are very different in this case.
E.g. pin 119 (CPUFAN) which was used as a CPU-fan connection, the 'new pin'
used for that function is pin 121 and rated at 'Default High' (probably only
at boot time)

3 - From the (internal) BIOS notes I can tell you that the instruction set
in the bios for W627EHF and W627DHG is almost similar, except for the 4-pin
FAN feature. The rest of the instruction set is based on SMARTFAN III code.

Lastly, on a side note, I have to say that I'm not 100% sure what impact
this has on the suggested 'changes' between 627EHF and 627DHG driver. I'll
leave that up to someone else to determine. (David / Jean?)

Kind regards,

Jan van Tiggelen


