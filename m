From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 31 May 2005 10:49:51 +0000
Subject: [lm-sensors] SMSC LPC47M192 - "Device is disabled, will not use"
Message-Id: <429C2524.4020303@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <429A1930.6040409@gmail.com>
In-Reply-To: <429A1930.6040409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX 00 00    XXXXXXXXXXXXXX..
> 20: 00 00 00 00 31 c0 22 20 XX XX XX ff ff ff ff ff    ....1?" XXX.....
> 30: ff ff ff ff ff ff ff ff 7a fe ff XX XX XX 55 20    ........z?.XXXU

55 20 is really an SMSC LPC47M192

You tried smsc47m1, but:

The 47M15x and 47M192 chips contain a full 'hardware monitoring block'
in addition to the fan monitoring and control. The hardware monitoring
block is not supported by the driver.

Good news is that Tomas Holmqvist is working on that.

Tomas any progress on this?

Thanks,
Regards

Rudolf
