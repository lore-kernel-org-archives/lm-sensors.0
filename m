From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 08 Sep 2010 15:29:02 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add support for max6695 and max6696
Message-Id: <20100908172902.6ed57505@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1283639675-31714-1-git-send-email-guenter.roeck@ericsson.com>
	<20100906181229.2e25db07@hyperion.delvare>
	<20100908102816.GA10676@ericsson.com>
	<20100908134854.2c60f406@hyperion.delvare>
	<20100908135654.GA11277@ericsson.com>
In-Reply-To: <20100908135654.GA11277@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, 8 Sep 2010 06:56:54 -0700, Guenter Roeck wrote:
> Too bad - registers 0x16 and 0x17 exist on both 6658 and 6659. So the only way to detect 6659 
> would be the address (0x4d or 0x4e), and we would mis-detect it on 0x4c. Is that worth it ?

I'd say adding support for the MAX6659 is worth it. Just don't add
detection. That is, all of MAX6657, 6658 and 6658 should be detected as
max6657, which has the minimum set of features. But if someone declares
a "max6659" device either as part of the platform data or from
user-space, then the driver should expose all the chip features.

Deal?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
