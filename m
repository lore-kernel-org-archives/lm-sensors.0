From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 15 Nov 2005 21:03:25 +0000
Subject: [lm-sensors] Re: [PATCH] lm_sensors2 : Fix W83627THF VID reading
Message-Id: <20051115210344.6ae6e076.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECEAF7CB6@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECEAF7CB6@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> This patch fixes the VID reading; VID will always return 0 when GPIO5 of
> w83627thf is not enabled.

Will apply, with the same modifications I proposed for the Linux 2.6
patch, if you agree with these.

> Signed-off-by: Yuan Mu <ymu@winbond.com.tw>

Note that you do not have to sign lm_sensors2 CVS patches that way ;)

Thanks,
-- 
Jean Delvare
