From: starless@spin.it (Marco De Vitis)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: Ticket 1506: ASB100
Message-Id: <1338151684.20040108171517@spin.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
I've read ticket 1506 on the sensors support page, "asb100 isn?t
detected on a7v333", and that's why I'm following up via email, as
suggested in the ticket answer. This address is mentioned as a mailing
list but uhm, I didn't find a way to actually subcribe...

I have the same problem on an Asus P4PE; according to the lm_sensors
2.8.2 release notes I thought ASB100 was fully supported (is that
right?), but sensors-detect fails to recognize it on my system
(Mandrake 9.0, kernel 2.4.19-35mdk).

"i2cdetect -v" returns versions 2.8.2, so I suppose I do not have old
stuff around.

Any clues? Or maybe for P4PE I should still use the fix suggested for
tickets 1108 and 1124?
Thanks.

-- 
Ciao,
  Marco.

.."Relayer", Yes 1974
