From: Ankit Chaturvedi <ankit.chaturvedi@gmail.com>
Date: Wed, 11 Apr 2007 13:40:04 +0000
Subject: Re: [lm-sensors] w83627ehf reporting ghost fan?
Message-Id: <461CE264.7020202@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <461C3562.2070006@gmail.com>
In-Reply-To: <461C3562.2070006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Deavid

Jean Delvare wrote:
> ---------snip
> The bug is probably mine, sorry about that. The following patch should
> fix it. Ankit, can you please apply it to your kernel and report?
> David, please review and comment.
> 
> [PATCH] hwmon/w83627ehf: Fix the fan5 clock divider write
> 
> Users have been complaining about the w83627ehf driver flooding their
> logs with messages like:
> 
> w83627ehf 9191-0a10: Increasing fan 4 clock divider from 64 to 128
> 
> or:
> 
> w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> 
> The reason is that we failed to actually write the LSB of the encoded
> clock divider value for that fan, causing the next read to report the
> same old value again and again.
> 
> Additionally, the fan number was improperly reported, making the bug
> harder to find.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
---snip

The patch did solve the problem, but not completely though. Fan4
messages are gone but there are similar new messages relating to
(inexistent) fan5 in the kernel log, as here:

ankit@hunter ~ $ dmesg |grep w83627ehf
[   49.974556] w83627ehf 9191-0a10: Increasing fan5 clock divider from 8
to 16
[  432.453209] w83627ehf 9191-0a10: Increasing fan5 clock divider from
16 to 32
[  437.021310] w83627ehf 9191-0a10: Increasing fan5 clock divider from
32 to 64
[  442.016396] w83627ehf 9191-0a10: Increasing fan5 clock divider from
64 to 128


I have "ignore fan5" set in sensors.conf, so I am guessing this is same
as the previous problem. But the messages are not flooding now. So far
so good. Thank you for the help. Any ideas about this new issue?

Regards,
Ankit Chaturvedi

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
