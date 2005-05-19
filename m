From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: lmsensors on Sony PCG-GRX416G - part 2
Message-Id: <20050206103721.25add975.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502060104.51022.lists@localguru.de>
In-Reply-To: <200502060104.51022.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marcus,

> 00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)

SMBus is there and properly supported by i2c-i801. However, I can only
confirm what Rudolf told: hardware monitoring on Sony laptops isn't
supported by lm_sensors. The only information I can get on mine is
temperature through /proc/acpi, and the same hold true for all other
Vaio owners I've discussed with so far. So I invite you to look in
/proc/acpi/fan (empty for me) and /proc/acpi/thermal_zone, and that's
probably all you can do.

There is some docmuentation about the ACPI thermal zone here:
http://acpi.sourceforge.net/documentation/thermal.html

What lm_sensors *can* do for you is display what the Vaio proprietary
EEPROM contains. With the eeprom driver loaded, "sensors" should display
something like:

eeprom-i2c-0-57
Adapter: SMBus I801 adapter at 1880
Machine name:           PCG-GR214EP(FR)
Serial number:          2833XXXX-546XXXX

You can get even more information by running the decode-vaio.pl script.

I wrote and maintain that script, and am interested in how it works for
your laptop, so please let me know.

-- 
Jean Delvare
