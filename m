From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: LM_sensors   /   Slackware9.1
Message-Id: <20040918101738.70254a20.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <414B714D.4080300@oldtolley.fsnet.co.uk>
In-Reply-To: <414B714D.4080300@oldtolley.fsnet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> root@Root:~# sensors
> Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and done
> 'modprobe i2c_sensor'!
> For older kernels, make sure you have done 'modprobe i2c-proc'!
> 
> 
> My SW9.1 is not using a 2.6 kernel, so I don't know what it refers to.

Are you blind or what? I can hardly say more to you than I already did
in ticket #1777. The solution is written in WHOLE LETTERS: modprobe
i2c-proc. Is it that hard to type these words in your shell and hit the
"Return" key?

> I know from previously installed lm_sensors in other linux OS's
> (MD10.0) I don't have any special thermistors.
> 
> Slackware seems to do things slightly different to madrake, and I may
> be missing something.

The difference is that Mandrake uses /etc/sysconfig while Slackware
doesn't. This means that sensors-detect isn't able to generate an
automatic startup script for you (yet). You'll have to manually copy the
modprobe lines sensors-detect gives to you to /etc/rc.d/rc.sensors, and
make sure this (new) file will be called when you boot (typically
through /etc/rc.d/rc.local). As an example, my (Slackware as well)
scripts look like that:

#
# /etc/rc.d/rc.local (excerpt)
#

if [ -x /etc/rc.d/rc.sensors ]
then
        . /etc/rc.d/rc.sensors
fi

#
# /etc/rc.d/rc.sensors
#

#!/bin/sh

modprobe i2c-viapro
modprobe w83781d

if [ -x /usr/local/bin/sensors ]
then
	/usr/local/bin/sensors -s
fi

#

Simply adjust to meet your own hardware configuration, and don't forget
to chmod +x your /etc/rc.d/rc.sensors script once done.

We could teach sensors-detect how to create the /etc/rc.d/rc.sensors
script automatically, I guess it would help, although the user would
still have to ensure that the script is called at some point.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
