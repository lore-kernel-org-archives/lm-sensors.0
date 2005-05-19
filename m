From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: ticket# 1650 - ERROR: Can__t get TEMP1 data!
Message-Id: <1082040645.407ea145eedf3@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've tested intermediate versions and the problems
> seem to start from 2.8.3 onwards.

There has been an interface change for it87 temperatures in January
2004, I think that this is what causes the trouble.

Please search your system for all installed libsensors library files (in
/usr/lib and /usr/local/lib, and sensors binaries (in /usr/bin and
/usr/local/bin). Remove all old libraries and all old binaries, only
keeping the latest sensors and libsensors from lm_sensors 2.8.6. It
should work after that. I suspect that there is an older library (which
doesn't know about the interface change) in sensors' way, causing
temperature information retrieval to fail.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
