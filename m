From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: SOLVED: Ticket #1409
Message-Id: <3F7D5ECF.61EB51A@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <hvvfr8digc.fsf@rasputin.ws.nextra.no>
In-Reply-To: <hvvfr8digc.fsf@rasputin.ws.nextra.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

We already have similar super i/o detection in sensors-detect
and in 3 drivers: vt1211, smsc47m1, and w83627hf.
There's also super i/o detection in sensors-detect for the it8705, but
it is
commented out because the "exit" value is different than for other
chips and I didn't want to leave other chips stuck in PnP mode
(although I wonder if your 8712 gets stuck in PnP mode when running
sensors-detect??).

If you port over the super i/o code from one of the 3 drivers listed
above
and send us a patch we'll include it.

thanks
mds


Bj?rn Mork wrote:
>=20
> I didn't find any way of updating the ticket, so I'm sending this via
> mail.  After writing the original ticket I downloaded and read the
> IT8712F data sheet, which I of course should have done first...  This
> enabled me to write a small program to retrieve the non-default
> address of the IT8712F on the Asus A7N8X-VM:
>=20
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/io.h>
> #include <string.h>
>=20
> int main(int argc, char **argv) {
>         if (ioperm(0x0, 0x3ff, 1)) {
>                 perror("Set i/o permission");
>                 exit(0);
>         }
>=20
>         /* enter MB PnP mode */
>         outb(0x87, 0x2e);
>         outb(0x01, 0x2e);
>         outb(0x55, 0x2e);
>         outb(0x55, 0x2e);
>=20
>         /* get chip ID */
>         outb(0x20, 0x2e);
>         printf("chip id =3D 0x%02x", inb(0x2f));
>         outb(0x21, 0x2e);
>         printf("%02x\n", inb(0x2f));
>=20
>         /* select GPIO */
>         outb(0x07, 0x2e);
>         outb(0x04, 0x2f);
>=20
>         outb(0x60, 0x2e); /* address MSB */
>         printf("LDN 4, reg 0x60 =3D 0x%02x\n", inb(0x2f));  /* default 0x=
02 */
>         outb(0x61, 0x2e); /* address LSB */
>         printf("LDN 4, reg 0x61 =3D 0x%02x\n", inb(0x2f));  /* default 0x=
90 */
>         outb(0x30, 0x2e); /* enable */
>         printf("LDN 4, reg 0x30 =3D 0x%02x\n", inb(0x2f));  /* default 0x=
00, should be >0 */
>=20
>         /* exit from MB PnP mode */
>         outb(0x02, 0x2e);
>         outb(0x02, 0x2f);
>         return 0;
> }
>=20
> Which gave the following output right after a reboot:
>=20
> chip id =3D 0x8712
> LDN 4, reg 0x60 =3D 0x0d
> LDN 4, reg 0x61 =3D 0x00
> LDN 4, reg 0x30 =3D 0x01
>=20
> I.e. Asus have changed the base address from 0x290 to 0xd00.  Using
> this address with it87 worked perfectly:
>=20
>   modprobe it87 probe=9191,0x0d00
>=20
> I wonder however, would it be possible to include a refined version of
> the address detection code in the module?  I am willing to try to
> write it myself, but I won't do it unless I know it has some remote
> possibility of being included.
>=20
> Bj?rn
