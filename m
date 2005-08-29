From: knefas@gmail.com (Knefas)
Date: Mon, 29 Aug 2005 19:35:47 +0000
Subject: [lm-sensors] VGN-S4
Message-Id: <43136363.5050507@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,
I have a sony vaio VGN-S4 and lm_sensors doens't recognize any hardware 
sensor. I've seen that in 2.9.2

Program sensors: Support the VAIO "VGN" prefix for eeprom

I hope this will support my eeprom too. I'm quite a noob on programming things, but I'd like to help out as much as I can, so please tell me what to do to check if my eeprom will be supported by that release or what tests do you need to be able to support it.

~ # i2cdump 0 0x57 
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c/0, address 0x57, mode byte
Continue? [Y/n] Y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: c2 ee 68 d6 66 00 00 c2 ee 68 d6 66 00 00 ff ff    ??h?f..??h?f....
10: 6a 89 75 60 a4 ee 11 d8 81 28 00 01 4a 82 65 94    j?u`?????(.?J?e?
20: 4a 50 42 4c 2d 30 30 31 35 35 30 00 00 00 00 00    JPBL-001550.....
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 56 47 4e 2d 53 34 4d 5f 53 00 00 00 00 00 00 00    VGN-S4M_S.......
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 4a 30 30 30 55 47 44 5a 00 00 36 47 31 4d 00 00    J000UGDZ..6G1M..
b0: 00 00 a2 1f 63 2a 54 a4 14 13 00 00 02 05 05 00    ..??c*T???..???.
c0: 32 38 31 39 38 31 36 37 2d 35 36 35 30 36 31 31    28198167-5650611
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 30 35 2f 32 30 2f 30 35 20 31 35 3a 32 32 3a 35    05/20/05 15:22:5
f0: 31 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00    1...........?...

IDK if this can help. :-)

Regards

Pietro

