From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 May 2008 06:01:05 +0000
Subject: Re: [lm-sensors] [resend] [PATCH v2] ibmaem: New driver for
Message-Id: <20080507080105.5484c58a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080503045558.GJ16078@tree.beaverton.ibm.com>
	<20080505135621.66809b0e.akpm@linux-foundation.org>
	<20080505230440.GE16404@tree.beaverton.ibm.com>
	<20080506140433.0fa6e68e.akpm@linux-foundation.org>
	<20080506223812.GF16404@tree.beaverton.ibm.com>
	<20080506173607.71eb7257.akpm@linux-foundation.org>
In-Reply-To: <20080506173607.71eb7257.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: djwong@us.ibm.com, mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, 6 May 2008 17:36:07 -0700, Andrew Morton wrote:
> A checkpatch version which you might not have says
> 
> WARNING: consider using strict_strtol in preference to simple_strtol
> #1015: FILE: drivers/hwmon/ibmaem.c:918:
> +       int temp = simple_strtol(buf, NULL, 10); \
> 
> total: 0 errors, 1 warnings, 1221 lines checked
> 
> because the code as you have it will accept input of the form "12foo". 
> strict_strtol() will error on that.

As a side note, I really wonder why this new function wasn't named just
strtol(), especially if the general idea is to get rid of the "simple"
variant after some time.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
