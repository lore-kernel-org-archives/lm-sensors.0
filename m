From: Anton Vorontsov <cbouatmailru@gmail.com>
Date: Tue, 01 Mar 2011 22:58:03 +0000
Subject: Re: [lm-sensors] [PATCH] jz4740: silence warnings related to
Message-Id: <20110301225803.GA4881@oksana.dev.rtsoft.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110301133548.6acb5170@debxo>
In-Reply-To: <20110301133548.6acb5170@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andres Salomon <dilinger@queued.net>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Tue, Mar 01, 2011 at 01:35:48PM -0800, Andres Salomon wrote:
> 
> mfd_get_cell returns a const, so change the jz4740 clients to store
> a const mfd cell.  This silences type mismatch warnings.
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>
> ---
>  drivers/hwmon/jz4740-hwmon.c   |    2 +-
>  drivers/power/jz4740-battery.c |    2 +-

For the drivers/power/ part:

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
