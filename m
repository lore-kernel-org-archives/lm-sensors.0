From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 04 Mar 2011 19:59:57 +0000
Subject: Re: [lm-sensors] [PATCH v5 00/11] hwmon: (w83627ehf) Add support
Message-Id: <1299268797.18605.71.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299261486-15190-1-git-send-email-guenter.roeck@ericsson.com>
	 <AANLkTinNrOG69Kzy=ZfRjurOedsz2Oazt-FT-m3Ro6Gg@mail.gmail.com>
In-Reply-To: <AANLkTinNrOG69Kzy=ZfRjurOedsz2Oazt-FT-m3Ro6Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Lutomirski <luto@mit.edu>
Cc: Jean Delvare <khali@linux-fr.org>, Ian Dobson <i.dobson@planet-ian.com>, Randy Dunlap <rdunlap@xenotime.net>, "binximeng@gmail.com" <binximeng@gmail.com>, "lmsensors@tapanitarvainen.fi" <lmsensors@tapanitarvainen.fi>, "andrea.rizzolo@gmail.com" <andrea.rizzolo@gmail.com>, "jeff.sadowski@gmail.com" <jeff.sadowski@gmail.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 2011-03-04 at 13:50 -0500, Andrew Lutomirski wrote:
> On Fri, Mar 4, 2011 at 12:57 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > The following patch series adds support for NCT6775F and NCT6776F to the
> > w83627ehf driver. It also includes some cleanup and adds support for
> > the fourth temperature sensor on W83677HG-B.
> >
> > No code changes since v4. Resubmitting and widening audience in the hope that
> > someone may find the time to review the changes prior to the next commit window.
> 
> I'm not sure my review is worth much, but the driver seems to work.  I've tested
> fan speed measurement, changing pwm2_enable to 1, changing the fan speed,
> and changing back to 5.  Everything looks good.
> 
> The only weird thing I noticed is that, the first time I ran sensors, I got:
> fan2:                    0 RPM  (min =    0 RPM, div = 64)
> and thereafter I get
> fan2:                  136 RPM  (min =    0 RPM, div = 64)  ALARM
> 
> I suspect (although I haven't checked) that sensors is just reading
> div after it's already changed to 64.
> 
The driver reads rpm, finds it to be zero, and increases div as result
(NCT6775F may report zero rpm if div is too low). That explains the
first reading.

What I don't understand is the alarm you get with the 2nd reading. Any
idea where this might come from ? Is it sticky, or do you see it only
once ?

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
