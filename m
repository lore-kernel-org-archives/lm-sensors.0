From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: new ibm detector
Message-Id: <20021108175315.5d00b7f2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Pam,

Would you have some time left to try the new IBM-detection method I
incorporated into sensors-detect yesterday?

If yes, either checkout our CVS tree, or just grab the two files needed:
http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/prog/detect/dmidecode.c
http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/prog/detect/sensors-detect
I think you already have a recent dmidecode, but I'd prefer that you use
exactly the one we distribute, just to make sure.

Just compile dmidecode (gcc -Wall dmidecode.c -o
/usr/local/sbin/dmidecode) and run ./sensors-detect. If the new code
works as intended, it shouldn't let you continue. It should warn you and
exit.

Thanks

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
