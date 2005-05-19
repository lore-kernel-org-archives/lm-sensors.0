From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: lm_sensors && bt869
Message-Id: <20031228153744.49065c91.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I saw that you have developed the bt869 driver for the lm_sensors
> project. I always used your module with my Voodoo3 3000 AGP without
> major problems. However, I had to switch to the 2.6.0 Linux kernel and
> now I don't know how to get the TV-Out working. According to the
> lm-Sensors homepage, the modules can't be used with the 2.6.0 kernel
> (the i2c-voodoo3 is already included in the kernel but there's no
> bt869). Do you know any way how to get around that problem or anyone
> who could help me? Isn't there a way to load the bt869-module in a
> 2.6.0 kernel?

All drivers need to be ported before they can be used with Linux 2.6.
All bus drivers have already been (including i2c-voodoo3) but several
chip drivers haven't been yet (including bt869). If you want to port it
yourself, let us know and we'll point you to the correct docs. That's
not really complicated, but we are all rather busy and don't have all
the necessary hardware for testing, which is preferable when messing
with kernel drivers. If you don't want to, or cannot, port it yourself,
you'll have to wait until someone else does, and I can't tell you how
much time it will be.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
