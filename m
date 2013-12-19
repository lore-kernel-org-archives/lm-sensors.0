From: "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>
Date: Thu, 19 Dec 2013 18:15:57 +0000
Subject: Re: [lm-sensors] [PATCH V1] fix adc to voltage calculation in da9052 power driver
Message-Id: <24DF37198A1E704D9811D8F72B87EB51847AC44F@NB-EX-MBX02.diasemi.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201312181524.rBIFOv96017094@swsrvapps-02.lan>
 <20131218163234.714a166c@endymion.delvare>
 <24DF37198A1E704D9811D8F72B87EB51847ABF61@NB-EX-MBX02.diasemi.com>
 <20131218172402.GA18892@roeck-us.net>
 <24DF37198A1E704D9811D8F72B87EB51847AC2C3@NB-EX-MBX02.diasemi.com>
 <20131219155454.40100f4d@endymion.delvare>
 <20131219181049.GA6854@roeck-us.net>
In-Reply-To: <20131219181049.GA6854@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>
Cc: "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Anton Vorontsov <anton@enomsg.org>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>

> -----Original Message-----
> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter
> Roeck
> Sent: 19 December 2013 18:11
> To: Jean Delvare
> Cc: Opensource [Anthony Olech]; lm-sensors@lm-sensors.org; Anton
> Vorontsov; David Woodhouse; linux-kernel@vger.kernel.org; David Dajun
> Chen
> Subject: Re: [lm-sensors] [PATCH V1] fix adc to voltage calculation in da9052
> power driver
> On Thu, Dec 19, 2013 at 03:54:54PM +0100, Jean Delvare wrote:
> > Hi Anthony,
> >
> [ ... ]
> > BTW, you (and we) probably shouldn't waste too much energy on this.
> > ADCs are only accurate to some degree anyway. If you take the
> > components connected to the input into consideration, the accuracy
> > gets even worse. For example, if the input voltage must be scaled down
> > to fit in the ADC's range, you need at least one resistor, which in
> > best cases will have a 1% accurate value (known as tolerance.) That's
> > ten times the LSB of your 10-bit ADC, at which point / 1023 or / 1024
> > really makes no practical difference. Sub-percent tolerant resistors
> > are expensive and rare in consumer electronics in my experience.
> True, but on the other side (and after looking into the datasheet) the driver
> already calculated the voltage on adc4..6 correctly, so unless you disagree I
> would like to apply the hwmon patch to -next for consistency.
> Thanks,
> Guenter

OK, thanks,
Tony Olech

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
