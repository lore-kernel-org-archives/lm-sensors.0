From: aurelien.nephtali@wanadoo.fr (=?unknown-8bit?Q?Aur=E9lien?= Nephtali)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: Compaq Presario 1200-XL408
Message-Id: <20020719121454.GA13825@nebula>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I have a Compaq Presario model 1200-12XL408 with VIA,

isab0: <VIA 82C686 PCI-ISA bridge> at device 7.0 on pci0
atapci0: <VIA 82C686 ATA66 controller> port 0x1420-0x142f at device 7.1 on =
pci0
pci0: <VIA 83C572 USB controller> at 7.2 irq 11
viapropm0: <VIA VT82C686A Power Management Unit> port 0x8080-0x808f at devi=
ce 7.4 on pci0
pcm0: <VIA VT82C686A> port 0x1430-0x1433,0x1434-0x1437,0x1000-0x10ff irq 9 =
at device 7.5 on pci0

(it's a bsd snapshot, from dmesg)

I would like to know if my motherboard has a temp. sensor on it because i'v=
e tried healthd, mbmon
and lmmon and they don't work so i want to know if the values used in the i=
octl() are out of sync or if
my motherboard hasn't a temp. sensor.

Thanks in advance.

-- Aur=E9lien
