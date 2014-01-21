From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Tue, 21 Jan 2014 22:32:25 +0000
Subject: Re: [lm-sensors] [PATCH 50/73] drivers/hwmon: delete non-required instances of include <linux/init.h
Message-Id: <52DEF579.6080401@windriver.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com> <1390339396-3479-51-git-send-email-paul.gortmaker@windriver.com> <20140121213719.GA11888@roeck-us.net>
In-Reply-To: <20140121213719.GA11888@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org

On 14-01-21 04:37 PM, Guenter Roeck wrote:
> On Tue, Jan 21, 2014 at 04:22:53PM -0500, Paul Gortmaker wrote:
>> None of these files are actually using any __init type directives
>> and hence don't need to include <linux/init.h>.  Most are just a
>> left over from __devinit and __cpuinit removal, or simply due to
>> code getting copied from one driver to the next.
>>
>> Cc: Jean Delvare <khali@linux-fr.org>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: lm-sensors@lm-sensors.org
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> Hi Paul,
> 
> nice cleanup. I applied it to my local repository to run
> a set of build tests with it.

Great -- sounds good, extra testing is always appreciated.

> 
> Assuming the plan is to push the changes through your tree:
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Yep, that is the general plan; thanks for the ack --added.

P.
--

> 
> Guenter
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
