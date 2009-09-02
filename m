From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 02 Sep 2009 23:55:02 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for Texas Instruments
Message-Id: <20090902165502.b6710792.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090831_202450_066558.tomaz.mertelj@guest.arnes.si>
In-Reply-To: <20090831_202450_066558.tomaz.mertelj@guest.arnes.si>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomaz.mertelj@guest.arnes.si
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, 31 Aug 2009 22:24:50 +0200
tomaz.mertelj@guest.arnes.si wrote:

> I have crafted a hwmon driver for Texas Instruments amc6821 SMB-bus 2-
> channel temperature sensor, pwm controller. This is my first linux project 
> so some corrections will be necessary.
> 

The driver looks saneish to me, but...

- The attachment uses \r\n line termination and caused me quite a bit
  of trouble before I worked out what was going on.

- The changelog is missing your Signed-off-by:.  Please read up on
  this in Documentation/SubmittingPatches.

- The driver needs lots and lots of trivial coding-style fixes. 
  Please take a look at some similar drivers and also use the
  scripts/checkpatch.pl tool.

  checkpatch says:

	total: 153 errors, 110 warnings, 874 lines checked

  which must be some sort of record ;)

  Also, some C functions have needless `\' line continuations in them.


All pretty simple stuff.  Please take a look at all that and then resend?

Thanks.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
