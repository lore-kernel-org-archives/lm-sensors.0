From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Gnome hangs after sensors installation
Message-Id: <20030731181838.080dc6d2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BB4EE262.6D4C%zdavatz@ywesee.com>
In-Reply-To: <BB4EE262.6D4C%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Everything else is gone...
> 
> Any hints?

Run "depmod -a", and reboot. I hope everything will get back after that.

I really don't understand how just installing lm_sensors could cause
such a mess. If you can figure out, please let us know.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
