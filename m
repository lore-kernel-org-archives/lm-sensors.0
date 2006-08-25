From: prakash@punnoor.de (Prakash Punnoor)
Date: Fri, 25 Aug 2006 05:21:42 +0000
Subject: [lm-sensors] Asus M2NPV-VM and lm-sensors not working
Message-Id: <200608250721.45753.prakash@punnoor.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200608241001.14052.prakash@punnoor.de>
In-Reply-To: <200608241001.14052.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Donnerstag 24 August 2006 17:09 schrieb Jean Delvare:
> Please report your results!

Hi, I chekced with my bios and the temps reading seems OK, but fans are off:

CPU: 780
POWER: 777

wheres sensors reports too high values
fan1:     1323 RPM  (min = 6490 RPM)                   ALARM
fan2:        0 RPM  (min = 6490 RPM)                   ALARM
fan3:     1564 RPM  (min =    0 RPM)

Sometimes the reading goes totally crazy. I had times, where fan1 showed 
values over 32000.

fan1:     46551 RPM  (min = 6490 RPM)                   ALARM
fan2:        0 RPM  (min = 6490 RPM)                   ALARM
fan3:     1551 RPM  (min =    0 RPM)

Cheers,
-- 
(?=                 =?)
//\ Prakash Punnoor /\\
V_/                 \_V
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060825/e6e95cbc/attachment.bin 
