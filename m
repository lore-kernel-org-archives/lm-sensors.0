From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: Intel S845WD1-E
Message-Id: <1083141836.408f6ecc295bd@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200404280005.56044.lists@localguru.de>
In-Reply-To: <200404280005.56044.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> is the Intel S845WD1-E supported by lm-sensors?
> 
> my lspci output:
> [....]
> 00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host
> Bridge 
> (rev 11)
> 00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP
> Bridge (rev 
> 11)
> 00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev
> 05)
> 00:1f.0 ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA
> Bridge (ICH2) 
> (rev 05)
> 00:1f.3 SMBus: Intel Corp. 82820 820 (Camino 2) Chipset SMBus (rev
> 05)
> [....]

I'd expect the i2c-i801 driver to work. If not, please provide the
output of "lspci -n".

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
