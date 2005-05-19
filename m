From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Keywest detection
Message-Id: <20030807124954.4ac68e3b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806190950.6326aa8f.khali@linux-fr.org>
In-Reply-To: <20030806190950.6326aa8f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> There's a /proc/device-tree directory on PPCs that have Open Firmware
> (that is not all PPCs, but all supported PowerMacs) that contains the
> Open Firmware device-tree.

OK, I just took a look, and it seems to be a complete mess there (2.4).
I think I will add the Keywest to the list of the _un_detectable
adapters.

> The CPU itself doesn't have the inX/outX instructions, like most non
> x86 CPUs, but there is till the possiblility of having an ISA bus on
> some machines, in which case it's available on a southbridge on the
> PCI bus. The PowerMacs don't have one though.
> 
> There are some techniques to issue IOs from userland, but those
> involve using some syscalls to find the IO base address of a given
> PCI bus, then mmap'ing /dev/mem to get access to this IO range, then
> re-implementing the kernel IO accessors based on this. This isn't
> something I recommend to do unless it cannot be avoided. (XFree is
> an example of a userland app that do need that).

Thanks for the information. I think I will fix isadump but won't compile
it be default on linux-ppc.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
