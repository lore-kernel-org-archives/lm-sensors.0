From: akpm@osdl.org (Andrew Morton)
Date: Tue, 28 Mar 2006 00:51:20 +0000
Subject: [lm-sensors] [PATCH 2.6.16-mm1 3/3] rtc: add support for m41t81
Message-Id: <20060327165120.35376d11.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <440B4B6E.8080307@sh.cvut.cz>
	<zt2d4LqL.1141645514.2993990.khali@localhost>
	<20060307170107.GA5250@mag.az.mvista.com>
	<20060318001254.GA14079@mag.az.mvista.com>
	<20060323210856.f1bfd02b.khali@linux-fr.org>
	<20060323203843.GA18912@mag.az.mvista.com>
	<20060324012406.GE9560@mag.az.mvista.com>
	<20060326145840.5e578fa4.akpm@osdl.org>
	<20060328002625.GE21077@mag.az.mvista.com>
In-Reply-To: <20060328002625.GE21077@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: mgreer@mvista.com, lm-sensors@lm-sensors.org, r.marek@sh.cvut.cz, khali@linux-fr.org, linux-kernel@vger.kernel.org

"Mark A. Greer" <mgreer at mvista.com> wrote:
>
> Resend...
> ---
> 
>  drivers/i2c/chips/m41t00.c |  294 ++++++++++++++++++++++++++++++++++-----------
>  include/linux/m41t00.h     |   50 +++++++

Not sure what to make of this.  It has no changelog, it doesn't apply on
top of your previous three patches:

rtc-m41t00-driver-should-use-workqueue-instead-of-tasklet.patch
rtc-m41t00-driver-cleanup.patch
rtc-add-support-for-m41t81-m41t85-chips-to-m41t00-driver.patch

and it doesn't apply when used to replace
rtc-add-support-for-m41t81-m41t85-chips-to-m41t00-driver.patch.

An incremental patch against the three above patches would be ideal...

