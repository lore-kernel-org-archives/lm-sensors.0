From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: subclient leak in asb100 driver
Message-Id: <20040509125636.3d85302b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040410110533.49ba7483.khali@linux-fr.org>
In-Reply-To: <20040410110533.49ba7483.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> > I.e. technically, it's the CVS w83781d driver that's wrong...
> > although it happens to be benign vs. 2.4 kernel.
> 
> Yes, I see that now. I'm surprised that it doesn't cause more trouble
> than it does. Care to correct the 2.4/CVS driver so that it does what
> your asb100 driver does (i.e. the right thing)?

I took a longer look at the w83781d driver and finally, it doesn't seem
to be broken. It simply relies on the fact that i2c-core will detach the
clients on the same order they were attached. Since the w83781d driver
attached the main client before attaching the subclients, the main
client is detached first. In the callback function, the driver detaches
the subclients "manually" (as opposed to letting i2c-core take care).
When returning from the callback function, the subclients are already
gone, so i2c-core doesn't do anything for them (verified).

So I don't think there's anything that needs fixing here. Let me know if
I missed something.

-- 
Jean Delvare
http://khali.linux-fr.org/
