From: Holger.Kiehl@dwd.de (Holger Kiehl)
Date: Mon, 05 Feb 2007 15:44:29 +0000
Subject: [lm-sensors] LM85 problems with 2.6.16.x - 2.6.19.1
Message-Id: <Pine.LNX.4.64.0702051535290.28290@diagnostix.dwd.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0702051500420.28290@diagnostix.dwd.de>
In-Reply-To: <Pine.LNX.4.64.0702051500420.28290@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 5 Feb 2007, Philip Pokorny wrote:

> Can you send all of the 'lm85' lines from dmesg (ie dmesg | grep lm85) to the list.  I would like to confirm which chip was detected.  We may also need 'i2cdump 0 0x2e'
>
dmesg | grep lm85 is not possible because the system is running for a long
time. But doing this on /var/log/messages just provides the following:

    messages.1:Sep 14 12:35:01 athena kernel: lm85 0-002e: Client (0,0x2e) config is locked.
    messages.1:Sep 14 12:35:01 athena kernel: lm85 0-002e: Client (0,0x2e) is not ready.
    messages.1:Sep 14 12:35:01 athena kernel: lm85 0-002e: Client (0,0x2e) VxI mode is set.  Please report this to the lm85 maintainer.
    messages.1:Sep 21 10:37:04 athena kernel: lm85 0-002e: Client (0,0x2e) config is locked.
    messages.1:Sep 21 10:37:04 athena kernel: lm85 0-002e: Client (0,0x2e) is not ready.
    messages.1:Sep 21 10:37:04 athena kernel: lm85 0-002e: Client (0,0x2e) VxI mode is set.  Please report this to the lm85 maintainer.
    messages.1:Sep 25 10:38:38 athena kernel: lm85 0-002e: Client (0,0x2e) config is locked.
    messages.1:Sep 25 10:38:38 athena kernel: lm85 0-002e: Client (0,0x2e) is not ready.
    messages.1:Sep 25 10:38:38 athena kernel: lm85 0-002e: Client (0,0x2e) VxI mode is set.  Please report this to the lm85 maintainer.
    messages.1:Oct 30 10:17:41 athena kernel: lm85 0-002e: Client (0,0x2e) config is locked.
    messages.1:Oct 30 10:17:41 athena kernel: lm85 0-002e: Client (0,0x2e) is not ready.
    messages.1:Oct 30 10:17:41 athena kernel: lm85 0-002e: Client (0,0x2e) VxI mode is set.  Please report this to the lm85 maintainer.
    messages.1:Oct 30 10:29:52 athena kernel: lm85 0-002e: Client (0,0x2e) config is locked.
    messages.1:Oct 30 10:29:52 athena kernel: lm85 0-002e: Client (0,0x2e) is not ready.
    messages.1:Oct 30 10:29:52 athena kernel: lm85 0-002e: Client (0,0x2e) VxI mode is set.  Please report this to the lm85 maintainer.
    messages.1:Nov 22 10:03:03 athena kernel: lm85 0-002e: Client (0,0x2e) config is locked.
    messages.1:Nov 22 10:03:03 athena kernel: lm85 0-002e: Client (0,0x2e) is not ready.
    messages.1:Nov 22 10:03:03 athena kernel: lm85 0-002e: Client (0,0x2e) VxI mode is set.  Please report this to the lm85 maintainer.

I just notice that an identical system which has the same problems does not
show the line "lm85 0-002e: Client (0,0x2e) is not ready", ie:

      lm85 0-002e: Client (0,0x2e) config is locked.
      lm85 0-002e: Client (0,0x2e) VxI mode is set. Please report this to the lm85 maintainer.

Here the i2cdump you asked:

    i2cdump 0 0x2e
    No size specified (using byte-data access)
    WARNING! This program can confuse your I2C bus, cause data loss and worse!
    I will probe file /dev/i2c-0, address 0x2e, mode byte
    Continue? [Y/n] y
         0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
    00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
    10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
    20: 5e 69 c0 c0 c1 4a 1e 46 38 03 e8 03 34 03 e1 03    ^i???J?F8???4???
    30: ff ff ff 00 00 00 00 00 00 00 00 00 00 27 41 60    .............'A`
    40: fe 00 00 0e 6d 79 7a 86 b6 ca b6 ca b6 ca 81 7f    ?..?myz?????????
    50: 81 7f 81 7f ff ff ff ff ff ff ff ff 62 62 62 c4    ????........bbb?
    60: c4 c4 00 00 80 80 80 5a 5a 5a 64 64 64 44 40 00    ??..???ZZZdddD at .
    70: 28 00 28 00 00 00 8b 4c f8 00 00 97 00 00 00 00    (.(...?L?..?....
    80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
    90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
    a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
    b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
    c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
    d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
    e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
    f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

Thanks, for the quick responce!

Regards,
Holger


