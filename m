From: lists@localguru.de (Marcus Schopen)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: Intel S845WD1-E
Message-Id: <200404281105.45439.lists@localguru.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200404280005.56044.lists@localguru.de>
In-Reply-To: <200404280005.56044.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hei,

On Wednesday 28 April 2004 10:43, Jean Delvare wrote:
> > is the Intel S845WD1-E supported by lm-sensors?
> >
> > my lspci output:
> > [....]
> > 00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host
> > Bridge
> > (rev 11)
> > 00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP
> > Bridge (rev
> > 11)
> > 00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev
> > 05)
> > 00:1f.0 ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA
> > Bridge (ICH2)
> > (rev 05)
> > 00:1f.3 SMBus: Intel Corp. 82820 820 (Camino 2) Chipset SMBus (rev
> > 05)
> > [....]
>
> I'd expect the i2c-i801 driver to work. If not, please provide the
> output of "lspci -n".

Ah, nice! I'm running Debian/woody (kernel 2.4.18) which contains the 
following source packages of lm-sensors and i2c:

   Package: lm-sensors-source - Version: 2.6.3-5
   Package: i2c-source - Version: 2.6.3-5

Are these versions too old?

Thanks,
Marcus
