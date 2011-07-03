From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 03 Jul 2011 16:23:31 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (pmbus) Drop check for PMBus
Message-Id: <20110703162331.GA15945@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1309454993-8641-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1309454993-8641-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Sun, Jul 03, 2011 at 03:46:05AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> Sorry for the (too) late review.
> 
> On Thu, 30 Jun 2011 10:29:50 -0700, Guenter Roeck wrote:
> > Some PMBus devices do not support the PMBus revision register, so don't check
> > if it exists.
> 
> This was the only use of PMBUS_REVISION. Should its definition be kept
> in pmbus.h?
> 
I'd like to keep it at least for now. Who knows what I may need it for.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
