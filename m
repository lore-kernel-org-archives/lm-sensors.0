From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 16 Apr 2012 15:01:27 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: fam15h_power: fix bogus values with current BIOSes
Message-Id: <1334588487.25394.93.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1334009794-26653-1-git-send-email-andre.przywara@amd.com>
In-Reply-To: <1334009794-26653-1-git-send-email-andre.przywara@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-04-11 at 00:37 -0400, Guenter Roeck wrote:
> On Mon, Apr 09, 2012 at 06:16:34PM -0400, Andre Przywara wrote:
> > Newer BKDG[1] versions recommend a different initialization value for
> > the running average range register in the northbridge. This improves
> > the power reading by avoiding counter saturations resulting in bogus
> > values for anything below about 80% of TDP power consumption.
> > Updated BIOSes will have this new value set up from the beginning,
> > but meanwhile we correct this value ourselves.
> > This needs to be done on all northbridges, even on those where the
> > driver itself does not register at.
> > 
> > This fixes the driver on all current machines to provide proper
> > values for idle load.
> > 
> > Changes to v1:
> > - marking the function as __devinit
> > - marking the devices list as const
> > - fixing formatting of 4-bit hexadecimal numbers
> > - dumping the function's return value as it is not used
> > 
> > [1]
> > http://support.amd.com/us/Processor_TechDocs/42301_15h_Mod_00h-0Fh_BKDG.pdf
> > Chapter 3.8: D18F5xE0 Processor TDP Running Average (p. 452)
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@amd.com>
> 
> Minor comment below, otherwise
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> Jean, do you want to take it, or should I ?
> 
ping ... unless I hear otherwise, I'll add this patch to my list of
patches for the next -rc candidate.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
