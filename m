From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: [PATCH] Architecture dependent build flags
Message-Id: <20050311213713.22d7cc4e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050310022816.GA928@bode.aurel32.net>
In-Reply-To: <20050310022816.GA928@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Aurelien,

> Please find two patches, one for i2c and one for lm-sensors, to set
> gcc flags that are architecture dependent (to match the kernel ABI).

Applied, thanks.

Not sure lm_sensors is of any use on all these, but it cannot hurt.

-- 
Jean Delvare
