From: arjan@infradead.org (Arjan van de Ven)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH] I2C update for 2.6.10-rc1
Message-Id: <1099998753.3989.10.camel@laptop.fenrus.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <zxUdaK3b.1099995467.6672570.khali@gcu.info>
In-Reply-To: <zxUdaK3b.1099995467.6672570.khali@gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: greg@kroah.com, torvalds@osdl.org, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

On Tue, 2004-11-09 at 11:17 +0100, Jean Delvare wrote:

> These functions are part of the SMBus specs. The fact that no client uses
> them for now doesn't mean that they will never be used. 

yet at the same time they bloat the kernel for everyone NOW.
If a driver magically appears that wants to use them, it's trivial to
put these in, but I see absolutely no excuse for having them in all
kernel binaries without users. This is how the kernel grows and grows
for no good reason. There's dozens of such functions all over the
kernel, and they take up unswappable memory all over. 
