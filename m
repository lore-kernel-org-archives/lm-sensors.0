From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 18 Jul 2013 21:26:32 +0000
Subject: Re: [lm-sensors] [patch v2] hwmon: (nct6775) make an array larger
Message-Id: <20130718212632.GD4110@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130718150111.GA11991@elgon.mountain>
In-Reply-To: <20130718150111.GA11991@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On Thu, Jul 18, 2013 at 06:01:11PM +0300, Dan Carpenter wrote:
> Smatch complains that we have a array overflow:
> 
> 	drivers/hwmon/nct6775.c:1456 nct6775_update_device()
> 		error: buffer overflow 'data->temp' 4 <= 4
> 
> Guenter Roeck says that the array should have been made larger in
> 7cbbd6aee6 (Add support for critical low/high temperature limits on
> NCT6106).  This patch does that.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied. Thanks a lot for the patch.

I really need to enable smatch on my nightly builds :(

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
