From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Apr 2007 14:08:00 +0000
Subject: Re: [lm-sensors] Hardware monitoring subsystem maintainer
Message-Id: <20070413160800.37488b5d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <461dca480d7ec@wp.pl>
In-Reply-To: <461dca480d7ec@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Thu, 12 Apr 2007 07:57:28 +0200, Krzysztof Helt wrote:
> The documentation is still confusing to me. Can someone of you
> update it to answer these questions directly?

This is rather off-topic for this thread, so I removed LKML from Cc.

> A. What is meaning of 0 and 1 values in pwmX_enable ?

This is already documented.

> B. How to stop the fan (pwmX_enable = 1 and pwmX = 0 was
> suggested to someone on the list)?

Yes, this is the correct method.

> C. How t o handle situation if the pwm register minimum value (0)
> does not stop the fan, but there is a separate bit to do it? (do
> stop emulate with the bit when 0 is written to pwmX?)

Yes, again that's the correct method.

You seem to understand how it works just fine, so instead of asking us
to update the document, why don't you do it yourself and send us a
patch?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
