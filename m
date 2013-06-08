From: Avrel Vor <avrel.vor@orange.fr>
Date: Sat, 08 Jun 2013 12:55:53 +0000
Subject: [lm-sensors] Missing Fintek F71868AD chip
Message-Id: <51B329D9.30802@orange.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

The mother board MSI FM2-A55M-E33 includes a Super I/O chip Fintek F71868AD.
So far it is not recognised by sensors-detect :
"
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found unknown chip with ID 0x1106
"
Is it possible to test a modification of the script to force the use of 
the driver "f71882gf" with this ID ?
I am afraid of the risk of damaging the mother board...

Thanks for an answer.
Avrel


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
