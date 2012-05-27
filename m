From: sebl@storm-clan.de
Date: Sun, 27 May 2012 21:39:23 +0000
Subject: [lm-sensors] Problems with SMSC EMC2103-2
Message-Id: <3652e486e75012b50617cd207d9ce279.squirrel@webmail.storm-clan.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

somehow lm-sensors does not seem to recognize the EMC2103-2 chip in my
notebook (HP 2530p). When i run sensors-detect it says:

#Do you want to scan for Super I/O sensors? (YES/no): y
#Probing for Super-I/O at 0x2e/0x2f
#Trying family `National Semiconductor/ITE'... No
!#Trying family `SMSC'... Yes
!#Found unknown chip with ID 0x4501
#Probing for Super-I/O at 0x4e/0x4f
#Trying family `National Semiconductor/ITE'... No
#Trying family `SMSC'... No
#Trying family `VIA/Winbond/Nuvoton/Fintek'... No
#Trying family `ITE'... No

"Found unknown chip with ID 0x4501" But I'm 100% certain that it is the
EMC2103-2 chip which is described as support in the documentation. I can
load the driver with modprobe emc2103, but nothing happens. lm-sensors
only detects the temperature-sensors correctly, not the fan speed or
anything else. Are there known problems with this chip? Or is somenone
successfully running lm-sensors with EMC2103-2?

sensors -v
sensors version 3.3.2 with libsensors version 3.3.2

uname -r
3.2.0-24-generic-phc

best regards





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
