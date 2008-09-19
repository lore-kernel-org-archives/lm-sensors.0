From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Sep 2008 15:04:37 +0000
Subject: Re: [lm-sensors] No Alarm when values not within range
Message-Id: <20080919170437.48ebf868@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5E5D87015BF8A54A93DAD6F808B1129ACB046F@DEEXVS13.wincor-nixdorf.com>
In-Reply-To: <5E5D87015BF8A54A93DAD6F808B1129ACB046F@DEEXVS13.wincor-nixdorf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Bjorn,

On Fri, 19 Sep 2008 16:40:23 +0200, Gerhart, Bjoern wrote:
> The it8718 shows the same behaviour in our environment (no Alarm
> states given). Is it for the same reason?

No, the reason would be different. The it87 driver already supports the
individual alarm files lm-sensors 3.x uses, so it should work. If it
doesn't, something must be wrong somewhere along the way. To
investigate this, we would need a dump of the IT8718F chip together
with the corresponding sensors output. You can generate such a dump
using the isadump tool that comes with lm-sensors.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
