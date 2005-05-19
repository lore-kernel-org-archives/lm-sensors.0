From: guillaume@apostoly.com (Guillaume APOSTOLY)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: TR: lm_sensor on a Netvista
Message-Id: <MEEOLGLAMCNGBPBBBFHOOEGOCDAA.guillaume@apostoly.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Daniel,

I'm a (fanatic) user of gentoo, currenly on a 1.4 with the latest 2.4.20 mjc kernel. I've added the kernel and userspace modules
associated with lm_sensors. I've got an IBM P4 1.6G Netvista.

When launching "sensors-detect", i had this answer :
"System vendor: IBM
 Sorry, we won't let you go on. IBM systems are known to have serious
 problems with lm_sensors, resulting in hardware failures."

So I went on the lm_sensors page (http://secure.netroedge.com/~lm78/docs.html) and found out why this (good) protection was done :
there can be system failure due to a specific eeprom that  can be found on thinkpad IBM and which make your system unbootable:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/README.thinkpad

The makers of lm_sensors so put this security, to avoid people with IBM thinkpad to break down there system (good thing !).

I found this article where you speak about lm_sensors and I wonder so, if you achieved this on an IBM computer.
http://www-900.ibm.com/developerWorks/cn/linux/hardware/stability/index_eng.shtml

Also, because I know that IBM is pretty involved in the gentoo distribution, I wonder if you can be of any help for people at
lm_sensors to :
- help them identify more precisely what computer is suitable for lm_sensors (maybe there's no problem with mine, by example)
- eventually help them build a fix that make it work also on Thinkpad like computers.

I don't know what are your relations with IBM, but maybe you can put them in touch with the needed people at IBM.

Below is the e-mail i've sent to the lm_sensors support.

If i can be of any help, just let me know.

Regards,

Guillaume.

-----Message d'origine-----
De : Guillaume APOSTOLY [mailto:guillaume@apostoly.com]
Envoy? : jeudi 21 novembre 2002 15:16
? : sensors@stimpy.netroedge.com
Objet : lm_sensor on a Netvista


Hi,

I'm on a gentoo 1.4, with gcc 3.2 and a 2.4.20 kernel. I've added the I2C/lm_sensor kernel module and installed lm_sensor and ...
had the surprise, that "I've got an IBM and we don't go any further".
I've read the documentation, and understand why !! Still, i've got a NetVista A20 (basically a tower, P4 system).
So i've got several questions :
1/ are your sure that lm_sensors only mess up with 24RF08 eprom system ?

2/ if so, can I check if my computer as got this eprom, with a "cat /proc/something" or else, and so take an older version with
doesn't do the machine check and install lm_sensors ?

3/ I read in the documentation that :
"IBM Thinkpads contain a proprietary Embedded Controller which
   is used to access sensors. This controller is not on the SMBus,
   and IBM will not release the programming interface to the
   controller. So lm_sensors isn't useful on Thinkpads anyway."
What is that device, and is there a way to use it under linux ?

4/ is IBM aware of the problem, and do they want to make something for that ? I know that IBM is pretty involved in the Gentoo
distribution, so maybe that way, contacting the package maintener for gentoo lm_sensor we could achieve something

5/ is their a SAFE way, to safe that eprom information and make tries with lm_sensors ? I mean, if I try lm_sensor, and that break
my machine because of this eprom, what way have I got to fix it, and get a working system back ???

I'm ready to do testings, if you want, and if you've got ways to fix my machine if broken ! (if  just the system is messed up, I
don't care, it's a home, development and test machine).
Thanks by advance, i'm particularly keen of an answer to the 2/ question.

Regards,

Guillaume.

---------------------------------------------------
Guillaume APOSTOLY
   Ing?nieur d'affaires
        tel : +33 1 45 38 00 60
        gsm : 06 84 50 81 08

   CVF
   www.cvf.fr
   Tour Maine Montparnasse
   BP 8 - 33, avenue du Maine
   75755 Paris Cedex 15
   Fax : +33 1 45 38 00 01
---------------------------------------------------
-------------- next part --------------
A non-text attachment was scrubbed...
Name: APOSTOLY Guillaume.3090DEFANGED-vcf
Type: application/octet-stream
Size: 144 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20021121/9a179ac4/APOSTOLYGuillaume.obj
