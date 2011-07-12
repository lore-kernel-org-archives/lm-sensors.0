From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 12 Jul 2011 16:26:24 +0000
Subject: Re: [lm-sensors] [PATCH 15/15] hwmon: (pmbus) Add client driver for
Message-Id: <20110712162624.GB25347@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310485300-2168-16-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1310485300-2168-16-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 12, 2011 at 11:41:40AM -0400, Guenter Roeck wrote:
> PMBus client driver supporting National Semiconductor LM25066, LM5064, and LM5066.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/lm25066.c          |  340 ++++++++++++++++++++++++++++++++++++++

Move damage. Should have been drivers/hwmon/pmbus/lm25066.c.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
