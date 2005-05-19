From: bjorn@mork.no (=?iso-8859-1?q?Bj=F8rn_Mork?=)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: SOLVED: Ticket #1409
Message-Id: <hvvfr8digc.fsf@rasputin.ws.nextra.no>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I didn't find any way of updating the ticket, so I'm sending this via
mail.  After writing the original ticket I downloaded and read the
IT8712F data sheet, which I of course should have done first...  This
enabled me to write a small program to retrieve the non-default
address of the IT8712F on the Asus A7N8X-VM:


#include <stdio.h>
#include <unistd.h>
#include <sys/io.h>=20
#include <string.h>

int main(int argc, char **argv) {
        if (ioperm(0x0, 0x3ff, 1)) {
                perror("Set i/o permission");
                exit(0);
        }

        /* enter MB PnP mode */
        outb(0x87, 0x2e);
        outb(0x01, 0x2e);
        outb(0x55, 0x2e);
        outb(0x55, 0x2e);

        /* get chip ID */
        outb(0x20, 0x2e);
        printf("chip id =3D 0x%02x", inb(0x2f));
        outb(0x21, 0x2e);
        printf("%02x\n", inb(0x2f));

        /* select GPIO */
        outb(0x07, 0x2e);
        outb(0x04, 0x2f);

        outb(0x60, 0x2e); /* address MSB */
        printf("LDN 4, reg 0x60 =3D 0x%02x\n", inb(0x2f));  /* default 0x02=
 */
        outb(0x61, 0x2e); /* address LSB */
        printf("LDN 4, reg 0x61 =3D 0x%02x\n", inb(0x2f));  /* default 0x90=
 */
        outb(0x30, 0x2e); /* enable */
        printf("LDN 4, reg 0x30 =3D 0x%02x\n", inb(0x2f));  /* default 0x00=
, should be >0 */

        /* exit from MB PnP mode */
        outb(0x02, 0x2e);
        outb(0x02, 0x2f);
        return 0;
}


Which gave the following output right after a reboot:

chip id =3D 0x8712
LDN 4, reg 0x60 =3D 0x0d
LDN 4, reg 0x61 =3D 0x00
LDN 4, reg 0x30 =3D 0x01

I.e. Asus have changed the base address from 0x290 to 0xd00.  Using
this address with it87 worked perfectly:

  modprobe it87 probe=9191,0x0d00


I wonder however, would it be possible to include a refined version of
the address detection code in the module?  I am willing to try to
write it myself, but I won't do it unless I know it has some remote
possibility of being included.


Bj?rn
