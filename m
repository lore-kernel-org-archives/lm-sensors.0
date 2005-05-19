From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: loading rivatv is slow
Message-Id: <20030718152351.1dcbd333.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi folks,

(I have been lurking on your IRC channel for days now, but it seems it
isn't very active. Hope I'll have more luck here.)

I noticed that the rivatv module is slow loading when the monitor
plugged on my videocard does not support DDC/I2C. Why that? Are you
sending I2C commands at module init?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
