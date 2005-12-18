From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Dec 2005 17:42:15 +0000
Subject: [lm-sensors] [PATCH] i2c-busses-scx200_acb : add support for
Message-Id: <20051218184215.631ce658.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <808c8e9d0512160810t664d3939t846efce05a50ebf0@mail.gmail.com>
In-Reply-To: <808c8e9d0512160810t664d3939t846efce05a50ebf0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> Modify scx200_acb.c to support the AMD Geode CS5535 and CS5536 SMBus,
> since they are all register-compatible.

Can you please split this patch into two distinct parts:
1* Whitespace cleanups and similar minor edits.
2* AMD Geode CS5535 and CS5536 support.

This will make the review much easier.

Thanks,
-- 
Jean Delvare

