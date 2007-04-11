From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Apr 2007 13:56:11 +0000
Subject: Re: [lm-sensors] w83627ehf reporting ghost fan?
Message-Id: <20070411155611.59276f51@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <461C3562.2070006@gmail.com>
In-Reply-To: <461C3562.2070006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ankit,

On Wed, 11 Apr 2007 18:58:04 +0530, Ankit Chaturvedi wrote:
> The patch did solve the problem, but not completely though. Fan4
> messages are gone but there are similar new messages relating to
> (inexistent) fan5 in the kernel log, as here:
> 
> ankit@hunter ~ $ dmesg |grep w83627ehf
> [   49.974556] w83627ehf 9191-0a10: Increasing fan5 clock divider from 8
> to 16
> [  432.453209] w83627ehf 9191-0a10: Increasing fan5 clock divider from
> 16 to 32
> [  437.021310] w83627ehf 9191-0a10: Increasing fan5 clock divider from
> 32 to 64
> [  442.016396] w83627ehf 9191-0a10: Increasing fan5 clock divider from
> 64 to 128
> 
> 
> I have "ignore fan5" set in sensors.conf, so I am guessing this is same
> as the previous problem. But the messages are not flooding now. So far
> so good. Thank you for the help. Any ideas about this new issue?

This isn't an issue, it works as designed. The ignore statement in your
configuration file is a user-space thing, the driver doesn't know about
it. The driver attempts to get a valid reading from the fan input,
until the clock divider hits the max (128), it cannot differentiate
between a very slow fan and no fan at all.

BTW, you get these messages in your logs because you asked for them.
These are debugging messages, normally not printed.

Thanks for testing and reporting, I'll push the patch upstream.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
