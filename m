From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Ticket# 1566
Message-Id: <1075998365.40226e9d949b2@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <02f601c3ebf9$5dacdde0$c8de11cc@black>
In-Reply-To: <02f601c3ebf9$5dacdde0$c8de11cc@black>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Mike Black <mblack@csi-inc.com>:

> Got this after restarting sensord like this: /usr/local/sbin/sensord
> -d --rrd-file /var/sensor/yeti.rrd w83782d-i2c-0-2d
> Feb  5 09:32:57 yeti sensord: Error updating RRD file:
> /var/sensor/yeti.rrd: expected 15 data source readings (got 0) from
> N:...

You point it to a non-existent device. No surprise it doesn't like it.

> Removed the old rrd file and tried: /usr/local/sbin/sensord -d
> --rrd-file /var/sensor/yeti.rrd
> Feb  5 09:51:40 yeti sensord: Error getting sensor data: w83782d/#81:
> Can't access procfs/sysfs file

OK, this must be a real problem. Probably sensord tries to scan the
list
of devices and fails because it wasn't properly ported to the sysfs
interface.

The problem is that I don't use sensord, and I don't think any of the
developers do. Thus it is almost left unmaintained, compared with
sensors which is very well tested.

> With wildcards still fails: /usr/local/sbin/sensord -d --rrd-file
> /var/sensor/yeti.rrd w83782d-\*
> Feb  5 09:53:24 yeti sensord: sensord failed

Can't tell wether this is the same problem as the other one. If you can
find out where the problem lies, I may take a look.

> Have to start sensord like this: /usr/local/sbin/sensord -d
> --rrd-file /var/sensor/yeti.rrd w83782d-i2c-3-2d

If at least this works, you can use that :)

> sensors now shows:
> w83782d-i2c-3-2d
> Adapter: SMBus AMD756 adapter at 80e0
> (...)
> DDR V:     +1.23 V  (min =  +2.85 V, max =  +3.47 V)       <<<<<<<<
> low by more than 2X
> 3 VSB:     +3.33 V  (min =  +2.85 V, max =  +3.15 V)        <<<<<<<<
> too high?
> Bat V:     +2.61 V  (min =  +2.64 V, max =  +3.95 V)         <<<<<<<<
> too low??

Well, I'd expect that Tyan provides working configuration files. If not,
see with them. They know their boards much better than anyone, of
course, so if there's something broken in the configuration files, they
should be able to help you and correct.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
