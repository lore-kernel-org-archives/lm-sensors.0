From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: SAA1064 in libsensors?
Message-Id: <20030717203251.70350048.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307171943.10501.sascha@akv-soft.de>
In-Reply-To: <200307171943.10501.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have one more question while going through your new_drivers
> checklist. Do you want libsensors support for the saa1064 chipdriver?
> I wouldn't think this is necessary, since it's no real sensor chip
> (like the pcf8574, which isn't present in libsensors either).

There are other non-sensor chip drivers that are supported by
libsensors, for example eeprom and ddcmon. So in a way you are free to
include it or not. However, the saa1064 is a driver that you will use to
mostly *write* data, not read as most other drivers. It's similar in
spirit to the matorb driver (and the pcf8574 and pcf8591 also). So
supporting it in libsensors may make no sense, you are right.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
