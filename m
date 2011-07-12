From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 12 Jul 2011 16:40:33 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max1111) Avoid extra memory
Message-Id: <20110712164033.GC25347@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110712110152.4eead147@endymion.delvare>
In-Reply-To: <20110712110152.4eead147@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 12, 2011 at 05:01:52AM -0400, Jean Delvare wrote:
> We can allocate the tx and rx buffers as part of our data structure.
> Doing so is faster and spares memory.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Can anyone with a MAX1111 device try and report please?
> 
Reason for using allocated buffers may have been to ensure (word/cache line) alignment.
Not really sure if that is a valid argument with 1/2 byte buffers, though.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
