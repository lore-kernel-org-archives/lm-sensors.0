From: mochel@digitalimplant.org (Patrick Mochel)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: We will port w83792d.c to linux-2.6
Message-Id: <Pine.LNX.4.50.0503100904130.26181-100000@monsoon.he.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE190650@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


On Thu, 10 Mar 2005, Rudolf Marek wrote:

> Hello,
>
> Patrick please can you help with this?

I can try. I checked the datasheet, and I'll relate what I know, though
I'm definitely not an expert on i2c.

Note that while not *identical*, the controller shares a lot of
similarities with the i810 driver.

i2c-0: Transaction (pre):  STS=00, CNTL1=00, CNTL2=10, CMD=C1, ADDX,
DAT0=00, DAT1=00
i2c-0: Transaction (post): STSD, CNTL1=00, CNTL2=10, CMD=C1, ADDX,
DAT0=00, DAT1=00
Mar 10 18:01:07 pi140001 kernel: i2c_adapter i2c-0: SMBus Error: Timeout
Device Error Transaction Never Finished


In SMB_HST_STS (offset 0), bit 6 is "ISUSE_STS", which reads a 0 the first
time after the device is reset, then a 1 after that. Seems like it can be
used to check if the deivce is ready to be used after a reset..

Bit 2 is 'DEV_ERR' which simply says that one of the following errors
occured:

- Illegal Command Field
- Unclaimed command protocol
- Host or device timeout
- Master's NACK cycle being driven to ACK
- Master's ACK being forced to NACK
- Master's stop cycle being corrupted

It says that it only happens at address 0x58. Is there a device there? If
there is, perhaps you could try increasing the timeout?

Does that help at all?


	Patrick
