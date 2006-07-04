From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 04 Jul 2006 10:57:11 +0000
Subject: [lm-sensors] [Hdaps-devel] Generic interface for accelerometers
Message-Id: <20060704105711.GA13658@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060703124823.GA18821@khazad-dum.debian.net> <20060704075950.GA13073@elf.ucw.cz> <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
In-Reply-To: <41840b750607040326y7bfe92dy21c6845ab034ce30@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shem Multinymous <multinymous@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@debian.org>, Stelian Pop <stelian@popies.net>, Michael Hanselmann <linux-kernel@hansmi.ch>, hdaps-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi!

> >Just use input infrastructure and be done with that? You can do
> >parking from userspace.
> 
> Will moving the hdapsd userspace daemon from sysfs polling to the
> input infrastructure cause a noticable latency increase compared to
> polling sysfs? This functionality is highly time-critical.

Well, for input you should need no polling. input tells you when data
is ready.

> BTW, can the driver tell when nothing is accessing its input device,
> and avoid polling in that case?

Ask vojtech/dmitry, I guess.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

