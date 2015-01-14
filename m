From: Lukasz Majewski <l.majewski@samsung.com>
Date: Wed, 14 Jan 2015 13:56:32 +0000
Subject: Re: [lm-sensors] [PATCH 2/9] hwmon: dts: Doc: Add DTS doc to explain how to use PWM FAN as a cooling
Message-Id: <20150114145632.3010f836@amdc2363>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1418897591-18332-3-git-send-email-l.majewski@samsung.com>
 <1418899337.23532.9.camel@collabora.co.uk> <20141219163224.34796e5d@amdc2363>
 <20141219160237.GA2199@roeck-us.net> <20141219171301.1527d81e@amdc2363>
 <1420455034.15910.53.camel@collabora.co.uk>
In-Reply-To: <1420455034.15910.53.camel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: Guenter Roeck <linux@roeck-us.net>, Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>

Hi Sjoerd,

> Hey Lukasz,
> 
> Blame the holiday season for my late reply ;)
> 
> On Fri, 2014-12-19 at 17:13 +0100, Lukasz Majewski wrote:
> > Hi Guenter,
> > 
> > > On Fri, Dec 19, 2014 at 04:32:24PM +0100, Lukasz Majewski wrote:
> > > > Hi Sjoerd,
> > > > 
> > > > Thanks for your feedback and sorry for a late reply.
> > > > 
> > > > > On Thu, 2014-12-18 at 11:13 +0100, Lukasz Majewski wrote:
> > > > > > Several new properties to allow PWM fan working as a cooling
> > > > > > device have been combined into this single commit.
> > > > > > 
> > > > > > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > > > > > ---
> > > > > >  .../devicetree/bindings/hwmon/pwm-fan.txt          | 28
> > > > > > ++++++++++++++++++++++ 1 file changed, 28 insertions(+)
> > > > > > 
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> > > > > > b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt index
> > > > > > 610757c..3877810 100644 ---
> > > > > > a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt +++
> > > > > > b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt @@
> > > > > > -3,10 +3,38 @@ Bindings for a fan connected to the PWM
> > > > > > lines Required properties:
> > > > > >  - compatible	: "pwm-fan"
> > > > > >  - pwms		: the PWM that is used to control the
> > > > > > PWM fan +- cooling-pwm-values      : PWM duty cycle values
> > > > > > relative to
> > > > > > +			    cooling-max-pwm-value
> > > > > > correspondig to
> > > > > > +			    proper cooling states
> > > > > > +- default-pulse-width     : Property specifying default
> > > > > > pulse width for FAN
> > > > > > +			    at system boot (zero to disable
> > > > > > FAN on boot).
> > > > > > +			    Allowed range is 0 to 255
> > > > > 
> > > > > The 0..255 range seems somewhat random. Would be nicer to
> > > > > either use the approach of pwm-backlight (iotw, have the
> > > > > range go from the first to the last entry of
> > > > > cooling-pwm-values) 
> > > > 
> > > > I'm OK to change the default-pulse-width to be similar to
> > > > "default-brightness-level" (as it is in
> > > > Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt)
> > > > 
> > > > > or simply have be the duty
> > > > > lenght in NS as entries instead of the current indirection.
> > > > 
> > > > I'd prefer to keep the indirection - as it is utilized in the
> > > > current pwm-fan.c driver.
> > > > 
> > > FWIW, devicetree information is supposed to be implementation
> > > independent. So this is a poor argument.
> > 
> > Many other pwm drivers use the indirection - e.g. mentioned
> > pwm-backlight.
> 
> I don't specifically mind the indirection, i was just thinking out
> loud whether it added value (but if it's quite common, might indeed
> be good to keep the pattern). What i do dislike is the number of
> levels is being set to an arbitrary levels, as that will very rarely
> match the actual number of distinct pwm levels you 
> 
> One thing though, when following the pattern of the pwm-backlight
> driver; In pwm-backlight the highest index of brightness-levels is
> always 100% duty cycle.. On e.g. XU3 the vendor kernel never drives
> the fan at 100% duty (maximum of 91%). So it would be nice if the dt
> bindigns could model that e.g. by having:
> 
> pwm-levels = <20>; // 21 distinct pwm levels
> valid-pwm-level = <5 15 18>; /* 5 15 and 18 are usable levels - pwm
> will default to highest level */
> 

Could you review v2 of this patch series?

http://www.spinics.net/lists/devicetree/msg63159.html

> 
> > > > Enabling pan to full RPM was the default behaviour in the
> > > > current pwm-fan.c file.
> > > > 
> > > > To be honest, there is no need to enable fan to full RPM speed
> > > > in this board for following reasons:
> > > > 1. In Odroid the FAN is optional (stacked on top of a heat
> > > > sink) - very often it is just enough to only have the heat sink.
> > > > 
> > > > 2. Odroid has thermal enabled by default and IMHO it would be
> > > > more feasible to allow thermal to control fan from the very
> > > > beginning.
> > > > 
> > > > However, I can also understand if the policy for hwmon implies a
> > > > rule to enable by default all fans to full RPM speed.
> > > > 
> > > Why and how does that all suggest that the current default
> > > behavior should be changed ?
> > 
> > I wanted to avoid the unpleasant sound for full speed fan when
> > thermal is not enabled by default.
> > 
> > But as I said, I fully understand the policy and I would be happy to
> > comply with it as thermal should reduce the fan speed anyway at boot
> > time.
> 
> Yeah, what happens on my XU3 is that u-boot sets the pwm to 100% duty
> and the thermal infrastructure turns it off as soon as it gets into
> control, which works quite nicely (and keeps my sanity as that fan at
> 100% is *loud*)...  So if you want to avoid unpleasant sounds, just
> build with thermal :p
> 
> 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
