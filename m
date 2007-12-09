From: Mike Houston <mikeserv@bmts.com>
Date: Sun, 09 Dec 2007 19:40:04 +0000
Subject: Re: [lm-sensors] 2.6.24-rc4 hwmon it87 probe fails
Message-Id: <20071209144004.ac36aad1.mikeserv@bmts.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071204215154.7f26285e.mikeserv@bmts.com>
	<20071209000554.GF20441@stusta.de>
	<20071208212234.e00b74cd.mikeserv@bmts.com>
	<20071209105028.06ed52a6@hyperion.delvare>
In-Reply-To: <20071209105028.06ed52a6@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Adrian Bunk <bunk@stusta.de>, mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Adam Belay <ambx1@neo.rr.com>

On Sun, 9 Dec 2007 10:50:28 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> This one shows:
> 
> system 00:01: ioport range 0x290-0x29f has been reserved
> (...)
> system 00:01: ioport range 0x290-0x294 has been reserved
> 
> This is clearly not correct as both areas overlap. The second
> reservation is responsible for the it87 breakage, because it
> conflicts with what the it87 driver later attempts to request
> (0x290-0x297). The first is wrong as well (the IT87xxF environment
> controller I/O area is 8 port wide, not 16) but shouldn't be a
> problem in practice.
> 
> These port reservations weren't happening in 2.6.23.9 according to
> your dmesg output for that kernel. I don't know what changed in
> this area since 2.6.23.9, maybe Bjorn or Adam (Cc'd) can tell.
> 
> Either way, the overlapping areas smell like a BIOS bug, meaning
> that you should look for an updated BIOS for your system first.
> 
> > http://www.mikeserv.com/temp/config-2.6.24-rc4.txt

Thanks for the suggestion, Jean. I flashed my bios to the latest
(F12) for my Gigabyte GA-965P-DS3 (rev. 3.3) motherboard

http://www.gigabyte.com.tw/Products/Motherboard/Products_Overview.aspx?ProductID$56

Unfortunately, there has been no change to the situation. The same
ioport ranges are being reserved when booting with 2.6.24-rc4 and
it87 does not work. No change to the situation in 2.6.23.9 either, the
io conflict is not occuring and it87 still works there.

Mike Houston

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
