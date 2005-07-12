From: marcelo@feitoza.com.br (Marcelo Feitoza Parisi)
Date: Tue, 12 Jul 2005 01:20:53 +0000
Subject: [lm-sensors] Patches Doubt
Message-Id: <42D2FDEF.6020504@feitoza.com.br>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there, I did not signed the list. Actually I am developing some
patches do kernel-janitors, and I run into a doubt.
I used only time_after() macro, but I was looking better to my patches
and I've found that maybe it would introduce bugs. I was thinking if it
is necessary to use time_after and time_before together, or something
like time_between.

Thank You
-- 
Marcelo Feitoza Parisi
marcelo@feitoza.com.br
http://marcelo.feitoza.com.br/
Key ID: 0x42A42C9A / Signed on: 25-04-2005 18:59
Key fingerprint: ADDE EEE7 57D9 FB45 2605 5A03 54DA 3079 42A4 2C9A
Key: http://marcelo.feitoza.com.br/GnuPG/chave_publica.asc
-------------- next part --------------
A non-text attachment was scrubbed...
Name: atxp1.patch
Type: text/x-patch
Size: 762 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050711/384b0dc4/atxp1.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fscpos.patch
Type: text/x-patch
Size: 662 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050711/384b0dc4/fscpos.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: gl520sm.patch
Type: text/x-patch
Size: 710 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050711/384b0dc4/gl520sm.bin
