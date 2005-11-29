From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 29 Nov 2005 16:26:33 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <AvtlR28p.1133277949.4901010.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Daniel,

On 2005-11-28, Daniel Nilsson wrote:
> This is the complete patch I've been using against what is in kernel
> 2.6.14, it should include the previous changes as well as the above
> checks for fan4 and fan5 (if I understood the datasheet and your
> comments correctly):

Yes that's correct and mostly similar to what Yuan posted. I'll apply
Yuan's version which is better shaped.

> So I tried the direct SMBus writes without even loading the w83792d
> driver after a reboot. The machine still hangs... I don't get the hang
> at the exact same place, but the order in which you have the writes
> suggested is slighly different then my own scripts so that probably
> doesn't say much.
> (...)
> + i2cset -y 0 0x2c 0xbd 0xff
> No size specified (using byte-data access)
> Value 0xff written, readback matched
> + i2cset -y 0 0x2c 0xbf 0xff
> No size specified (using byte-data access)
> <here the machine hangs>
>
> I guess we can rule out the w83792d driver since that one isn't even
> loaded at this point.

Yup, that was pretty much the aim of this test.

Now... I have to admit I am out of ideas at this point. Maybe you can try
enabling kernel debugging (Detect Soft Lockups, Spinlock debugging...)
and see if something shows. But that's a blind shot.

It would be interesting to know if the W83792D chip on your motherboard
is only wired to the Intel 82801 chip via SMBus, or if it is also wired
to the CPU or anything else, and how. But I guess you don't have any
wiring diagram? These are rather hard to find unless you have very good
relations with the board manufacturer.

What really puzzles me is that the values we are writing to the registers
are NOT supposed to trigger any kind of alarm. The i2cset command which
caused the trouble above is writing the same value the target register
already had. I really can't see how anything is supposed to happen as a
result :(

--
Jean Delvare
