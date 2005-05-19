From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: support for p4s8x motherboard
Message-Id: <20030629145652.484fbac2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EFA15C6.5020503@cadesis.com>
In-Reply-To: <3EFA15C6.5020503@cadesis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Only a reboot stop the beep sequence.

Does "echo 0 > /proc/sys/dev/sensors/as99127f-i2c-0-2d/beep" make the
machine quieter?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
