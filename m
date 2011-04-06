From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Apr 2011 08:15:38 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] [hwmon] nct1008: Initial NCT1008 driver
Message-Id: <20110406101538.47990365@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302059183-29631-1-git-send-email-achew@nvidia.com>
	<20110406092358.07e8ca78@endymion.delvare>
	<20110406073222.GD23562@ericsson.com>
In-Reply-To: <20110406073222.GD23562@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "achew@nvidia.com" <achew@nvidia.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "w30289@motorola.com" <w30289@motorola.com>, "toddpoynor@google.com" <toddpoynor@google.com>, "wni@nvidia.com" <wni@nvidia.com>, "olofj@chromium.org" <olofj@chromium.org>

On Wed, 6 Apr 2011 00:32:22 -0700, Guenter Roeck wrote:
> Hi Jean,
> 
> On Wed, Apr 06, 2011 at 03:23:58AM -0400, Jean Delvare wrote:
> > Hi Andrew,
> > 
> [ ... ]
> > > +
> > > +/* Register Addresses */
> > > +#define LOCAL_TEMP_RD			0x00
> > > +#define EXT_HI_TEMP_RD			0x01
> > > +#define EXT_LO_TEMP_RD			0x10
> > > +#define STATUS_RD			0x02
> > > +#define CONFIG_RD			0x03
> > > +
> > > +#define CONFIG_WR			0x09
> > > +#define CONV_RATE_WR			0x0A
> > > +#define LOCAL_TEMP_HI_LIMIT_WR		0x0B
> > > +#define EXT_TEMP_HI_LIMIT_HI_BYTE	0x0D
> > > +#define OFFSET_WR			0x11
> > > +#define EXT_THERM_LIMIT_WR		0x19
> > > +#define LOCAL_THERM_LIMIT_WR		0x20
> > > +#define THERM_HYSTERESIS_WR		0x21
> > 
> > These register definitions look very familiar to me. Have you looked at
> > the lm90 driver to check has difficult it would be to add support for
> > the NCT1008? I bet it will only take a few lines of code.
> > 
> After I spent a couple of hours reviewing the driver, I noticed that the chip is functionally
> identical to ADT7461A (the only difference is the package; even the chip ID is the same),
> and the ADT7461A is in turn functionally identical to ADT7461. Sigh :(.

Yeah, this happens to me from times to times as well... I can't find of
a way to avoid such cases in the future unfortunately. Except that in
this specific case, the contributor should have noticed right away,
given that the compatibility if mentioned black on white in the
datasheet:

  "The NCT1008 is a dual−channel digital thermometer and
undertemperature/overtemperature alarm, intended for use in PCs and
thermal management systems. It is register−compatible with the
ADM1032 and ADT7461."

The good at least is that On Semi documented compatibility properly,
kudos to them.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
