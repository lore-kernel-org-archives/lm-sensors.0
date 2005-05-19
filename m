From: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: Sensor module hangs in 2.8.1, works fine with 2.6.1
Message-Id: <20031122171824.GE9696@ip68-0-152-218.tc.ph.cox.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0311171503100.32590@tuxracer.humanmodeling.tecmath.de>
In-Reply-To: <Pine.LNX.4.58.0311171503100.32590@tuxracer.humanmodeling.tecmath.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 21, 2003 at 10:59:32PM +0100, Jean Delvare wrote:
> 
> > 00:00.0 Host bridge: ServerWorks CNB20LE (rev 06)
> > 00:00.1 Host bridge: ServerWorks CNB20LE (rev 06)
> > 00:0f.0 ISA bridge: ServerWorks OSB4 (rev 50)
> > 00:0f.1 IDE interface: ServerWorks: Unknown device 0211
> > 00:0f.2 USB Controller: ServerWorks: Unknown device 0220 (rev 04)
> 
> This is the very same as Martin's (except that he seems to have USB
> disabled), so if there is a way to differenciate the two of them, it's
> not by using the PCI data. I think we'll have to disable the workaround
> by default. We might consider adding a module parameter to reenable it.
> If you can provide another way to automatically detect when that
> workaround is needed, we would implement it.

What are the contents of the register on his board?

-- 
Tom Rini
http://gate.crashing.org/~trini/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031122/095fc3fe/attachment.bin
