From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 27 Jun 2011 13:42:39 +0000
Subject: Re: [lm-sensors] coretemp: Support for Intel Atom E6XX CPU
Message-Id: <20110627134239.GA10808@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201106271220.51953.alexander.stein@systec-electronic.com>
In-Reply-To: <201106271220.51953.alexander.stein@systec-electronic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 27, 2011 at 06:20:51AM -0400, Alexander Stein wrote:
> Hello,
> 
> I have a patch (for v2.6.39) which adds support for Intel Atom E6XX 
> (TunnelCreek) to coretemp. It's merely only adding x86_model 0x26.
> But there are models (e.g. E660 and E660T) with different TjMax, namely 90 
> degrees C and 110 degrees C. But these different model can't be detected by 
> reading from hardware.
> IMO there should be some support to adjust the temperature from userspace. 
> Reading Documentation/hwmon/sysfs-interface only temp1_offset seems to be 
> useable. But I think it is somewhat misleading (especially on multicores), 
> because there must only be one offset.
> What do you think about this?
> 
You can adjust the reported temperature with an entry in sensors3.conf.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
