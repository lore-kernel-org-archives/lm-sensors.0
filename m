From: Joe Perches <joe@perches.com>
Date: Fri, 07 Nov 2008 20:49:34 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] adt7473: Check inputs from sysfs writes
Message-Id: <1226090974.10478.15.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081107185621.13022.61885.stgit@elm3a70.beaverton.ibm.com>
	 <20081107185641.13022.70557.stgit@elm3a70.beaverton.ibm.com>
	 <20081107112040.0154e093.akpm@linux-foundation.org>
In-Reply-To: <20081107112040.0154e093.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, khali@linux-fr.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri, 2008-11-07 at 11:20 -0800, Andrew Morton wrote:
> > +#define ROUND_DIV(x, divisor)	(((x) + ((divisor) / 2)) / (divisor))
> It might make sense to rename this to ROUND_CLOSEST, fix the
> double-evaluation and whap it into kernel.h?

ROUND_HALF_UP?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
