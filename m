From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Gnome hangs after sensors installation
Message-Id: <20030731154532.4fc15e2b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BB4EE262.6D4C%zdavatz@ywesee.com>
In-Reply-To: <BB4EE262.6D4C%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> >> I just installed lm-sensors 2.8.0 on my Debian PPC - it said:
> >> Installation successful. My computer hung itself up when I done
> >> sensors-detect. At startup I know get:
> > 
> > At which point of sensors-detect dit hit hang?
> I think after looking for the ISA-Bus.

Ah OK, it's different from what I had first thought.

> I looged into the console with fn+ctrl+alt now when I run sensors I
> get: Error while loading  shared libraries: libsensors.so.2: cannot
> open shared oject file: No such file or directory
> 
> What does that mean?

It means that you forgot to run "ldconfig" after installing. (Before
doing that, you may have to add the line "/usr/local/lib" to
/etc/ld.so.conf, if it's not already there).

> My computer still boots but it just does not start GNOME.

Oh, great. It's less awful than I first feared.

> Where do I have to look for the startup script of lm-sensors? In
> /etc/rc.d?

If sensors-detect did not finished its installation, then the startup
script is probably not installed. Just check in /etc/sysconfig if you
can see any "lm_sensors" file. If there is one, delete it.

Maybe there's a script brought by your distribution itself. You should
look for it in /etc/rc.d. The exact location depends on the
distribution, so I can't tell.

Why Gnome doesn't start anymore, that I can't say. Do you have any
hardware monitoring application? (Gkrellm maybe?) Maybe it's trying to
load some modules and fails.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
