From: se.witt@gmx.net (Sebastian Witt)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: ATXP3 and ATXP5
Message-Id: <42777B73.10203@hasw.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4277310B.9060700@sh.cvut.cz>
In-Reply-To: <4277310B.9060700@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Rudolf Marek wrote:

> No I have ATXP2 even. I cant regulate voltage (athough I can set VID register and load atxp1 module), but this chip can regulate FSB

The ATXP5/2 doesn't seem to have the VID in/outputs. But they have the FID (multiplier) and GPIO registers. FID changing has normally
no effect during runtime, because it's only used during power-up (at least on the AMD cpu, not sure about the SiS chipset).

> Near this chip is DIP switch to adjust FSB manually.
> It has 24 legs total.
> 
> DIP SW combinations:
> 
> 133 166 [OFF] [OFF]  [ON]  [ON]
> 100 133  [ON]  [ON]  [ON] [OFF]
> 133 100 [OFF]  [ON]  [ON] [OFF]
> 133 133 [OFF]  [ON] [OFF] [OFF]
> 100 100 [OFF] [OFF] [OFF] [OFF
> 
> So I think ATXP2 can adjust FSB and MEM frq somehow.

Yes, maybe they are using the GPIO pins, but then the switches must be in
a specific position so the GPIO outputs are getting priority...

Can you please run i2cdump on the ATXP2 ?

Bye,
Sebastian
