From: Ashish Jangam <Ashish.Jangam@kpitcummins.com>
Date: Fri, 01 Jul 2011 11:39:55 +0000
Subject: Re: [lm-sensors] [PATCH 6/11] HWMON: DA9052 hwmon driver v2
Message-Id: <E2CAE7F7B064EA49B5CE7EE9A4BB167D152F0185F5@KCINPUNHJCMS01.kpit.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309439728.4656.0.camel@L-0532.kpit.com>
 <20110630142219.GA13161@ericsson.com>
In-Reply-To: <20110630142219.GA13161@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>, "dchen@diasemi.com" <dchen@diasemi.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>


> -----Original Message-----
> From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> Sent: Thursday, June 30, 2011 7:52 PM
> To: Ashish Jangam
> Cc: randy.dunlap@oracle.com; linaro-dev@lists.linaro.org; dchen@diasemi.com;
> linux-kernel@vger.kernel.org; lm-sensors@lm-sensors.org
> Subject: Re: [PATCH 6/11] HWMON: DA9052 hwmon driver v2
> 
> On Thu, Jun 30, 2011 at 09:15:27AM -0400, ashishj3 wrote:
> > The DA9052 PMIC provides an Analogue to Digital Converter with 10 bits
> > resolution and 10 channels.
> >
> > This patch montiors the DA9052 PMIC's ADC channels mostly for battery
> parameters
> > like battery temperature, junction temperature, battery current etc.
> >
> > Signed-off-by: David Dajun Chen <dchen@diasemi.com>
> > Signed-off-by: Ashish Jangam <ashish.jangam@kpitcummins.com>
> 
> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> 
> I assume this patch will be handled as part of a patchset, correct ?
Correct.
> 
> Thanks,
> Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
