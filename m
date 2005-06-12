From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 12 Jun 2005 23:22:17 +0000
Subject: [lm-sensors] Sensor readings
Message-Id: <20050612232143.475e89c0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <op.sr7hnt2fcb5z0o@linux.site>
In-Reply-To: <op.sr7hnt2fcb5z0o@linux.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> Is there a way the sensors(prog) would write the reading into a file
> e.g. /proc/acpi/thermal_zone/info
> every x seconds, so I would be able to read the temperature via  
> Ktemperature program?

No way. /proc isn't a place where you can write random data, it's a
virtual, kernel-driven filesystem.

Better use an application which interfaces directly with lm_sensors,
such as ksensors [1] or xsensors [2].

[1] http://ksensors.sourceforge.net/
[2] http://www.linuxhardware.org/xsensors/

-- 
Jean Delvare
