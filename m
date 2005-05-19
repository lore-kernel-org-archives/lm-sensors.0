From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: [PATCH] More i2c driver changes for 2.5.69
Message-Id: <3EBC834F.3020001@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048295086481@kroah.com>
In-Reply-To: <1048295086481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg KH wrote:

> ChangeSet 1.1083.2.5, 2003/05/09 14:54:25-07:00, warp@mercury.d2dc.net
> 
> [PATCH] I2C: And another it87 patch.

> And lastly, when changing the fan count divisor, fix up the min setting
> to still be roughly the same. (Previously the meaning of the value in
> the register changed, but not the value itself, resulting in, undesired
> surprises.)


Hmmm...  I don't think any of the other drives make this adjustment.

I think the expectation would be that fan divisors and minimums would be set 
using 'sensors -s' but I could see that this could create an order dependancy. 
  If the minmum was set before the divisor, and the divisor was changing, then 
you'd get the wrong result.

So this is probably a good idea, but we'll need to watch for this in the other 
drivers either for 2.7.1 or as they are converted to the new CVS...

:v)



