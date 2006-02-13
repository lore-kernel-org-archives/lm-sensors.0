From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 13 Feb 2006 23:24:03 +0000
Subject: [lm-sensors] HT-1000 smbus
Message-Id: <43F11513.4040709@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43F105D6.7000500@cdi.cz>
In-Reply-To: <43F105D6.7000500@cdi.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Martin Devera wrote:
> Hello,
> I've read ticket of someone requesting driver for subj.
> I have Supermicro MB witj ADM1026 connected via HT-1000
> and looking for its smbus driver too.
> I might be able to write it but I'd like to ask for hints
> how can one get DS from Broadcom :) Maybe someone from
> lm-sensors has "better influence" when asking for it ?

NBo influence sorry.

Well I have _NO_ time for this until end of next week, but I was curious and tired from studying so I have looked :)

here are the results:
ftp://ftp.supermicro.com/utility/Supero_Doctor_III/32-Bit_Edition/AllSuperD.ini

This software has an interesting file smbus.sys

   1051d:       3d 66 11 00 02          cmp    $0x2001166,%eax
   10522:       0f 84 9b 00 00 00       je     0x105c3
   10528:       3d 66 11 01 02          cmp    $0x2011166,%eax
   1052d:       0f 84 90 00 00 00       je     0x105c3
   10533:       3d 66 11 05 02          cmp    $0x2051166,%eax
   10538:       0f 84 85 00 00 00       je     0x105c3
   1053e:       3d 86 80 83 24          cmp    $0x24838086,%eax
   10543:       74 73                   je     0x105b8


HT1000 legacy southbridge should be same as:
0200	OSB4 South Bridge
0201	CSB5 South Bridge

let confirm by:
Please provide output of

lspci -v -v -v
and
lspci -n

http://pci-ids.ucw.cz/iii/?i66

> I already tried PIIX4/older serverworks method but it no
> longer works :( Also I can't find other driver/sw to reverse
> engineer. I feel a bit lost ;-)


Maybe just adding the line with:
        { PCI_DEVICE(0x1166, 0x205),
          .driver_data = 0 },

Will do the trick. Assuming you have the "HT1000 Legacy South Bridge" If not we must find out where is the PCI id located and start from that point.

regards
Rudolf

