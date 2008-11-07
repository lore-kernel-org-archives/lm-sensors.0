From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Fri, 07 Nov 2008 19:38:31 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] adt7462: New hwmon driver
Message-Id: <20081107193831.GB8800@plum>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081107185621.13022.61885.stgit@elm3a70.beaverton.ibm.com> <20081107185626.13022.59407.stgit@elm3a70.beaverton.ibm.com> <1226084691.11596.42.camel@brick>
In-Reply-To: <1226084691.11596.42.camel@brick>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Fri, Nov 07, 2008 at 11:04:51AM -0800, Harvey Harrison wrote:
> > +#define ROUND_DIV(x, divisor)  (((x) + ((divisor) / 2)) / (divisor))
> 
> DIV_ROUND_UP ?

Actually, on closer inspection, DIV_ROUND_UP always rounds up, so I'll
implement a ROUND_CLOSEST.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
