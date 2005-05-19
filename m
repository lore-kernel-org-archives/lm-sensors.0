From: cezarym@pf.pl (Cezary Morga)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: lm_sensors ain't updating cpu temp
Message-Id: <1094053866.11195.33.camel@84.xa.interkam.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1093792983.3809.5.camel@84.xa.interkam.pl>
In-Reply-To: <1093792983.3809.5.camel@84.xa.interkam.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

W li?cie z pon, 30-08-2004, godz. 18:44, Jean Delvare pisze: 
> > what should I look for?
> 
> Any line with "i2c" or "w83781d" or "w83697hf" is a good candidate. If
> you see any line with either word which sounds like an error, report to
> us.

Nothing about w83781d or w83697hf. On i2c I found only :
i2c /dev entries dirver (in dmesg, messages and syslog) and
Loading module: i2c-dev (in messages and syslog).

> Things to try:
> 
> 1* Cycle the w83781d driver (as root):
> $ rmmod w83781d
> $ modprobe w83781d
> And see if temp2 changes.

Did not help.

> 2* Try to pass init=0 to the w83781d module:
> In the file /etc/modprobe.conf, add the following line:
> options w83781d init=0
> I just hope that this file is not generated from other files on your
> system. If it is, you'll have to find out which files this one is
> generated from, and edit one of them instead.
> Then reboot your computer and see if it helps.
> 
> I can't remember a similar report so far (by my memory is rather weak).

Did not help.
-- 
Cezary Morga <cezarym@pf.pl>
Registered Linux User No. 362185 <http://counter.li.org>
GG# 169903 ICQ# 328-700-565 Jabber: thereidos@ebox.pl
