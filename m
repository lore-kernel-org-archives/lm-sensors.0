From: hmh@debian.org (Henrique de Moraes Holschuh)
Date: Wed, 05 Jul 2006 14:06:19 +0000
Subject: [lm-sensors] [Hdaps-devel] Generic interface for accelerometers
Message-Id: <20060705140619.GB8452@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com> <20060703124823.GA18821@khazad-dum.debian.net> <20060704075950.GA13073@elf.ucw.cz> <1152086415.4995.0.camel@localhost>
In-Reply-To: <1152086415.4995.0.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Stelian Pop <stelian@popies.net>, Michael Hanselmann <linux-kernel@hansmi.ch>, hdaps-devel@lists.sourceforge.net, lm-sensors@lm-sensors.org

On Wed, 05 Jul 2006, Johannes Berg wrote:
> > Also, there's a small issue with polling frequency. hdapsd needs a
> > fairly high frequency (say, 50Hz) to gather statistics and keep
> > response latency low, whereas the hdaps driver's internal polling
> > (routing to the input infrastructure) is currently done at only 20Hz.
> > We'll need to increase the latter, thereby slightly increasing system
> > load when hdaps isn't running.
> 
> Note that with AMS we're better off -- it has two interrupts telling us
> when something is wrong.
> 
> Hence, most of the discussion about loads of input values only applies
> to hdaps, the actual head-park functionality can be implemented with AMS
> without ever reading any sensor values.
> 
> Hence we also need much less complexity in userland -- once an interrupt
> comes in we trigger the hd park...

Looks nice.  For AMS, then, the userspace daemon can choose between deciding
for itself when to park heads using accel data, or to trust the firmware and
do it when told, or even to do both.

IBM *could* have done the same, since they already have an H8
microcontroller looking at that accelerometer :(  Anyway, IMHO it would be
good to have AMS-like behaviour where the kernel driver exposes head-park
events to userspace in the generic interface.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

