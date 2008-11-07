From: Randy Dunlap <randy.dunlap@oracle.com>
Date: Fri, 07 Nov 2008 21:02:37 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] adt7473: Check inputs from sysfs writes
Message-Id: <4914ACED.8070207@oracle.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081107185621.13022.61885.stgit@elm3a70.beaverton.ibm.com>	<20081107185641.13022.70557.stgit@elm3a70.beaverton.ibm.com>	<20081107112040.0154e093.akpm@linux-foundation.org>	<1226090974.10478.15.camel@localhost> <20081107220019.74c60aa4@hyperion.delvare>
In-Reply-To: <20081107220019.74c60aa4@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Jean Delvare wrote:
> On Fri, 07 Nov 2008 12:49:34 -0800, Joe Perches wrote:
>> On Fri, 2008-11-07 at 11:20 -0800, Andrew Morton wrote:
>>>> +#define ROUND_DIV(x, divisor)	(((x) + ((divisor) / 2)) / (divisor))
>>> It might make sense to rename this to ROUND_CLOSEST, fix the
>>> double-evaluation and whap it into kernel.h?
>> ROUND_HALF_UP?
> 
> What would that supposedly mean?

Just go with DIV_ROUND_CLOSEST() or DIV_ROUND().
The _CLOSEST() is redundant to ROUND .. IMO.

-- 
~Randy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
