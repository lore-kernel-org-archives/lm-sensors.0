From: max@semandex.net (Maximilian Ott)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: Address problems with 'i2cset'
Message-Id: <200501250306.j0P36PKW029120@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have a I2C chip with address 0xC0 and when I try to issue:

% i2cset 0 0xC0 0x44 0x55

It complaints about "wrong address", or something similar (sorry I don't
have the system available right now). Is this some safety check to protect
the clueless (certainly qualify for that).

Thanks,

-max
