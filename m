From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 05 Jun 2006 08:07:14 +0000
Subject: [lm-sensors] [PATCH] lm_sensors2 w83792d fix uncorrect pwm
Message-Id: <20060605100714.f42c3a35.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4483DE27.8050400@winbond.com>
In-Reply-To: <4483DE27.8050400@winbond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> w83792d driver for kernel 2.4 also use a wrong pwm value
> limit, thanks for Rudolf's remind :)

That's right. Thanks for the patch, I just applied it.

-- 
Jean Delvare

