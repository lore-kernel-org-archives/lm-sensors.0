From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 24 Feb 2015 18:28:24 +0000
Subject: Re: [lm-sensors] Asrock Q87 / Nuvoton NCT6681D support
Message-Id: <20150224182824.GB14180@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <54ECBAC7.6060206@ichec.ie>
In-Reply-To: <54ECBAC7.6060206@ichec.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Feb 24, 2015 at 05:54:15PM +0000, Servesh Muralidharan wrote:
> Hi,
> 
> I recently got an Asrock Q87M motherboard for a home server. On running
> lm-sensors for hardware monitoring I found that it detected nuvoton nct6681D
> as the chip but the driver was not present. Searching through the mailing
> list showed that the device can be identified and the support for this chip
> could be added to nct6683 driver. Has there been any progress on this? I
> should be able to test / help with development for the driver.
> 
No, due to lack of testing capability and to some degree time.

If you have the time, I would suggest cloning the stand-alone driver 
from github (https://github.com/groeck/nct6683) and add support for
NCT6681D to it. We can then go from there to get the code upstream.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
