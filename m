From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Jun 2006 15:45:41 +0000
Subject: [lm-sensors] PATCH: hwmon-abituguru-nofans-detect-fix.patch
Message-Id: <20060604174541.9614e93f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4482F184.1040006@hhs.nl>
In-Reply-To: <4482F184.1040006@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> One of my testers had a problem where the driver only saw 2 of the 4 fan
> sensors his uGuru has, this fixes this:
> -accept 0x40 (bit 6) being high as a valid fan sensor setting for all
>  fans not just fan 1, I have a feeling this bit indicates whether or not
>  a fan is actually connected .
> 
> Signed-off-by: Hans de Goede <j.w.r.degoede at hhs.nl>

Applied, thanks.

> Well this is the first small fix to the uGuru driver I hope it will also
> be the last for atleast a couple of days. If this becomes a daily
> business (which I don't expect it to become) its probably the best to
> bundle fixes and send a patch once a week or do you prefer many small
> patches?

I told you this would happen, remember ;)

I'm totally fine with small patches, they're easier to review, revert
and/or backport.

-- 
Jean Delvare

