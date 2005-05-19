From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Linux 2.6.3, lm_sensors 2.8.5
Message-Id: <20040218232559.2621d402.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Linux 2.6.3 is out. We want to release lm_sensors 2.8.5, don't we?

I know this is only two weeks since the last release, but I am not
responsible for the very short cycle of Linux 2.6.3. And it happens that
the w83l785ts driver in Linux 2.6.3 isn't compatible with libsensors
from lm_sensors 2.8.4. There may be other compatibility issues, but this
is the main one I can think of.

So, according to Greg's theory, we should release a new version of
lm_sensors, numbered 2.8.5. OTOH, we probably don't want to release i2c
2.8.5 with an empty change list.

I propose to set the deadline to Friday, February 20th, 2004.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
