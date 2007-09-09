From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 09 Sep 2007 08:42:20 +0000
Subject: Re: [lm-sensors] Missing thmc50 support in sensors
Message-Id: <20070909104220.90d1dd39.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070906130600.028cf7f5@hyperion.delvare>
In-Reply-To: <20070906130600.028cf7f5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 6 Sep 2007 13:06:00 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Hi Krzysztof,
> 
> In ticket #2250, someone using your new thmc50 driver is complaining
> about the lack of pretty-print support in "sensors":
> 
> http://www.lm-sensors.org/ticket/2250#comment:2
>
The current lmsensors2 displays all information it can get
from 2.6 driver. The only problem is the lmsensors2 cannot
get information about non-existing entries.

How can I hide entries (like die_code) which do not exist
in the 2.6 driver?

Regards,
Krzysztof

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
