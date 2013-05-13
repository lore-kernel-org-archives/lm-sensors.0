From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 13 May 2013 13:44:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (iio_hwmon) Fix null pointer dereference
Message-Id: <20130513134405.GB31002@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1368452246.10208.0.camel@phoenix>
In-Reply-To: <1368452246.10208.0.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, May 13, 2013 at 09:37:26PM +0800, Axel Lin wrote:
> This patch fixes the null pointer dereference in goto error_release_channels
> path when allocate memory for st fails.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

That was quick.

Applied, thanks.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
