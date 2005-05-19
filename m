From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: W83627THF and fan speed
Message-Id: <1081239576.40726818151b8@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <40721FE7.40504@bigpond.com>
In-Reply-To: <40721FE7.40504@bigpond.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've just upgraded to 2.6.5 and saw that it has a driver for the
> Winbond W83627THF. Now I get some sensor values. Thanks.

You're welcome.

> My temperature and voltage readings look ok, and are a good match for
> the values reported by the BIOS. However, my fan values are all 0 
> whereas the BIOS reports them generally in the range 1000-2500 rpm.

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section%204.1

"4.1.1 Fans sometimes/always read 0!!

You may need to increase the 'fan divisor'. See doc/fan-divisors in our
package for further information."

Set divisors to 4 or even 8 and you should get the readings. This is
done by adding lines of the form "set fan1_div 4" in the "w83627thf-*"
section of /etc/sensors.conf, and running "sensors -s" to apply the
changes.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
