From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 17 Dec 2015 11:48:08 +0000
Subject: Re: [lm-sensors] LM90 driver and ti tmp461 detection
Message-Id: <20151217124808.63f8f54f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20151210120856.GA27765@awelinux>
	<5669AB55.5030309@roeck-us.net>
	<20151210171231.GA28022@awelinux>
	<20151212110842.10e7693e@endymion.delvare>
	<20151215151123.GA2349@awelinux>
In-Reply-To: <20151215151123.GA2349@awelinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Werner <andreas.werner@men.de>
Cc: Guenter Roeck <linux@roeck-us.net>, wni@nvidia.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Hi Andreas,

On Tue, 15 Dec 2015 16:11:24 +0100, Andreas Werner wrote:
> here is the register dump of the tmp461.

Thanks.

> It seemse that we really cannot detect if it is a tmp461 or a tmp451.
> Also the magic "ID Register" offset 0xff is 0x00 for both devices.

I would use register 0x16, which doesn't exist but reads 0x00 on the
TMP451. It could in theory also read 0x00 on the TMP461 but only if
both channels are disabled, which makes little sense. More likely at
least one channel will be enabled so you'll have value 0x01-0x03 if
this is a TMP461.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
