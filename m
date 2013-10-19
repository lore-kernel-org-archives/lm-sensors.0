From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 19 Oct 2013 16:06:09 +0000
Subject: Re: [lm-sensors] [patch] hwmon: (w83793) Clean up a signedness issue
Message-Id: <5262ADF1.5010106@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20131019091222.GF9312@longonot.mountain>
In-Reply-To: <20131019091222.GF9312@longonot.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On 10/19/2013 02:12 AM, Dan Carpenter wrote:
> We cap the upper bound of "mtimeout" but since it's signed we should
> check for negative values as well.  The mistake is harmless.  But I have
> changed it to unsigned as a cleanup.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
