From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: [rivatv-devel] Deadlock in console
Message-Id: <20030806222911.2ad9505b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I noticed that the rivatv module is slow loading when the monitor
> > plugged on my videocard does not support DDC/I2C. Why that? Are you
> > sending I2C commands at module init?

> Both sensor chips and decoder chips are located on the I2C bus of
> nVidia cards. So yes, we're driver the I2C bus and sending stuff to
> it. If your card does not support I2C, you don't need rivatv at all.

My card supports I2C, this is my test monitor not supporting it (my real
display does). But I think the slow loading can be solved using the
bit_test=1 parameter for i2c-algo-bit. I did not tested yet, but it
works for i2c-matroxfb, so I'd expect it to work for rivatv too.

BTW I'd like to report a bug. If I load rivatv or any related module
while in the console, my system deadlocks. I have to reboot it the hard
way. The same operations made under X work OK. Any clue?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
