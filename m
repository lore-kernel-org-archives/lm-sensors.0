From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: etc/rc.d
Message-Id: <20030125222611.47c53872.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E2F7A18.7040006@moment.net>
In-Reply-To: <3E2F7A18.7040006@moment.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> You say to put the modprobe lines in the appropriate /etc/rc.d file, 
> what is the appropriate file. All of my rc.d files contain nothing but
> shell scripts.

Yes, running modprobe lines is an appropriate job for shell scripts. The
exact file depends on your distribution. For exemple, I am running a
Slackware 8.0 distribution and it works this way:

In /etc/rc.d/rc.local, I added the following lines:

--- snip ---
if [ -x /etc/rc.d/rc.sensors ]
then
    . /etc/rc.d/rc.sensors
fi
--- snip ---

And then, in /etc/rc.d/rc.sensors:

--- snip ---
#modprobe i2c-proc
modprobe i2c-i801
modprobe eeprom

if [ -x /usr/local/bin/sensors ]
then
    /usr/local/bin/sensors -s
fi
--- snip ---

This may look like this or not for your distribution, that I can't say.
You may find that someone used to the distribution you are using will be
more helpful that us for solving the problem, because it is much more
related to the distribution than to lm_sensors.

Good luck.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
