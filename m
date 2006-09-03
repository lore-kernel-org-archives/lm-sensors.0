From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 03 Sep 2006 13:07:01 +0000
Subject: [lm-sensors] [PATCH 2.6.18-rc4-mm3] hwmon: unchecked return
Message-Id: <20060903150701.c7e6b89b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060830030502.GA5104@jupiter.solarsys.private>
In-Reply-To: <20060830030502.GA5104@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > This patch fixes up some hwmon drivers so that they no longer ignore
> > return status from device_create_file().  Compile-tested only.
> 
> I have an ADM1025 eval board somewhere, I'll try to resurect it
> tomorrow and I'll test adm1025. I can't see why it wouldn't work
> though.

Just tested, and it works all OK.

-- 
Jean Delvare

