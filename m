From: tux99-lmsens@uridium.org
Date: Thu, 23 Jun 2011 14:05:23 +0000
Subject: Re: [lm-sensors] sensors.conf for Sapphire Pure Fusion Mini E350
Message-Id: <Pine.LNX.4.44.1106231537060.5361-100000@outpost-priv>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44.1106100224380.17715-100000@outpost-priv>
In-Reply-To: <Pine.LNX.4.44.1106100224380.17715-100000@outpost-priv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 22 Jun 2011, Jean Delvare wrote:

> On Fri, 10 Jun 2011 02:31:14 +0200 (CEST), tux99 wrote:
> > 
> > Hi,
> > I just wanted to contribute my sensors.conf for the Sapphire Pure Fusion 
> > Mini E350 motherboard. I'm quite confident about the accuracy of the 
> > config, I spent a fair amount of time verifying each bit.
> > I also posted this here:
> > http://scientificlinuxforum.org/index.php?showtopicA5
> > 
> > #----------------------------------
> > # lm-sensors config for Sapphire Pure Fusion Mini E350 board
> > 
> > chip "f71808e-*"
> > 
> >    label  in0  "VCC  +3.3V"
> >    # E-350 Vcore range is ~ 0.5V-1.35V (lowest idle state to max load)
> >    label  in1  "CPU  Vcore"
> >    ignore in2
> >    label  in3  "DDR3 VDIMM"
> >    label  in4  "FCH  +1.1V"
> >    label  in5  "PCIe +1.8V"
> >    label  in7  "3VSB +3.3V"
> >    label  in8  "VBAT +3.0V"
> > 
> >    compute in0  @*2, @/2
> >    compute in3 (@ * 1.465), (@ / 1.465)
> 
> This is surprising. DDR3 would be +1.5V, which fits on 8 bit with a 8
> mV ADC, so no scaling should be needed. Do you have a reason to believe
> that DDR3 voltage is actually monitored on your system?

I agree it's surprising but to the best of my knowledge it's correct.
If you look at the mobo manual [1] (page 25) it has a screenshot of the 
BIOS H/W monitor page, the order matches exactly the in0-in8 order in my 
config. Since all other inputs can be verified in other ways, the BIOS 
order seems to exactly reflect the in0-in8 order and therefore in3 must 
be VDIMM just like the fourth entry on the BIOS screen is.

The F71808E manual [2] seems to indicate also that VIN3 should be used 
for VDIMM.

I got the multiplier (1.465) by comparing the BIOS read-out on my mobo 
with the unmultiplied lm-sensors output on my mobo.

As a side note in2 appears as +1V in the BIOS screenshot of the manual 
but has been removed from the latest BIOS release that my mobo is 
running, therefore I have ignored it too.

[1] http://eu2.sapphiretech.com/archive/gm/drivers/E350M1_User_Manual_V1_634333870684900000.1.zip
[2] http://www.fintek.com.tw/files/productfiles/F71808E_V0.21P.pdf

> >    compute in7  @*2, @/2
> >    compute in8  @*2, @/2
> > 
> >    label fan1 "CPU Fan"
> >    label fan2 "SYS Fan"
> > 
> >    ignore fan3
> > 
> >    label  temp1 "SYS Temp1"
> >    label  temp2 "SYS Temp2"
> > 
> > chip "k10temp-*"
> > 
> >   label temp1 "CPU Temp"
> 
> I've put your file at:
> http://www.lm-sensors.org/wiki/Configurations/Sapphire/PureFusionMiniE350
> 
> Thanks for your contribution.
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
