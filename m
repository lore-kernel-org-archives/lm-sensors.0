From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 30 May 2012 15:38:16 +0000
Subject: Re: [lm-sensors] ITE IT8771E Driver
Message-Id: <20120530153816.GB15570@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKJpqGGwhwUDsbr1MThzcvMyfU4rQh_8_ZFU0-YwdXZcsfGz_Q@mail.gmail.com>
In-Reply-To: <CAKJpqGGwhwUDsbr1MThzcvMyfU4rQh_8_ZFU0-YwdXZcsfGz_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 30, 2012 at 09:04:45AM -0400, clement clem wrote:
> Hello,
> 
> 
> I have a mini ITX motherboard Asus P8H61-i.
> 
> This card has a chip ITE IT8771E, the temperature just work with the latest 
> Kernel 3.4 of Ubuntu 12.04.
> 
> I download the driver here for IT87xx  here
> 
> Extracted file, which folder it installs your driver?
> 
Not sure if I understand your question. You should be able to use the standard driver.
Load it with "modprobe it87 force_id=0x8721". This _should_ work from experience gathered
so far, but since we don't have a datasheet, and the vendor is not willing to provide one,
we can not be sure.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
