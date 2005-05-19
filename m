From: ffl@aber.ac.uk (Fred Labrosse)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Reading a compass CMPS03
Message-Id: <16497.36105.698488.112954@aber.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <16497.19215.209434.328945@aber.ac.uk>
In-Reply-To: <16497.19215.209434.328945@aber.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare writes:
 > 
 > > pcffl root # i2cdetect 0
 > > (...)
 > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
 > > 00: 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
 > > 10: 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f
 > > 20: 20 21 22 23 24 25 26 27 28 29 2a 2b 2c 2d 2e 2f
 > > 30: 30 31 32 33 34 35 36 37 38 39 3a 3b 3c 3d 3e 3f
 > > 40: 40 41 42 43 44 45 46 47 48 49 4a 4b 4c 4d 4e 4f
 > > 50: 50 51 52 53 54 55 56 57 58 59 5a 5b 5c 5d 5e 5f
 > > 60: 60 61 62 63 64 65 66 67 68 69 6a 6b 6c 6d 6e 6f
 > > 70: 70 71 72 73 74 75 76 77 78 79 7a 7b 7c 7d 7e 7f
 > 
 > This is bad. Only 60 should answer, other addresses should show "XX".
 > 

This is solved.  Somebody (and I did not verify before hand) had configured
the parallel port to be on some silly address.  It is now back to normal.

 > 
 > > One additional bit:
 > > 
 > > pcffl root # cat /proc/sys/dev/parport/parport0/modes
 > > PCSPP,TRISTATE
 > 
 > That may be a problem. I think I remember the i2c-pport doc stating that
 > the i2c-pport.c driver takes benefit of the features of modern parallel
 > ports (usually known as EPP or ECP, as opposed to SPP). Looks like your
 > parallel port doesn't support these modes, which may be why i2c-pport
 > doesn't work. Maybe you need to enable it through the BIOS setup
 > screen?
 > 
 > Second, i2c-pport.c doesn't use the standard parport interface, i.e. it
 > doesn't depend on the parport module - and is not even compatible with
 > it AFAIK. This means that you should *not* load the parport module when
 > using i2c-pport, because both modules will try to access the same I/O
 > ports and that may be the problem.

I indeed had to unload parport to make it work.  Now i2cdetect doesn't
detect anything.  I have been playing with a scope during the last hour or
2 to try to see what was happening.  It seems that the ACK signal is not
pulled down enough by the CMPS03 to be detected as such (I read 1V which is
probably a bit high for a 0V).  This is confirmed in the messages:

Apr  5 17:32:49 pcffl i2c-algo-bit.o: Used 4 tries to write client at 0x60 : no ack
Apr  5 17:32:49 pcffl i2c-algo-bit.o: NAK from device addr 60 msg #0


 > 
 > You may consider using i2c-philips-par (or i2c-parport in the 2.6 kernel
 > tree) instead, but the electronics needed to interface with your chip
 > are slighly different in this case, so you would have to change that.
 > 

Yes, but that indeed involves a bit more of hardware, thus time and money
;-).  I wanted to try a fast quick and dirty way.  It proves to be not that
fast. ;-).

 > > I hope someone can help me with that.  Sorry for the long message.
 > 
 > No problem, I hope you'll find a solution. Let us know!
 > 

So any input as to why the device is not pulling down enough would be much
appreciated.  Note however that I'm yet not sure this is indeed the
problem.  I'll do more experiments tomorrow with a better scope.

Thanks anyway.

Fred
