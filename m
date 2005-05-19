From: fako@freemail.hu (Holub Zoltan)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: bug?
Message-Id: <20040623220306.GA10703@terminal.dnsalias.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!!

I have two asus p5a-b motherboard.
The first one is Rev 1.03, the second one is Rev 1.04

In the bios i see the cpu and mobo temperature, it works fine.

I using kernel 2.6
This mobo needs ALI15X3 hw bus, and Winbond W83781D sensor chip driver.
With these drivers i see the sensors on sysfs.

The only difference is with rev 1.04 the i dont see the mobo
temperature value.
It show constantly -48 celsius. (bios shows correctly)
MB:        -48.0?C  (high =   +80?C, hyst =   +75?C)
With 1.03 mobo the mb temp is showed correcty.

The cpu temp, voltages and fan speed is showed correctly on the two mobos.

I am using same bios on the two mobos.

I tried with kernel 2.6.6 and 2.6.7.

Is it a sensors bug or something wrong with the mobo?

fako
