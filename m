From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 03 Dec 2006 10:36:05 +0000
Subject: [lm-sensors] new vt1211 driver: Can't access procfs/sysfs file
Message-Id: <20061203113605.a00f8766.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45728865.5020308@xs4all.nl>
In-Reply-To: <45728865.5020308@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Udo,

On Sun, 03 Dec 2006 09:18:45 +0100, Udo van den Heuvel wrote:
> Since booting into 2.6.19 on my VIA SP8000 I have a small problem with
> the vt1211 sensors driver:
> 
> sensors -s gives:
> 
> vt1211-isa-6000: Can't access procfs/sysfs file for writing;

Are you root when running this command?

> 
> Also the temperature sensors are not shown.

Please provide the complete output of "sensors".

> 
> sysfs is of course mounted and accessible.
> lm_sensors 2.10.1 we have installed before rebooting.

What does "sensors -v" return?

> 
> The vt1211 sensors stuff has moved to
> /sys/bus/platform/drivers/vt1211/vt1211.24576. In that directory the
> files with sensors info for rpm, voltage etc can be found.

Yes, this is OK. You should also have a link in /sys/class/hwmon
pointing to it.

> 
> Of course the sensor's location on the bus was not changed so I am
> wondering what is wrong, why can't the sensors command find the files in
> /sys/bus/platform/drivers/vt1211/vt1211.24576?

Please provide a detailed listing (ls -l) of the files present in this
directory.

-- 
Jean Delvare

