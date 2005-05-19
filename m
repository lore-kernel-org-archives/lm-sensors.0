From: dhoffman_98@yahoo.com (David Hoffman)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <20050209171134.5101.qmail@web50709.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,
Do you use any instant message programs? I have Yahoo Messenger, MSN
Messenger, and AIM, and it might be easier to communicate instead of
waiting for e-mails.

Well, I can look at the motherboard and actually see the Winbond chip
right there on the board. It has the winbond logo and the number on it
is W83627EHF-A.

I didn't notice the "-A" before, but I'm not sure if that means
anything.

I have gone into my BIOS settings and looked at the hardware monitor
and here are some of the settings it monitors:
--------------
CPU Temp
MB Temp
CPU Q-Fan Control
CPU Q-Fan Mode
CPU Fan Ratio
CPU Target Temperature
CPU Fan Speed
Chassis Fan Speed
Vcore Voltage
3.3V Voltage
5V Voltage
12V Voltage
--------------

The Q-fan thing is specific to Asus and can automatically turn fan
speeds up and down depending on temperatures.

Here is the output from "isadump 0x295 0x296":
WARNING! Running this program can cause system crashes, data loss and
worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n] Y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 bf 04 c8 11 00 47 30 01 c8 01 c8 3c 3c 01 0a
10: 01 00 10 00 00 01 01 3c 43 00 ff ff 24 32 00 e3
20: a0 e6 cd cc ff cb 89 29 ff d3 ff e7 00 00 00 00
30: 10 00 00 00 0c 03 00 00 00 04 00 00 40 40 01 ff
40: 03 de 2f de ff 00 03 74 2d 44 01 c4 18 95 06 a3
50: e4 1f 59 96 3a 39 3d 3d e4 1f 59 96 3a 39 3d 3d
60: a0 e6 cd cc ff cb 89 29 ff d3 ff e7 00 00 00 00
70: 10 00 00 00 0c 03 00 00 00 04 00 00 40 40 01 ff
80: 01 bf 04 c8 11 00 47 30 01 c8 01 c8 3c 3c 01 0a
90: 01 00 10 00 00 01 01 3c 43 00 ff ff 24 32 00 e3
a0: a0 e6 cd cc ff cb 89 29 ff d3 ff e7 00 00 00 00
b0: 10 00 00 00 0c 03 00 00 00 04 00 00 40 40 01 ff
c0: 03 00 00 de ff 00 03 74 2d 44 01 c4 18 95 06 a3
d0: e4 1f 59 96 3a 39 3d 3d e4 1f 59 96 3a 39 3d 3d
e0: a0 e6 cd cc ff cb 89 29 ff d3 ff e7 00 00 00 00
f0: 10 00 00 00 0c 03 00 00 00 04 00 00 40 40 01 ff




--- Jean Delvare <khali@linux-fr.org> wrote:

> 
> Hi David,
> 
> > SUCCESS! Here is the latest output:
> > (...)
> > Probing for `Winbond W83627EHF Super IO Sensors'
> >   Success... found at address 0x0290
> 
> Great. This is half a success only though, since it confirms the
> address
> 0x290, where the ISA device was *not* properly detected.
> 
> Can you please provide the output of "isadump 0x295 0x296"? Maybe
> there
> is yet another inaccuracy in the datasheet.
> 
> Are you 100% sure that this is a W83627EHF chip you have? ;)
> 
> Thanks,
> --
> Jean Delvare
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
