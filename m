From: "Rundblom, Glen" <rundblom@illinois.edu>
Date: Mon, 02 Oct 2023 20:59:19 +0000
Subject: bnxt_en kernel module is reporting a 92 degrees C
Message-Id: <CH0PR11MB5505E0C4F0EC33C3E695944CBAC5A@CH0PR11MB5505.namprd11.prod.outlook.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,=20
I apologize if this is the wrong place to post this, please redirect me. I =
have searched Google and Bing to no avail.

[The short]
I have a server that I think the bnxt_en kernel module is reporting a 92 de=
grees C reading:

bnxt_en-pci-3100
Adapter: PCI adapter
temp1:        +92.0=B0C

I think that reading is incorrect, but it is causing a lot of concern from =
the machine's owner.=20
Has anyone seen this before?

[The long]
The server is a new Dell Poweredge R750, running Red Hat Enterprise Linux 8=
.8 and lm_sensors version: sensors version 3.6.0 with libsensors version 3.=
6.0

The bnxt_en kernel module is driving a Broadcom 57454 Quad Port 10GbE Base-=
T Adapter Dell part number 540-BDOT

Here is the output of lshw -class network truncated to show only the BCM574=
54 card: (The other card, a Broadcom BCM5720, using kernel module tg3 is no=
t listed when running just "sensors" )

*-network:0
       description: Ethernet interface
       product: BCM57454 NetXtreme-E 10Gb/25Gb/40Gb/50Gb/100Gb Ethernet
       vendor: Broadcom Inc. and subsidiaries
       physical id: 0
       bus info: pci@0000:31:00.0
       logical name: eno12399np0
       version: 00
       serial: 04:32:01:27:d1:e0
       size: 1Gbit/s
       capacity: 10Gbit/s
       width: 64 bits
       clock: 33MHz
       capabilities: pm vpd msi msix pciexpress bus_master cap_list rom eth=
ernet physical tp 1000bt-fd 10000bt-fd autonegotiation
       configuration: autonegotiation=3Don broadcast=3Dyes driver=3Dbnxt_en=
 driverversion=3D5.15.0-84-generic duplex=3Dfull firmware=3D223.0.205.0/pkg=
 22.31.13.70 ip=3D172.22.224.232 latency=3D0 link=3Dyes multicast=3Dyes por=
t=3Dtwisted pair speed=3D1Gbit/s
       resources: irq:16 memory:a6830000-a683ffff memory:a6700000-a67fffff =
memory:a6846000-a6847fff memory:a6900000-a693ffff
  *-network:1
       description: Ethernet interface
       product: BCM57454 NetXtreme-E 10Gb/25Gb/40Gb/50Gb/100Gb Ethernet
       vendor: Broadcom Inc. and subsidiaries
       physical id: 0.1
       bus info: pci@0000:31:00.1
       logical name: eno12409np1
       version: 00
       serial: 04:32:01:27:d1:e1
       capacity: 10Gbit/s
       width: 64 bits
       clock: 33MHz
       capabilities: pm vpd msi msix pciexpress bus_master cap_list rom eth=
ernet physical tp 1000bt-fd 10000bt-fd autonegotiation
       configuration: autonegotiation=3Don broadcast=3Dyes driver=3Dbnxt_en=
 driverversion=3D5.15.0-84-generic firmware=3D223.0.205.0/pkg 22.31.13.70 l=
atency=3D0 link=3Dno multicast=3Dyes port=3Dtwisted pair
       resources: irq:17 memory:a6820000-a682ffff memory:a6600000-a66fffff =
memory:a6844000-a6845fff memory:a6940000-a697ffff
  *-network:2
       description: Ethernet interface
       product: BCM57454 NetXtreme-E 10Gb/25Gb/40Gb/50Gb/100Gb Ethernet
       vendor: Broadcom Inc. and subsidiaries
       physical id: 0.2
       bus info: pci@0000:31:00.2
       logical name: eno12419np2
       version: 00
       serial: 04:32:01:27:d1:e2
       capacity: 10Gbit/s
       width: 64 bits
       clock: 33MHz
       capabilities: pm vpd msi msix pciexpress bus_master cap_list rom eth=
ernet physical tp 1000bt-fd 10000bt-fd autonegotiation
       configuration: autonegotiation=3Don broadcast=3Dyes driver=3Dbnxt_en=
 driverversion=3D5.15.0-84-generic firmware=3D223.0.205.0/pkg 22.31.13.70 l=
atency=3D0 link=3Dno multicast=3Dyes port=3Dtwisted pair
       resources: irq:16 memory:a6810000-a681ffff memory:a6500000-a65fffff =
memory:a6842000-a6843fff memory:a6980000-a69bffff
  *-network:3
       description: Ethernet interface
       product: BCM57454 NetXtreme-E 10Gb/25Gb/40Gb/50Gb/100Gb Ethernet
       vendor: Broadcom Inc. and subsidiaries
       physical id: 0.3
       bus info: pci@0000:31:00.3
       logical name: eno12429np3
       version: 00
       serial: 04:32:01:27:d1:e3
       capacity: 10Gbit/s
       width: 64 bits
       clock: 33MHz
       capabilities: pm vpd msi msix pciexpress bus_master cap_list rom eth=
ernet physical tp 1000bt-fd 10000bt-fd autonegotiation
       configuration: autonegotiation=3Don broadcast=3Dyes driver=3Dbnxt_en=
 driverversion=3D5.15.0-84-generic firmware=3D223.0.205.0/pkg 22.31.13.70 l=
atency=3D0 link=3Dno multicast=3Dyes port=3Dtwisted pair
       resources: irq:17 memory:a6800000-a680ffff memory:a6400000-a64fffff =
memory:a6840000-a6841fff memory:a69c0000-a69fffff

The IDRAC reports everything is fine, I switched the system into a more agg=
ressive cooling profile but the 92 degree reading is unchanged.=20

Is there a configuration file that I need to edit, do I have the wrong kern=
el module for this network card by chance, or maybe that network card actua=
lly runs that hot?=20

Thank you in advance,
-Glen
