From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 30 Jun 2010 17:27:46 +0000
Subject: Re: [lm-sensors] Nuvoton W83667HG-B support request
Message-Id: <20100630172746.GA5662@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <295942.63235.qm@web120612.mail.ne1.yahoo.com>
In-Reply-To: <295942.63235.qm@web120612.mail.ne1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I don't have a datasheet, but from looking into the "Open Hardware Monitor" source
it seems that W83667HG and W83667HG-B are identical from a programming perspective.
Only difference is the chip ID, which should be 0xb350 instead of 0xa510.

So you should be able to use the existing driver by setting the force_id module parameter
to 0xa510. If that works, and there are no objections, I can create a patch to auto-detect
the chip.

Guenter

On Wed, Jun 30, 2010 at 10:19:29AM -0400, Ethan Lawrence wrote:
> Hello,
> It seems my new motherbord has 'Nuvoton W83667HG-B Super IO Sensors' chip which is not supported yet.
> Device wiki says that there is a driver (w83627ehf) for W83667HG<http://www.nuvoton.com.tw/hq/enu/ProductAndSales/ProductLines/ComputerIC/SuperIO/LPCSuperIOforDesktopAndServer/W83667HG.htm> chip and support for W83667HG-B will probably be added to it.
> 
> Could you please add support for the new chip?
> 
> Previous support requests for this chip:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2009-November/027193.html
> http://lists.lm-sensors.org/pipermail/lm-sensors/2010-February/027842.html
> http://lists.lm-sensors.org/pipermail/lm-sensors/2010-May/028545.html
> http://lists.lm-sensors.org/pipermail/lm-sensors/2010-June/028710.html
> 
> 
> Thanks!
> ---
> Ethan
> 

> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
