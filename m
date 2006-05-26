From: harald.dunkel@t-online.de (Harald Dunkel)
Date: Fri, 26 May 2006 19:02:39 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <447750CF.80304@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <446DF157.80805@t-online.de>
In-Reply-To: <446DF157.80805@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I've got some very first version, reading temperatures, fan speeds,
and voltage. See attachment. (Hopefully it is OK to post it here?)

Except that the values it reports don't match the values shown
in the bios. The temperatures shown in the bios are about 4 degrees
higher (53 to 54 degree Celsius), the voltages don't match, and the
fan speeds are completely mad:

% cat /sys/bus/i2c/devices/0-002d/fan?_input
471
4094
% cat /sys/bus/i2c/devices/0-002d/temp?_input
49125
49125
40250
% cat /sys/bus/i2c/devices/0-002d/in?_input
1576
912
1008
1016

If I compare this to the output of i2cdump, then I don't see a
difference. AFAICS the /sys entries and the registers match.

Any idea? Is it possible that the datasheet is not correct?


Regards

Harri

-------------- next part --------------
A non-text attachment was scrubbed...
Name: f75387.c
Type: text/x-csrc
Size: 15096 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060526/935fe4c6/f75387-0001.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 252 bytes
Desc: OpenPGP digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060526/935fe4c6/signature-0001.bin
