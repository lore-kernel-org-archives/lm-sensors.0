From: Thomas Roos <thomas@roosesweb.de>
Date: Wed, 29 Jul 2015 07:35:57 +0000
Subject: [lm-sensors] external binary tool or lib / Smart Embedded Management Agent - ADLINK Technology
Message-Id: <CAAVZOXu=83X+iEG7QMZg_f_f=JKJvNZM3t9H8TPSuzv21OY1Sw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,
i use a Bay Trail E3825 ETX module. Problem is that the 5V is not
connected to the Winbond w83627dhg chip. It's only available via SEMA
(Smart Embedded Management Agent - ADLINK Technology link:
http://www.adlinktech.com/PD/web/PD_detail.php?pid42# ). A binary
tool or library.
But I want to use the 5V measurement value in lm-sensors environment
(alarming, range).
Can you give me any advice how to solve this?
I was thinking of writing a kernel module, but I think it's a bit oversized.
Is there any possibility to get values from tools or libs without a
bus, chip into lm-sensors?
THANK YOU FOR ANY ADVICE!
cheers, Thomas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
