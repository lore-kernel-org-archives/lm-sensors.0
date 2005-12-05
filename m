From: js@linuxtv.org (Johannes Stezenbach)
Date: Mon, 05 Dec 2005 00:59:29 +0000
Subject: [lm-sensors] Re: Incorrect v4l patch in 2.6.15-rc4-git1
Message-Id: <20051204235904.GB7478@linuxtv.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051202192814.282fc10c.khali@linux-fr.org> <1133602035.6724.5.camel@localhost> <20051203124715.52f8d736.khali@linux-fr.org>
In-Reply-To: <20051203124715.52f8d736.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Mauro Carvalho Chehab <mchehab@brturbo.com.br>, Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>

On Sat, Dec 03, 2005, Jean Delvare wrote:
> I'll go undefine these experimental IDs soon anyway, as the concept is
> broken IMHO. If driver authors don't use the ID, they can set it to 0.
> If they do use it, they better register it soon so as to avoid
> collisions with other drivers which haven't been merged either.

I believe no one actually uses I2C ids in drivers/media/.
Is it documented somewhere that they should be set to 0 when
unused? I believe most people set them to experimental ids
because they fear getting conflicts and malfunctionings when
they leave them at 0.

Johannes
