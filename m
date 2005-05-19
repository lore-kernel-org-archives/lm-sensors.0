From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: [PATCH 2.6] probe fewer addresses for asb100 (sensors) driver
Message-Id: <20050103194511.30ca036b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050102212501.GA17759@jupiter.solarsys.private>
In-Reply-To: <20050102212501.GA17759@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> This patch limits SMBus scanning for the asb100 sensor chip
> to just one address - the only one we've ever seen in practice.

Nice!

Could you please update lm_sensors2/doc/chips/asb100 accordingly?

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
