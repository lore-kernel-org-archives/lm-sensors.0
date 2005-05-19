From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Unresolved Symbols question lm_sensors 2.8.0/i2c 2.8.0/linux
Message-Id: <20031002223722.34675578.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F7B83FF.2060409@yml.com>
In-Reply-To: <3F7B83FF.2060409@yml.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I am getting an unresolved symbol (dmi_scan_match) trying to install 
> lm_sensors 2.8.0 and i2c 2.8.0 under stock RedHat Linux 9.0 install.

This symbol is exported by the dmi_scan module, which ships with
lm_sensors. Don't you have it? You really should, if you were able to
compile i2c-piix4.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
