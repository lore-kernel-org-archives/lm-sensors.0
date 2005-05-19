From: kraxel@bytesex.org (Gerd Knorr)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: bt869 driver
Message-Id: <20050203184413.GF11979@bytesex>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050129234511.5dc19d3b.khali@linux-fr.org>
In-Reply-To: <20050129234511.5dc19d3b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> BTW- Does anyone know how the I2C bus/chip driver interfaces work in 
> x.org?  Specificly, does it register anything with the kernel, or will 
> drivers in the kernel cause nasty race conditions and such with 
> corresponding drivers in x.org?

Havn't touched X11 code for quite some time, but IIRC they have some i2c
infrastructure in the x-server (because it's also needed for ddc) and
userspace drivers (which don't register anywhere) for that kind of stuff.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
