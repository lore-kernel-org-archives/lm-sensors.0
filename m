From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 08 Apr 2014 15:08:19 +0000
Subject: Re: [lm-sensors] Ina219 with linux kernel driver
Message-Id: <20140408150819.GA13400@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAK=2HV2_fnfPcK41i2fnAsgR7BMruKq1XB846Tt87wgmBP=NXA@mail.gmail.com>
In-Reply-To: <CAK=2HV2_fnfPcK41i2fnAsgR7BMruKq1XB846Tt87wgmBP=NXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 08, 2014 at 04:13:00PM +0200, Pierre Kancir wrote:
> Hi,
> 
> I am using beaglebone black default kernel, here is its informations :
> Linux arm 3.8.13-bone40 #1 SMP Fri Jan 31 10:36:05 UTC 2014 armv7l
> DISTRIB_ID=Ubuntu
> DISTRIB_RELEASE.10
> DISTRIB_CODENAME=saucy
> DISTRIB_DESCRIPTION="Ubuntu 13.10"
> 
Devicetree support was only added to the ina2xx driver with
kernel version 3.11. You would have to back-port commit 31e7ad7
into your kernel to get it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
