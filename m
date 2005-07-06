From: ericb@aspsys.com (Eric J. Bowersox)
Date: Wed, 06 Jul 2005 17:41:01 +0000
Subject: [lm-sensors] W83792D & Overtemperature LED on Supermicro
Message-Id: <1120663033.22510.14.camel@wiz.dev.aspsys.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
In-Reply-To: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, Rudolf, sorry it's taken so long for a reply.

On Sat, 2005-07-02 at 10:37, Rudolf Marek wrote:
> Please can you dump content of the chip before you will load the driver and after you will load?
> (no sensors -s running)

Done.  Here's the results.

First dump:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 64 64 93 00 00 13 00 ff 00 00 05 00 00 b3    ..dd?..?....?..?
20: a8 a9 d1 bd 1e c7 d3 24 25 26 ff af 96 af 96 e2    ???????$%&.?????
30: b9 ce a8 2f 13 d9 b1 cc a7 50 4b ed ed ed 2e 93    ???/?????PK???.?
40: 03 00 20 9f 7f ff ff 33 2f 13 88 80 07 ff 80 5c    ?. ??..3/????.?\
50: ff ff ff ff ff ff ff ff 7a 30 ff 33 33 01 05 7f    ........z0.33???
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: ff 88 ff 88 0a 1e 1e 55 88 88 ff ff 00 00 0a 0a    .?.????U??....??
90: 36 36 00 01 8f ff 00 00 11 ff 3c 00 ff 01 01 ff    66.??...?.<..??.
a0: 01 01 01 8f 8f 8f 8f ff 3c 80 30 68 ff ff 00 00    ???????.<?0h....
b0: cf cc ff ff cc a7 e2 b9 ff ff ff ed ed ff ff ff    ??..????...??...
c0: 26 00 00 4b 00 50 00 ff 25 00 00 28 00 3c 00 ff    &..K.P..%..(.<..
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: af af 8b 3c 46 7f 3c 46 7f 28 3c 50 ff ff ff ff    ???<F?<F?(<P....
f0: ff ff 00 ff 00 01 00 00 ff 02 ff 00 00 00 00 ff    .....?...?......

Second dump:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 64 64 93 00 00 13 00 ff 00 00 05 00 00 b3    ..dd?..?....?..?
20: a9 a9 d2 be 1e c8 d3 2f 78 84 ff af 96 af 96 e2    ???????/x?.?????
30: b9 ce a8 2f 13 d9 b1 cc a7 50 4b ed ed ed 7e b6    ???/?????PK???~?
40: 01 80 30 00 00 ff ff 11 2f 13 03 80 07 ff 80 5c    ??0....?/????.?\
50: ff ff ff ff ff ff ff ff 7a 60 ff 11 11 01 05 7f    ........z`.?????
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
80: 01 8f 01 8f 00 00 00 00 11 11 ff ff 3c 3c 0a 0a    ????....??..<<??
90: 00 00 00 01 8f ff 00 00 11 ff 3c 20 00 01 01 ff    ...??...?.< .??.
a0: 01 01 01 8f 8f 8f 8f ff 3c 80 30 68 ff ff 00 00    ???????.<?0h....
b0: cf cc ff ff cc a7 e2 b9 ff ff ff ed ed ff ff ff    ??..????...??...
c0: 2f 80 00 4b 00 50 00 ff e1 80 00 28 00 3c 00 ff    /?.K.P..??.(.<..
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: 8b 8b 8b 28 3c 50 28 3c 50 28 3c 50 ff ff ff ff    ???(<P(<P(<P....
f0: ff ff 80 ff 00 01 00 00 ff 02 ff 00 00 00 00 ff    ..?..?...?......

> Also I would like to know which version of the driver did you used.
> Was it http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050621/8dfe2e28/patch_w83792d-2.6.12-0001.gz ?

Yes, that was it, except I had to make a few minor adjustments to the
driver file to get it to compile against the 2.6.5 kernel.  (Before you
ask, yes, we *have* to use that kernel version; the customer wants SuSE
Enterprise 9, and that's the most recent kernel version we have from
SuSE with all their patches and whatnot.)  In addition, I made a teeny
patch to the driver to change the dev_info() message that is logged
every time the driver polls the chip to a dev_dbg() message, since our
production engineer was concerned about the excessive log messages.  I
am attaching the patch as I modified it for 2.6.5, and the second patch
for the log messages (that works against either the 2.6.5 or 2.6.12
patches).

Thanks in advance for any help you can give here.

					Eric

-- 
Eric J. Bowersox, Software Engineer     Aspen Systems, Inc.
<ericb@aspsys.com>                      3900 Youngfield Street
Tel: +01 303 431 4606 x113              Wheat Ridge, CO  80033, USA
Fax: +01 303 431 7196                   <http://www.aspsys.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83792d-driver-2.6.5.patch.gz
Type: application/x-gzip
Size: 14369 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050706/3a674472/w83792d-driver-2.6.5.patch-0001.gz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83792d-driver-QUIET-2.6.x.patch.gz
Type: application/x-gzip
Size: 383 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050706/3a674472/w83792d-driver-QUIET-2.6.x.patch-0001.gz
