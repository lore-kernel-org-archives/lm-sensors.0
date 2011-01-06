From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 06 Jan 2011 15:21:52 +0000
Subject: Re: [lm-sensors] [PATCH V4] hwmon: driver for Sensirion SHT21
Message-Id: <20110106152152.GB9053@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D1DF097.1080200@cam.ac.uk>
 <20110103081448.f96c413e.urs.fleisch@gmail.com>
 <4D21ADCB.4070206@cam.ac.uk>
 <1294078159.9786.9.camel@groeck-laptop>
 <4D230ED0.8060008@cam.ac.uk>
 <20110104152837.GA32138@ericsson.com>
 <20110104200001.3328dae3.urs.fleisch@gmail.com>
 <1294170132.9786.52.camel@groeck-laptop>
 <20110106084338.d31624e3.urs.fleisch@gmail.com>
 <4D25A04F.7070304@cam.ac.uk>
In-Reply-To: <4D25A04F.7070304@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Urs Fleisch <urs.fleisch@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>

On Thu, Jan 06, 2011 at 05:58:23AM -0500, Jonathan Cameron wrote:
> On 01/06/11 07:43, Urs Fleisch wrote:
> > Thanks for the review, Jonathan and Guenter.
> > 
> > Changes:
> > - removed user register related sysfs attributes, keeping only temp1_input and
> >   humidity1_input
> > - cleaned up code flow when returning errors for better readability
> Short and clean. I do wonder if you want some of those users register
> bits available via platform data though.  Perhaps that can be added in
> a later patch as and when someone needs them.

Only thing missing is Documentation/hwmon/sht21.

Urs, can you add that ? 

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
