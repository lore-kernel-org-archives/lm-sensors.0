From: amalysh@web.de (Alexander Malysh)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: SIS 630
Message-Id: <200208200025.46557.amalysh@web.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

i implemented "initial" version of smbus support for sis 630 chip.It's based 
on supported sis5595 smbus. It work and tested on my Laptop based on sis 630 
chip (Clevo/Kapok 2700C). Any questions and comments are welcome. 
Here is it.

P.S. If needed i have sis630 datasheet at http://amalysh.bei.t-online.de/docs

-- 
MfG,
Dipl.-Ing. Alexander Malysh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-sis630.c
Type: text/x-csrc
Size: 10101 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020820/b81b0502/i2c-sis630.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-id.h.diff
Type: text/x-diff
Size: 351 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020820/b81b0502/i2c-id.h.bin
