From: kmalkki@cc.hut.fi (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: 24rf08 update
Message-Id: <Pine.OSF.4.44.0209011233390.28151-100000@kosh.hut.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D717733.227ED638@paradyne.com>
In-Reply-To: <3D717733.227ED638@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 31 Aug 2002, Mark D. Studebaker wrote:

> Unlike any other eeprom we've seen, a quick write is not benign
> for these eeproms - it takes it as a start of a write.
> So the following read of chip 0x54 at location 0x48 completes the write
> -
> and location 0xa8 (= 0x54 << 1) gets 0x48 written to it.

> So any read (from any chip!) after a quick write corrupts the chip.


If I understood you correctly, crucial sequence is:

Write Quick "0"
S 0x54 Wr [A] P

Read Byte Data
S 0x54 Wr [A] 0x48 [A] S 0x54 Rd [A] [Data] NA P

Further reads without quick write do not corrupt eeprom ?
And the Write Quick address could be from 0x54 to 0x57 ?

Suppose 24rf08 has a poorly designed state machine that does not check
for Start and Stop conditions right after acknowledging its address.
Below I mark these <S> and <P>, respectively.

The sequence above becomes Write Byte Data + Read Byte. It returns the
data just written in the referenced location (0xa8).
S 0x54 Wr [A] <P><S> 0x54 Wr [A] 0x48 [A] S 0x54 Rd [A] [0x48] NA P


Maybe i2c/doc/smbus-protocol has a typo :

SMBus Write Byte :   S Addr Wr [A] Data NA P
             IMO :   S Addr Wr [A] Data [A] P

Two successive Write Quick "0" become Write Byte, only changing the
reference for Read Byte transactions. This is i2cdetect operation and
causes no corruption.

S 0x54 Wr [A] <P><S> 0x55 Wr?[A] P

If this is the case, latter of the two Write Quick commands is always
acknowledged by 24rf08, and does not reflect a client at that address.

It also means 2 x Write Quick would reset the state machine and prevent
corruption...

> I also repeatedly tried the following things to see if they would
> corrupt the chip,
> nothing did - i2cdetect (which also uses quick write with a 0!),

I know my Matrix Orbital LCD w/ old BIOS forces SCL down forever with
quick write "1" (aka read address). It takes power-off to release it.

 > cvs log i2cdetect.c

----------------------------
revision 1.5
date: 1999/07/21 09:35:40;  author: kmalkki;  state: Exp;  lines: +1 -1
(Ky?sti)

  *  Use write-address to detect devices on the bus.

 Simple clients that you can't read, don't ack the read address.
 I believe every client has to ack their write address?
----------------------------


-- 
  Ky?sti M?lkki
  kmalkki@cc.hut.fi

