From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH 2.6] I2C: New hardware monitor driver: adm9240
Message-Id: <20050501151002.0396083d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
In-Reply-To: <5pst6197ke5d20ouv6h0rgokd32mdbsndi@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> Completion of Michiel Rook's port of adm9240 to 2.6 with addition 
> of auto fan clock divider based on Jean Delvare's algorithm, and 
> replaces scaling macros with static inlines.  
> 
> This patch is updated against 2.6.12-rc3-mm1, no other changes.

Thanks for the good work! I applied this version to my local tree. Greg,
please pick it.

-- 
Jean Delvare
