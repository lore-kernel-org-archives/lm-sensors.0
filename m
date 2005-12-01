From: a_titov82@mail.ru (Alexey Titov)
Date: Thu, 01 Dec 2005 16:26:43 +0000
Subject: [lm-sensors] Ticket #2103
Message-Id: <op.s032q7i7n40jst@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <op.s0t5dwepn40jst@localhost.localdomain>
In-Reply-To: <op.s0t5dwepn40jst@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> What version of lm_sensors are you really using? We can't help you if
> you provide inaccurate information.
Well.. Now I'm using lm_sensors-2.8.8-5. Perhaps, I used lm_sensors 2.9.2  
when I wrote the ticket...

> Did the it87 driver ever work properly for you with another kernel?
I built my own kernel, but there was the same problem.

> How are you loading it? Manually, or through some script?
I load it manually, using "modprobe it87". It was wrote in sensors-detect  
output.
Maybe I should pass some parameters to the module?

> Please provide the output of "isadump 0x805 0x806" before loading the  
> it87 driver.
Here is the output. Driver was not loaded.

isadump 0x805 0x806
WARNING! Running this program can cause system crashes, data loss and  
worse!
I will probe address register 0x805 and data register 0x806.
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 13 01 ff 00 ff ff 00 ff ff ff 00 09 00 fb ff ff
10: 00 ff ff 11 b0 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 7f 2f 2f 2f 00 00 00 00
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: 4c 4b 55 50 48 3e 00 00 2d 00 00 00 00 00 00 00
50: 00 07 7f 7f 7f 00 00 00 90 69 00 00 00 00 00 00
60: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
70: 7f 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00
80: 13 00 00 00 ff ff 00 ff ff ff 00 09 00 fb ff ff
90: 00 ff ff 11 b0 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 7f 2f 2f 2f 00 00 00 00
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: 4c 4b 55 50 48 3e 00 00 2d 00 00 00 00 00 00 00
d0: 00 07 7f 7f 7f 00 00 00 90 69 00 00 00 00 00 00
e0: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
f0: 7f 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00


Thank you for answer.
