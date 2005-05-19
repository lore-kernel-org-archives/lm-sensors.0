From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Installation report/Feedback
Message-Id: <20031216203000.116a7354.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207183312.GA855@GreenHouse.dorchain.net>
In-Reply-To: <20031207183312.GA855@GreenHouse.dorchain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Ok:
>  i2cdump 1 0x2e
> (...)

As you can see the XX's moved. Also, there were no XX's on the ASB100
dump. Conclusion: there is a communication problem over your I2C bus,
that does only affect the W83L785TS-S chip. This was already seen:
http://www.nforcershq.com/forum/viewtopic.php?t#918#185075
But other users don't have the problem.

I don't know if there's anything we can do. Alex van Kaam (MBM's author)
told us that he observed the same (which tends to demonstrate that the
hardware, not the software, is faulty). He suggested that it could be "a
conflict with the bios reading it", but I don't see why the BIOS would
read it. There's a pin of the chip dedicated to this (goes low if the
limit temperature is reached).

Could you please provide the following dumps:
i2cdetect 1
i2cdump 1 0x2e c
This could help me. The first command will list all present chips in the
bus (maybe there's another chip on tha bus that causes trouble). The
second command will use an alternate way to dump the chip contents. If
it doesn't have XX's it might be an interesting workaround (but I doubt
it).

> The EXLDFLAGS was just "there" in the main makefile. I just now
> learned how the makefile approach for this package works, and IMHO it
> is a great concept. A patch which works for all programs is included
> now.

Applied, thanks.

> BTW, one further optimization (i.e. play computer-scientists favourite
> game "add another abstraction layer" ;-) might be to have variable
> like COMPILE := $(CC) $(CFLAGS) and LINK := $(CC) $(LDFLAGS), as these
> combinations seem to be common.

Not worth the effort IMHO ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
