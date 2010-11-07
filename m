From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 07 Nov 2010 17:37:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm95241) Check validity of input
Message-Id: <20101107173742.GH18730@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101105165629.112e6df5@endymion.delvare>
In-Reply-To: <20101105165629.112e6df5@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Nov 07, 2010 at 04:11:52AM -0500, Davide Rizzo wrote:
[ ... ]

> I already rewrote drivers/hwmon/lm95241.c without macro-generated functions, I posted it to the list a long time ago but nobody cared it.
> Here it is again (including your corrections).
> Signed-off-by: Davide Rizzo <elpa.rizzo@gmail.com<mailto:elpa.rizzo@gmail.com>>
> ------------------------------------------------
> 
Would be great if you could provide a patch on top of Jean's version.
There were other changes in the driver since the initial version which are
undone by the complete file, plus it has some unnecessary formatting changes
and whitespace errors.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
