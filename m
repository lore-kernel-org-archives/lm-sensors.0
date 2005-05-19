From: ploujj@gmail.com (Michael P)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: Ticket #1941: nforce4 support in sensors-detect
Message-Id: <18e57513050328204072f33d51@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050325220626.4fdc613c.khali@linux-fr.org>
In-Reply-To: <20050325220626.4fdc613c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hah! I tried the "modprobe it87 force=9191,0x290" method, and
basically, it didn't work.
The module loaded fine. When I executed 'sensors -s' one of the chips
on the motherboard (not the case speaker) started making a continuous
beep (hope that makes sense). At such a late hour I did not wait check
dmesg or anything and quickly rebooted the system. After rebooting, I
decided to listen to some music (with headphones connected to my
speakers). When ALSA modules loaded and the sound volume was raised my
external speakers (connected to a PCI snd. card through a sub) decided
to play the same note (continuous beep). This speaker weirdness didn't
stop until I totally powered the system down. The PSU had to be
unplugged, and I waited about 30 seconds before powering the system
(including the sup+speakers) back up. Only then, this sound never came
back again.
Note that the speakers made the noise only when the volume was turned
up, and all of this is completely reproducible.
