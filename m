From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 07 May 2008 00:36:07 +0000
Subject: Re: [lm-sensors] [resend] [PATCH v2] ibmaem: New driver for
Message-Id: <20080506173607.71eb7257.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080503045558.GJ16078@tree.beaverton.ibm.com>
	<20080505135621.66809b0e.akpm@linux-foundation.org>
	<20080505230440.GE16404@tree.beaverton.ibm.com>
	<20080506140433.0fa6e68e.akpm@linux-foundation.org>
	<20080506223812.GF16404@tree.beaverton.ibm.com>
In-Reply-To: <20080506223812.GF16404@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: djwong@us.ibm.com
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, mhoffman@lightlink.com

On Tue, 6 May 2008 15:38:13 -0700 "Darrick J. Wong" <djwong@us.ibm.com> wrote:

> [resend due to truncation]
> Refactor the registration function to shrink the macros.  Let me know if
> more aggressive de-macroing is desirable.
> ---
> New driver for power meters in IBM System X hardware, with a few
> cleanups suggested by Anthony Liguori.
> 
> ...
>
> +	int temp = simple_strtol(buf, NULL, 10); \

A checkpatch version which you might not have says

WARNING: consider using strict_strtol in preference to simple_strtol
#1015: FILE: drivers/hwmon/ibmaem.c:918:
+       int temp = simple_strtol(buf, NULL, 10); \

total: 0 errors, 1 warnings, 1221 lines checked

because the code as you have it will accept input of the form "12foo". 
strict_strtol() will error on that.

afacit the calling code would perhaps need a little changing to handle
such errors appropriately.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
