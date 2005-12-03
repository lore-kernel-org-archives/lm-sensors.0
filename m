From: mchehab@brturbo.com.br (Mauro Carvalho Chehab)
Date: Sat, 03 Dec 2005 10:27:58 +0000
Subject: [lm-sensors] Re: Incorrect v4l patch in 2.6.15-rc4-git1
Message-Id: <1133602035.6724.5.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051202192814.282fc10c.khali@linux-fr.org>
In-Reply-To: <20051202192814.282fc10c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Linus Torvalds <torvards@osdl.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>

Em Sex, 2005-12-02 ?s 19:28 +0100, Jean Delvare escreveu:
> Hi Linus,
> 
> Please revert this commit:
> 
> author	Mauro Carvalho Chehab <mchehab@brturbo.com.br>
> 	Thu, 1 Dec 2005 08:51:35 +0000 (00:51 -0800)
> committer	Linus Torvalds <torvalds@g5.osdl.org>
> 	Thu, 1 Dec 2005 23:48:57 +0000 (15:48 -0800)
> commit	769e24382dd47434dfda681f360868c4acd8b6e2
> tree	1be728dd2f1a7f523e3de5f3f39b97a4b9905dbe
> parent	6f502b8a7858ecfa7d2a0762f7663b8b3d0808fc
> 
> [PATCH] V4L: Some funcions now static and I2C hw code for IR
> 
> - Some funcions are now declared as static
> - Added a I2C code for InfraRed.

	Please point what is so deadly broken on this trivial patch that fix a
bug where a prodution driver is using I2C code reserved for
experimentation.

Cheers, 
Mauro.

