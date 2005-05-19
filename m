From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: More flash eeprom fun on a Thinkpad
Message-Id: <20020722220522.4cd9a8a1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020721144141.C11600@Stimpy.netroedge.com>
In-Reply-To: <20020721144141.C11600@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> BTW-Did you try dumping the contents of the 0x57 to see what was in
> it?

Of course I did, some times ago. The eeprom contains information about
the laptop such as model and serial number, but there are still data I'm
not able to interpret. I asked Sony for information but they told me to
go to hell (I still got the mails if you want details). See my script
lm_sensors2/prog/eeprom/decode-vaio.pl if you are interested.

BTW testers are still wanted for this script, preferably before I start
updating sensors-detect and sensors to support Vaio eeproms. Nobody with
a Vaio laptop around willing to help?

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
