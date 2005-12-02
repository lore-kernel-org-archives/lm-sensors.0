From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 02 Dec 2005 19:27:05 +0000
Subject: [lm-sensors] Incorrect v4l patch in 2.6.15-rc4-git1
Message-Id: <20051202192814.282fc10c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvards@osdl.org>, Mauro Carvalho Chehab <mchehab@brturbo.com.br>, LKML <linux-kernel@vger.kernel.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>

Hi Linus,

Please revert this commit:

author	Mauro Carvalho Chehab <mchehab@brturbo.com.br>
	Thu, 1 Dec 2005 08:51:35 +0000 (00:51 -0800)
committer	Linus Torvalds <torvalds@g5.osdl.org>
	Thu, 1 Dec 2005 23:48:57 +0000 (15:48 -0800)
commit	769e24382dd47434dfda681f360868c4acd8b6e2
tree	1be728dd2f1a7f523e3de5f3f39b97a4b9905dbe
parent	6f502b8a7858ecfa7d2a0762f7663b8b3d0808fc

[PATCH] V4L: Some funcions now static and I2C hw code for IR

- Some funcions are now declared as static
- Added a I2C code for InfraRed.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

I objected against this patch here :
http://lkml.org/lkml/2005/12/1/196

I would also seriously question the benefit of merging that kind of
patch at the -rc4 stage, even if it wasn't incorrect. It's not fixing
any actual problem, I can't see how it was supposed to belong there.

Thanks,
-- 
Jean Delvare
