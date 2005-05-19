From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <gUSS4z1W.1108395857.6509030.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Christophe,

> I already tried to file this report on the
> http://www2.lm-sensors.nu/~lm78/support.html
> page but for some unknown reasons it doesn't seem to register my ticket.

Probably because you hit the arbitrary size limit. We are considering
moving to bugzilla for this reason and several others.

> I have googled a lot and searched the database and FAQ(section 5.3) but i
> found no answer to my problem. The adt7463 on my asus w1n laptop / mandrake
> 10.1 Official Edition is not detected in spite of all my efforts.
> (...)
> Probing for PCI bus adapters...
> Sorry, no PCI bus adapters found.
> (...)
> 00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 21)
> (...)
> 00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
> 00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 03)
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
> 00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 03)

Missing SMBus function (should be 00:1f.3). Quite typical from Asus, they
tend to hide it for no reason.

You need what is called a PCI quirk to enable it again. Good news is that
this is a known problem with a known solution. Bad news is that it
involves a kernel recompilation, which you might not be used to.

We'd now need the output of "lspci -s 00:00.0 -vn" to add the quirk
your system needs. With that I can write a patch for you to test (if you
can do that).

Thanks,
--
Jean Delvare
