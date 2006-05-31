From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 31 May 2006 13:10:03 +0000
Subject: [lm-sensors] [PATCH] hwmon w83792d add data lock to all store
Message-Id: <20060531151003.9028d71e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <447D3714.6070506@winbond.com.tw>
In-Reply-To: <447D3714.6070506@winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> I add the lock to all store functions in this patch, please can
> you check?

It's OK except in store_pwmenable where you would leave with the lock
held on incorrect input value.

Your patch also lacked your signed-off-by line, and a proper summary...

-- 
Jean Delvare

