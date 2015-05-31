From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 31 May 2015 20:30:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Document which I2C addresses can be probed
Message-Id: <20150531223048.149c1eb7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150529104302.1e8a0a11@endymion.delvare>
In-Reply-To: <20150529104302.1e8a0a11@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 29 May 2015 07:46:39 -0700, Guenter Roeck wrote:
> Hi Jean,
> 
> On 05/29/2015 01:43 AM, Jean Delvare wrote:
> > Add an item to the checklist when submitting a new hwmon driver: only
> > some I2C addresses can be probed, others should not for safety
> > reasons.
> >
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > ---
> >   Documentation/hwmon/submitting-patches |    7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > --- linux-4.1-rc5.orig/Documentation/hwmon/submitting-patches	2015-04-27 02:59:10.000000000 +0200
> > +++ linux-4.1-rc5/Documentation/hwmon/submitting-patches	2015-05-29 10:40:49.118900331 +0200
> > @@ -81,6 +81,13 @@ increase the chances of your change bein
> >
> >   * Provide a detect function if and only if a chip can be detected reliably.
> >
> > +* Only the following I2C addresses shall be probed: 0x18-0x1f, 0x28-0x2f,
> > +  0x48-0x4f, 0x58, 0x5c, 0x73 and 0x77. Probing other addresses is strongly
> > +  discouraged as it is known to cause trouble with other (non-hwmon) I2C
> > +  chips. If your chip can live at an address which can't be probed then the
> 
> lives ? After all, the chip can still be probed on its other addresses,
> like the tmp435.

Fixed, thanks for the review.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
