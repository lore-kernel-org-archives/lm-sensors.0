From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 29 Apr 2011 08:32:23 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (lm85) Fix error paths in probe
Message-Id: <20110429083223.GC9151@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110429102508.07e31e59@endymion.delvare>
In-Reply-To: <20110429102508.07e31e59@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Apr 29, 2011 at 04:25:08AM -0400, Jean Delvare wrote:
> We must remove all files we created, even in error cases.
> 
> Fixes second part of kernel bug #34072:
> https://bugzilla.kernel.org/show_bug.cgi?id4072
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
