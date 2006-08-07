From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 07 Aug 2006 09:28:55 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <20060807112855.f83a0bea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Jean Delvare wrote:
> > No, please. I2C is something which you should depend on, not something
> > you select.
> >   
> 
> Why? It's infrastructure basically.

Every i2c driver to date depends on I2C, and my experience is that
mixing select and depends tends to confuse Kconfig, users, or both.

Now if you believe that this is an error and I2C should always be
selected rather than depended upon, I'm waiting for your patch :)

-- 
Jean Delvare

