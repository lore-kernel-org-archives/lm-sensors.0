From: Pavel Machek <pavel@ucw.cz>
Date: Tue, 30 Dec 2014 18:00:02 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: Driver for OMAP3 temperature sensor
Message-Id: <20141230180002.GC23142@amd>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141226102933.GA28778@amd>
 <1419597294-21487-1-git-send-email-sre@kernel.org>
 <1419597294-21487-3-git-send-email-sre@kernel.org>
 <CANOLnON6rAQ2+jJEFDKseH2Htu6bqRkURDioGt7zp1Ze73f8Pw@mail.gmail.com>
 <CAGo_u6qO0ok+GBnm7SQtw6dJuwGN2OuP7CpKDEWawS3V2go4KA@mail.gmail.com>
 <20141229181556.GA26926@amd>
 <54A1BB2B.9060204@ti.com>
In-Reply-To: <54A1BB2B.9060204@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nishanth Menon <nm@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, dt list <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Kumar Gala <galak@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.de>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Pali Rohar <pali.rohar@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon 2014-12-29 14:35:55, Nishanth Menon wrote:
> On 12/29/2014 12:15 PM, Pavel Machek wrote:
> > On Mon 2014-12-29 12:01:03, Nishanth Menon wrote:
> >> On Mon, Dec 29, 2014 at 11:52 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> >>> On Fri, Dec 26, 2014 at 2:34 PM, Sebastian Reichel <sre@kernel.org> wrote:
> >>>> OMAP34xx and OMAP36xx processors contain a register in the syscon area,
> >>>> which can be used to determine the SoCs temperature. This patch provides
> >>>> a DT based driver for the temperature sensor based on an older driver
> >>>> written by Peter De Schrijver for the Nokia N900 and N9.
> >>>
> >>> The sensor looks like an earlier iteration of sensors used in newer
> >>> OMAPs, which are already supported by maybe
> >>> drivers/thermal/ti-soc-thermal/ , maybe it would make sense to update
> >>> that driver instead?
> >>
> >> Just to be clear - OMAP4 is the first time that the sensors were
> >> reliable enough to be used.
> > 
> > When testing initial version of the patch, they seem to work very well
> > in the omap3 case.
> 
> Just be careful when you try to make thermal policy like decisions
> based on this sensor. Placement of the sensor w.r.t the actual logic

I guess we won't do that, certainly not anytime soon.

> Also notice http://www.ti.com/lit/er/sprz278f/sprz278f.pdf "Advisory
> 3.1.1.186 MMC OCP Clock Not Gated When Thermal Sensor Is Used" I think
> there were accuracy issues at certain values etc.. So remember to do a
> off mode type PM tests as well before you consider requesting these to
> be merged.

Thanks a lot for a pointer. 3x 100uA power draw when you enable
temperature sensor, because it also errorneously enables MMC. I wonder
how the solution would look in the device tree...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
