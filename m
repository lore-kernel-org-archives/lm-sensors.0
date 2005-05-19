From: guillaume@apostoly.com (Guillaume APOSTOLY)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: lm_sensor on a Netvista
Message-Id: <MEEOLGLAMCNGBPBBBFHOCEGOCDAA.guillaume@apostoly.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

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
Name: APOSTOLY Guillaume.29860DEFANGED-vcf
Type: application/octet-stream
Size: 144 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20021121/e9334933/APOSTOLYGuillaume.obj
