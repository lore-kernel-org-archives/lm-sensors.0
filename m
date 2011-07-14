From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Jul 2011 16:33:24 +0000
Subject: Re: [lm-sensors] DH55HC board temperature
Message-Id: <20110714163324.GB7109@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALgae9bzbyr3vH=x_bPK-aEnz=tMu-euE-V1=+qWUYic4ug=xA@mail.gmail.com>
In-Reply-To: <CALgae9bzbyr3vH=x_bPK-aEnz=tMu-euE-V1=+qWUYic4ug=xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jul 14, 2011 at 07:26:33AM -0400, Kelly Goedert wrote:
> Hi,
> 
> I just started using lm-sensors to monitor my servers and it works great. But I
> have a DH55HC intel board that I cant get lm-sensors to work with. Is it
> possible to monitor temperature and fan speed on this board?
> 
What is your kernel version, and what is the output from sensors-detect ?

The board might use NCT6775F, and your kernel version might be too old for it.
The chip is now supported by the w83627ehf driver. You can get a standalone version
from http://roeck-us.net/linux/drivers/. That will not help you for fan speeds,
though - the technical documentation indicates that the board uses the PCH
for fan control, and there is currently no Linux driver available for that.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
