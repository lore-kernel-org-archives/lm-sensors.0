From: johannes@sipsolutions.net (Johannes Berg)
Date: Wed, 05 Jul 2006 08:00:15 +0000
Subject: [lm-sensors] [Hdaps-devel] Generic interface for accelerometers
Message-Id: <1152086415.4995.0.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
	 <20060703124823.GA18821@khazad-dum.debian.net>
	 <20060704075950.GA13073@elf.ucw.cz>
In-Reply-To: <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Henrique de Moraes Holschuh <hmh@debian.org>, Stelian Pop <stelian@popies.net>, Michael Hanselmann <linux-kernel@hansmi.ch>, hdaps-devel@lists.sourceforge.net, lm-sensors@lm-sensors.org

[I hope I managed to not break the thread]

> Also, there's a small issue with polling frequency. hdapsd needs a
> fairly high frequency (say, 50Hz) to gather statistics and keep
> response latency low, whereas the hdaps driver's internal polling
> (routing to the input infrastructure) is currently done at only 20Hz.
> We'll need to increase the latter, thereby slightly increasing system
> load when hdaps isn't running.

Note that with AMS we're better off -- it has two interrupts telling us
when something is wrong.

Hence, most of the discussion about loads of input values only applies
to hdaps, the actual head-park functionality can be implemented with AMS
without ever reading any sensor values.

Hence we also need much less complexity in userland -- once an interrupt
comes in we trigger the hd park...

johannes
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060705/d69ff9ed/attachment-0001.bin 
