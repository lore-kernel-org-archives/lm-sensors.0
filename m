From: bryan@ak.net (bryan@ak.net)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: compile bug workaround (ticket 1344)
Message-Id: <20031028015235.GA495@avalon.gci.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031026224736.GA6514@avalon.gci.net>
In-Reply-To: <20031026224736.GA6514@avalon.gci.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 27, 2003 at 10:33:11PM +0100, Jean Delvare <khali@linux-fr.org> wrote:
> 
> > I had the exact same problem as the poster in ticket 1344.  The poster
> > offered a workaround which is not very clean.  I improved the
> > workaround a bit: I switched module compilation on, and did a "make
> > user".  I then copied sensors.h to sensors.h.bak.  After that, I did a
> > "make clean", restored sensors.h from the backup, turned module
> > compilation back off, and did another "make user".  The compilation
> > went fine then.
> 
> Well, the bug is fixed in our latest release (2.8.1) anyway.

That's good, but I run kernel 2.4.21, and I use bttv, so I needed
the i2c kernel patch.  Kernel 2.4.22 has a patch for i2c-2.8.1, but
for some reason, kernel 2.4.21 only has a patch for i2c-2.8.0.  So
at this point, anyone running kernel 2.4.21 will be stuck with version
2.8.0.

--
Bryan Medsker
bryan@ak.net
