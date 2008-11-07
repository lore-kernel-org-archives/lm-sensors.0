From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 07 Nov 2008 19:20:40 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] adt7473: Check inputs from sysfs writes
Message-Id: <20081107112040.0154e093.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081107185621.13022.61885.stgit@elm3a70.beaverton.ibm.com>
	<20081107185641.13022.70557.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081107185641.13022.70557.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: djwong@us.ibm.com, khali@linux-fr.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri, 07 Nov 2008 10:56:41 -0800
"Darrick J. Wong" <djwong@us.ibm.com> wrote:

> +#define ROUND_DIV(x, divisor)	(((x) + ((divisor) / 2)) / (divisor))

It might make sense to rename this to ROUND_CLOSEST, fix the
double-evaluation and whap it into kernel.h?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
