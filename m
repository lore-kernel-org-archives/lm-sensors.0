From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Oct 2010 13:39:50 +0000
Subject: Re: [lm-sensors] Detection of W83L771W/G in lm90
Message-Id: <20101014153950.26e3df8f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101014114626.7c4be041@endymion.delvare>
In-Reply-To: <20101014114626.7c4be041@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 14 Oct 2010 06:20:39 -0700, Guenter Roeck wrote:
> On Thu, Oct 14, 2010 at 05:46:26AM -0400, Jean Delvare wrote:
> [ ... ]
> > +		if ((reg_config1 & 0x2A) = 0x00
> > +		 && (reg_config2 & 0xF8) = 0x00) {
> > +			if ((chip_id & 0xFE) = 0x10 /* W83L771AWG/ASG */
> > +			 && reg_convrate <= 0x08) {
> > +				name = "w83l771";
> > +			} else
> > +			if (chip_id = 0x01 /* W83L771W/G */
> > +			 && reg_convrate <= 0x09) {
> > +				name = "w83l771";
> > +			}
> 
> If the chips have a different maximum conversion rate, that should probably be reflected 
> in .max_convrate as well. Unless you want to ignore it on purpose for simplicity ...
> which is fine with me.

Yes, I want to ignore it on purpose for simplicity. One reason being
that I have a doubt that the old W83L771W/G actually supports a higher
refresh rate than the new W83L771AWG/ASG does. I don't necessarily
trust the datasheet, as it is inconsistent: it says the default
register value is 08h, then later it claims that the default conversion
rate is 16 Hz, but 16 Hz corresponds to a value of 09h in the table.
Additionally, you'll notice that the W83L771W/G conversion rate table
is shifted by 1 compared to all the other compatible chips - which is
quite suspicious.

So I assume that the table is wrong in the datasheet. Only if someone
with a W83L771W/G at hand tests it and comes to the conclusion that the
table in the datasheet is correct, will I update the driver accordingly.

Thanks for the review, BTW :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
