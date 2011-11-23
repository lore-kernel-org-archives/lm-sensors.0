From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 23 Nov 2011 20:34:29 +0000
Subject: Re: [lm-sensors] [PATCH 0/3] hwmon: More LM63 enhancements
Message-Id: <20111123213429.23aba6e0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321994400-29295-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1321994400-29295-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 22 Nov 2011 12:39:57 -0800, Guenter Roeck wrote:
> Add support for unsigned temperatures on LM96163
> Add support for writing remote T_CRIT limit
> Add support for writing conversion rate register
> 
> Question:
>   Calculations are currently along the line of "/ 125 * 32", causing loss of accuracy.
>   Ok to change to "* 32 / 125" ?

I think this is on purpose. Multiplying last guarantees that we don't
try to set bits which do not exist to 1. As long as proper rounding is
done before dividing, I don't quite see how we could be losing
accuracy. Do you have an actual example?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
