From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 10 Apr 2013 15:15:39 +0000
Subject: Re: [lm-sensors] request for TMP432
Message-Id: <20130410151539.GB6670@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <06BD56040955684AB7DB9D4C50FFEB7E119117@DNCE04.ent.ti.com>
In-Reply-To: <06BD56040955684AB7DB9D4C50FFEB7E119117@DNCE04.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 10, 2013 at 03:04:47PM +0000, BICHON, Quentin wrote:
> Hi,
> 
> I am working for TI and I would be interested in a driver solution for the TMP432.
> 
> I think we can help if needed providing samples for instance.
> 
> Thank you,
> Best,
> Quentin
> 
Hi Quentin,

TI provided samples, so we are fine there.

I already submitted a patch series[1], adding support for TMP432 to the
tmp401 driver. I am waiting for review feedback right now, which is
the more challenging part nowadays.

Thanks,
Guenter

[1] http://thread.gmane.org/gmane.linux.drivers.sensors/32191

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
