From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 01 May 2006 12:22:52 +0000
Subject: [lm-sensors] Address configuration for scx200_acb
Message-Id: <20060501142252.380db372.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427234114.941c9657.khali@linux-fr.org>
In-Reply-To: <20060427234114.941c9657.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> I have a soekris net4801 which has the same sc-1100.
> On my board, ISA addys 2e, 2f talk to a separate Super-IO chip, pc87360.
> which IIRC has an acb unit also.

True, we don't have a driver for it at the moment though.

> Back when I got the board, the presence of 2 superio devices was somewhat
> confusing, until Id read both datasheets - 2x.

Does the SC1100 appears at 0x4e/0x4f on your Soekris board? If so,
Thomas' code should still work, as long as we probe both possible
address pairs.

-- 
Jean Delvare

