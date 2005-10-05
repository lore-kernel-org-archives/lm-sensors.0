From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 05 Oct 2005 23:18:45 +0000
Subject: [lm-sensors] [PATCH] I2C Documentation fix
Message-Id: <20051005231810.6c683897.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509141420.AA01311@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200509141420.AA01311@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Konbanwa Hideki,

> The name which can be set to i2c_driver is up to 31 characters.

Correct, I've committed your patch to CVS, thanks.

I'll port it to Linux 2.6 too, with some changes as the rules for this
name are a bit different there.

Arigato,
-- 
Jean Delvare
