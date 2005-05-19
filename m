From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: PC87366 with the net4801
Message-Id: <200406250937.i5P9bdHo009086@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Andrew,

(Shouldn't you be sleeping at 4:30am? ;))

>As a quick recap for those viewing this in the soekris-tech list,
>I'm trying to get lm sensors (temp and voltage monitoring)
>working on a net4801 under linux, using the pc87360 driver that
>Jean has developed. (Please correct me if i'm wrong, Jean, I
>assume you've developed this driver).

You're correct, I did. Please note that I don't own such a chip myself,
the driver was developped from the excellent National Semiconductor
datasheet with the precious help of a few testers.

>See output.txt for more command output from this. I
>don't really see any change in the readings. There is one thing
>that I found noteworthy, however. Even after forcing internal
>vref using the commands you suggested, I still get the following
>dmesg output:
>
>soekris1# dmesg -c
>pc87360.o version 2.8.8-CVS (2004xxxx)
>pc87360.o: device 0x09 not activated
>Using external reference voltage

Aha. My bad, I gave you a bad command. That's what it takes to do
support without having the datasheet handy.

Please do:

isaset -f 0x6628 0x00
isaset -f 0x6648 0x00

(i.e. 0x00 instead of 0x03)

It *should* switch the chip to internal ref.

Please dump the chip's contents again after that. for comparison.

Thanks and sorry for the bad information.

Jean Delvare
