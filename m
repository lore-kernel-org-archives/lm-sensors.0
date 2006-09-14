From: david.c.hubbard@gmail.com (David Hubbard)
Date: Thu, 14 Sep 2006 05:26:58 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and minor problems w/
Message-Id: <4dfa50520609132226p3da777caj195ed1976567eac9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1157458671.18988.34.camel@mhcln03>
In-Reply-To: <1157458671.18988.34.camel@mhcln03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> Odd, this register is supposed to be writable. Can you please try other
> values (e.g. 0xa4) to see if other bits in the register can be written?
>
> You may also try writing to register 0x48, we don't care about the
> value there and it'll be an interesting test.
>
> Pin 58 is shared between two functions, SI and AUXFANIN1. Your problem
> might have something to do with this, but I can't find information
> about function selection for this pin in the datasheet.
>
> David, any idea?

There's been a lot going on around here, so sorry for the delay. I
looked at the datasheet to see how pin 58 is configured. SI (serial
flash input) and AUXFANIN1 are affected by two registers:

1. register 47h: force AUXFANIN1 to act as a fan output
2. CR[0x24] bit 1. ENROM. The datasheet says a hardware reset is necessary.

My guess is that the serial flash interface is set by default. I think
there's a way to reset the w83627ehf chip by writing to certain ports.
What do you think, Jean?

David

P.S. Working on an updated w83627dhg patch!

