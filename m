From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Aug 2008 08:49:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (atxp1) Fix device detection logic
Message-Id: <20080814104905.76138b60@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080629123111.26ffc368@hyperion.delvare>
In-Reply-To: <20080629123111.26ffc368@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sebastian,

Please keep the lm-sensors list Cc'd.

On Thu, 14 Aug 2008 00:09:32 +0200, Sebastian Witt wrote:
> Hello Jean,
> 
> sorry, missed your mail. The test sequence was:
> 
> 1. If vendor ID registers are all zero, assume ATXP1.
> 2. If not, do second test. If it succeeds it is a ATXP1.
> 
> I'm not sure anymore why it was this way, maybe I thought there would be a ATXP1 
> with vendor ID so it works for both...

That's indeed what the current code does, but that's not correct. We
want to check that _both_ conditions are met. Even with that, the
detection is rather weak... Without that it's very, very weak.

> However aborting when the first test fails and doing always the second test 
> should be fine, but I can't test it because I gave away the board some time ago.

If you look at the comments in the original code, that's what they say:
we have "No vendor ID" inside the block which is executed when there
_are_ IDs. So it's clear to me that the code doesn't do what we
intended to do in the first place, and was "working" only by accident.

Even if you can't test my patch, can you please review it and add your
Acked-by, so that I can push it upstream? Thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
