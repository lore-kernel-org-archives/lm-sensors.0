From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 29 Jun 2009 10:57:04 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: add GP2A002 proximity/ambient sensor
Message-Id: <20090629105704.GA1478@ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A448926.1030701@samsung.com>
In-Reply-To: <4A448926.1030701@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, lm-sensors@lm-sensors.org, suchang.woo@samsung.com, kyungmin.park@samsung.com

On Fri 2009-06-26 17:39:02, Minkyu Kang wrote:
> The GP2A002 is a I2C interfaced Sensor for Proximity/Ambient
> This patch adds support the GP2A002 sensor
> 
> Signed-off-by: Minkyu Kang <mk7.kang@samsung.com>
> Signed-off-by: Suchang Woo <suchang.woo@samsung.com>

It would be nice to document what it does and what interface to
userland it provides...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
