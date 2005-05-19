From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040126224601.7c91344b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> BTW: changing *nrels_mag below from 2 to 3 fixed it for procfs, but
> still not for sensors.
> 
> void fscher_volt(struct i2c_client *client, int operation, int
> ctl_name,
>                   int *nrels_mag, long *results)
> {
>    struct fscher_data *data = client->data;
>    if (operation = SENSORS_PROC_REAL_INFO)
>      *nrels_mag = 3;
>    else if (operation = SENSORS_PROC_REAL_READ) {

You would need to change the library too. The values are internaly
stored as integers. The driver change the way it is displayed in /proc,
but libsensors reads the integer value directly so it also has the
magnitude hardcoded. The least I can say is that it's not very clean.
Fortunately, the new sysfs interface should let us get rid of that mess
in the long term.

Anyway, the correct way to solve your problem is to export values as
pseudo-millivolts in 2.6 and as pseudo-hundreds-of-volts in 2.4. This is
the way libsensors is configured to work, although that might sound
strange at first. The idea is that the formulas in sensors.conf should
not depend on the way values are represented in procfs/sysfs. The
formulas must be relevant of the physical reality (i.e. match the
resistors as set up on the motherboard, no more, no less). For now,
libsensors handles the differences between both kernels, so that sensors
and sensors.conf don't have to care. After all, that's what libraries
are for.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
