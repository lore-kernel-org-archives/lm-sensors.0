From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Date: Thu, 01 Jul 2010 12:44:30 +0000
Subject: Re: [lm-sensors] [RFC] [PATCH] Board changes for tmp105 temperature
Message-Id: <0680EC522D0CC943BC586913CF3768C003B360314E@dbde02.ent.ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <0680EC522D0CC943BC586913CF3768C003B34A6404@dbde02.ent.ti.com>
 <20100701121711.GM2822@atomide.com>
In-Reply-To: <20100701121711.GM2822@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Tony,

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, July 01, 2010 5:47 PM
> To: Datta, Shubhrajyoti
> Cc: linux-omap@vger.kernel.org; LM Sensors
> Subject: Re: [RFC] [PATCH] Board changes for tmp105 temperature sensor
> 
> * Datta, Shubhrajyoti <shubhrajyoti@ti.com> [100615 17:40]:
> > Adding board configuration for the tmp105
> > temperature sensor. The interface to the sensor
> > is I2C.
> >
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > ---
> >  arch/arm/mach-omap2/board-4430sdp.c |    8 +++++++-
> >  1 files changed, 7 insertions(+), 1 deletions(-)
> >  mode change 100644 => 100755 arch/arm/mach-omap2/board-4430sdp.c
> 
> Please be careful with the mode changes.
Will send a corrected patch
> 
> Tony

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
