From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 05 Feb 2011 18:04:25 +0000
Subject: Re: [lm-sensors] Standalone driver for W83677HG-I, NCT6775F,
Message-Id: <20110205180425.GA26728@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205175852.GA26672@ericsson.com>
In-Reply-To: <20110205175852.GA26672@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 05, 2011 at 12:58:52PM -0500, Guenter Roeck wrote:
> Hi,
> 
> a standalone driver for W83667HG-I (NCT6771F, NCT6775F) and NCT6776F
> is available for testing at http://roeck-us.net/linux/drivers/w83627ehf/.
> 
> Please test and let me know if there are any problems.
> 
I should add that fan control and fan speed detection on DH57JG boards
doesn't work because Intel uses fan control provided by the PCH.

It should work on other boards, but obviously needs testing.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
