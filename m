From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 30 May 2006 12:34:39 +0000
Subject: [lm-sensors] [PATCH] Fix the set pwm value will change fan mode
Message-Id: <20060530143439.69125e22.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <444610F0.1070809@winbond.com.tw>
In-Reply-To: <444610F0.1070809@winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> And do we need to add lock in other store functions in w83792d ?

Yes, we do. I'm surprised that it isn't the case. All drivers were
supposedly fixed at the same time. Maybe the w83792d driver was
integrated at that time and slipped through the checks.

-- 
Jean Delvare

