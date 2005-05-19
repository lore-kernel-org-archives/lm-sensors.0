From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: lm_sensors2/prog/sensors chips.c
Message-Id: <20021128172256.1841b834.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Update of /home/cvs/lm_sensors2/prog/sensors
> In directory
> mordac.netroedge.com:/tmp/cvs-serv11026/lm_sensors2/prog/sensors
> 
> Modified Files:
> 	chips.c 
> Log Message:
> (Khali) Fix Vaio EEPROM misdetection

The changes I had first made to support Vaio eeproms was assuming that
everything that isn't a memory chip eeprom was a Vaio eeprom. This is
now fixed (should avoid problems with dccmon and maybe Xeons) by
ensuring that we have a real Vaio eeprom. If it doesn't pass the test,
no information is displayed.

BTW, what is ddcmon supposed to do? I have a video card supporting this,
the driver loads, but doesn't create any entry in /proc.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
