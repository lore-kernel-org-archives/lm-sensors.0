From: Andreas Werner <andreas.werner@men.de>
Date: Fri, 18 Dec 2015 08:18:05 +0000
Subject: Re: [lm-sensors] LM90 driver and ti tmp461 detection
Message-Id: <20151218081805.GC2349@awelinux>
List-Id: <lm-sensors.vger.kernel.org>
References: <20151210120856.GA27765@awelinux>
 <5669AB55.5030309@roeck-us.net>
 <20151210171231.GA28022@awelinux>
 <20151212110842.10e7693e@endymion.delvare>
 <20151215151123.GA2349@awelinux>
 <20151217124808.63f8f54f@endymion.delvare>
 <20151217145751.GA21030@roeck-us.net>
In-Reply-To: <20151217145751.GA21030@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.de>, Andreas Werner <andreas.werner@men.de>, wni@nvidia.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thu, Dec 17, 2015 at 06:57:51AM -0800, Guenter Roeck wrote:
> On Thu, Dec 17, 2015 at 12:48:08PM +0100, Jean Delvare wrote:
> > Hi Andreas,
> > 
> > On Tue, 15 Dec 2015 16:11:24 +0100, Andreas Werner wrote:
> > > here is the register dump of the tmp461.
> > 
> > Thanks.
> > 
> > > It seemse that we really cannot detect if it is a tmp461 or a tmp451.
> > > Also the magic "ID Register" offset 0xff is 0x00 for both devices.
> > 
> > I would use register 0x16, which doesn't exist but reads 0x00 on the
> > TMP451. It could in theory also read 0x00 on the TMP461 but only if
> > both channels are disabled, which makes little sense. More likely at
> > least one channel will be enabled so you'll have value 0x01-0x03 if
> > this is a TMP461.
> > 
> Excellent idea!
> 
> Guenter

Ok, i will implement the detection for the tm461 and also the temp calculation
for setting the temperature value.

Will send a patch as soon as i am done.

Regards
Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
