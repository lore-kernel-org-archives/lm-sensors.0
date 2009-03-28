From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 28 Mar 2009 08:07:48 +0000
Subject: Re: [lm-sensors] Intel DG45FC
Message-Id: <20090328090748.78fe7d86@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
In-Reply-To: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Tony,

On Fri, 27 Mar 2009 11:14:16 -0700, Tony Bones wrote:
> On Fri, Feb 20, 2009 at 2:11 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > Can you please look at your board (physically) and search for the
> > Super-I/O chip? This should be one of:
> >
> > PC8374L
> > WPCD374L
> > WPCD376I
> > WPCD377I
> >
> > I would like to know which one you have.
> 
> Sorry for the long delay, its the WPCD376I  (which apparently is based on
> the WPCD374L but without the legacy components).  So maybe they are similar
> in how you interface with them.
> 
> See here:
> http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/ComputerIC/SuperIO/AdvancedSuperIOforDesktop/WPCD376I.htm

OK, thanks for the information. This confirms my guess that devices
without the hardware monitoring block have revision ID 0x91. Please
give a try to the latest version of sensors-detect:
http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect

It should detect a WPCD376I/377I and tell you it doesn't have hardware
monitoring features.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
