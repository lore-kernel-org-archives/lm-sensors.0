From: Samuel Ortiz <sameo@linux.intel.com>
Date: Tue, 04 Aug 2009 14:07:18 +0000
Subject: Re: [lm-sensors] [PATCH 0/22] WM831x drivers
Message-Id: <20090804140716.GD8601@sortiz.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090727134527.GA12849@rakim.wolfsonmicro.main> <20090804113528.GB8601@sortiz.org> <1249386249.4248.159.camel@vega.slimlogic.co.uk>
In-Reply-To: <1249386249.4248.159.camel@vega.slimlogic.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Richard Purdie <rpurdie@rpsys.net>, David Brownell <dbrownell@users.sourceforge.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Jean Delvare <khali@linux-fr.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, rtc-linux@googlegroups.com

Hi Liam

On Tue, Aug 04, 2009 at 12:44:09PM +0100, Liam Girdwood wrote:
> On Tue, 2009-08-04 at 13:35 +0200, Samuel Ortiz wrote:
> > Hi Mark,
> > 
> > On Mon, Jul 27, 2009 at 02:45:27PM +0100, Mark Brown wrote:
> > > The following patch series adds initial support for the WM813x series of
> > > PMICs.
> > > 
> > > Since these devices have functionality that crosses many subsystems the
> > > patches cross many kernel trees.  For clarity I'm presenting this
> > > initial submission as a single series but I have endeavoured to split
> > > things up so that the patches can be applied separately to the various
> > > subsystems.  In order to avoid merge issues as patches are applied the
> > > platform data for the devices is included in the core patches.
> > > 
> > > Due to Kconfig and Makefile collisons I've also included the patch adding
> > > hwmon support for the WM835x series of PMICs to the series.  Other than
> > > the build system updates there is no interdependence between those two
> > > patches.
> > I applied patches [1-8], the gpio one, the 2 hwmon ones and the input one.
> > I'll now wait for some more feedback for the remaining patches.
> > 
> 
> Regulator patches :-
> 
> Acked-by Liam Girdwood <lrg@slimlogic.co.uk>
Thanks Liam, I applied all 5 of them to my for-next branch

Cheers,
Samuel.


> Thanks
> 
> Liam
> 
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
