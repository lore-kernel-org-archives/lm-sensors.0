From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: /usr vs /usr/local
Message-Id: <20030815221829.0f870e63.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Axel,

A suggestion for the next time you package the sensors userspace tools.
In sensors-detect, we suggest the user should run
"/usr/local/bin/sensors -s". You should change that to "/usr/bin/sensors
-s" since that's where you install that program. Could confuse the
users...

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
