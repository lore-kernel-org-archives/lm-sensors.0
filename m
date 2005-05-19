From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Gnome hangs after sensors installation
Message-Id: <20030731160543.45274e24.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BB4EE262.6D4C%zdavatz@ywesee.com>
In-Reply-To: <BB4EE262.6D4C%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Any other place I could look? Gnome still hangs at boot with the error
> I mailed you...
> 
> > 
> > Maybe there's a script brought by your distribution itself. You
> > should look for it in /etc/rc.d. The exact location depends on the
> > distribution, so I can't tell.
> I do not have /etc/rc.d
> I have /etc/rc0.d till rc7.d

Use "runlevel" to know which runlevel you are in. Then look for a
lm_sensors script in /etc/rcX.d, where X is the runlevel. It could have
any name or even not be in a specific script. You could use "grep
sensors -ir *" there to locate the script.

> My computer still hangs when starting Gnome, also some other settings
> seem messed up.

Which other settings? Details are precious.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
