From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 14 Oct 2005 21:59:55 +0000
Subject: [lm-sensors] [PATCH] drivers/i2c/chips/eeprom.c - missing static
Message-Id: <20051014202032.05b16246.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051013101444.GA26868@home.fluff.org>
In-Reply-To: <20051013101444.GA26868@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> eeprom_detect is first declared static and then when
> the function is actually implemented, there is no
> static.

Correct, applied, thanks.

PS: Please avoid posts with empty CC:, these tend to end up in my spam
box.

-- 
Jean Delvare
