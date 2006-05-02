From: dieter.jurzitza@t-online.de (Dieter Jurzitza)
Date: Tue, 02 May 2006 19:28:10 +0000
Subject: [lm-sensors] latest findings - my older posting from ~ 11 days ago
Message-Id: <200605022128.10627.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Rudolf,
dear listmembers,
after having configured the debugging nothing bad had happened - but I readily 
knew that could happen so I was patient.
Today returning from home the problem had had reappeared:

Please see file attached. You will find a "SMBus collision", and, after that, 
"sensors" is dead.

So, I added several lines on top in order to (possibly ...) help who 
understands what is happening here.

This time the module loaded are:
i2c-amd75, i2c-isa, w83781d and eeprom

Let me know how to proceed, thank you in advance, take care



Dieter

P.S. please see the excerpt of a messages file attached. I bzip2-ed it in 
order to save space.

-- 
-----------------------------------------------------------

                               |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <??__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------
-------------- next part --------------
A non-text attachment was scrubbed...
Name: collision.bz2
Type: application/x-bzip2
Size: 1407 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060502/c8bd81a2/collision.bz2
