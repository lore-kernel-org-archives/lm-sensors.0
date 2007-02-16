From: david-b@pacbell.net (David Brownell)
Date: Fri, 16 Feb 2007 06:39:43 +0000
Subject: [lm-sensors] [patch 2.6.20-git] hwmon should use subsys_init
Message-Id: <20070216063943.50DDF102FAA@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200702151603.13810.david-b@pacbell.net>
In-Reply-To: <200702151603.13810.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > This patch makes the hwmon subsystem code register itself appropriately early:
> > as a subsystem, like other subsystems.
>
> This patch is already in my tree and planned for inclusion in kernel
> 2.6.21.

OK ... I thought I'd already sent that along, but didn't have a
note that I'd done so.


>	I asked Linus to pull the hwmon updates (including this one)
> from my tree two days ago but he did not yet. I'll ask him again
> tomorrow if needed.

He has to pull ARM patches too.  Right now ARM can't build, so I
can't test the latest I2C stuff ... ;)

- Dave


