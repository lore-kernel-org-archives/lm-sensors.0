From: jriehl@knology.net (John Riehl)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: lm-sensors install goes fine, but I only get status of EEPROMs
Message-Id: <409D03CD.4020608@knology.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <409C6578.2040008@knology.net>
In-Reply-To: <409C6578.2040008@knology.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

John Riehl wrote:

> The force parameter did the trick.  For whatever reason, the=20
> auto-detection wasn't working.  Here's the dmesg output with debugging=20
> on in case you're interested in seeing the auto-detect failure.  Let=20
> me know if I can do anything else.  Thanks for your help.
>
> John
>
> ------------------
>
> i801 smbus 0000:00:1f.3: I801 using PCI Interrupt for SMBus.
> i801 smbus 0000:00:1f.3: SMBREV =3D 0x2
> i801 smbus 0000:00:1f.3: I801_smba =3D 0xC800
> i2c_adapter i2c-0: registered as adapter #0
> i2c_adapter i2c-1: registered as adapter #1
> i2c /dev entries driver
> i2c-core: driver dev_driver registered.
> i2c_adapter i2c-0: Registered as minor 0
> i2c_adapter i2c-1: Registered as minor 1
> i2c-core: driver lm85 registered.
> i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr=20
> 2c<7>i801 smbus 0000:00:1f.3: Transaction (pre): CNT=00,=20
> CMD@,ADDX, DAT0=05, DAT1=00
> i801 smbus 0000:00:1f.3: Error: no response!
> i801 smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD@, ADDX,=20
> DAT0=05, DAT1=00
> i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr=20
> 2d<7>i801 smbus 0000:00:1f.3: Transaction (pre): CNT=00,=20
> CMD@,ADDZ, DAT0=05, DAT1=00
> i801 smbus 0000:00:1f.3: Error: no response!
> i801 smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD@, ADDZ,=20
> DAT0=05, DAT1=00
> i2c_adapter i2c-0: found normal i2c entry for adapter 0, addr=20
> 2e<7>i801 smbus 0000:00:1f.3: Transaction (pre): CNT=00,=20
> CMD@,ADD\, DAT0=05, DAT1=00
> i801 smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD@, ADD\,=20
> DAT0=05, DAT1=00
> i801 smbus 0000:00:1f.3: Transaction (pre): CNT=08, CMD>,ADD],=20
> DAT0=05, DAT1=00
> i801 smbus 0000:00:1f.3: Transaction (post): CNT=08, CMD>, ADD],=20
> DAT0\, DAT1=00
> i801 smbus 0000:00:1f.3: Transaction (pre): CNT=08, CMD?,ADD],=20
> DAT0\, DAT1=00
> i801 smbus 0000:00:1f.3: Transaction (post): CNT=08, CMD?, ADD],=20
> DAT0e, DAT1=00
> i2c_adapter i2c-0: Detecting device at 0,0x2e with COMPANY: 0x5c and=20
> VERSTEP: 0x65
> i2c_adapter i2c-0: Autodetecting device at 0,0x2e ...
> i2c_adapter i2c-0: Autodetection failed
> i2c-core: driver eeprom registered.
> i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0050
> i801 smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD?,ADD=A0,=20
> DAT0e, DAT1=00
> i801 smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD?, ADD=A0,=20
> DAT0e, DAT1=00
> i2c_adapter i2c-0: client [eeprom] registered to adapter
> registering 0-0050
> i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0051
> i801 smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD?,ADD=A2,=20
> DAT0e, DAT1=00
> i801 smbus 0000:00:1f.3: Error: no response!
> i801 smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD?, ADD=A2,=20
> DAT0e, DAT1=00
> i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0052
> i801 smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD?,ADD=A4,=20
> DAT0e, DAT1=00
> i801 smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD?, ADD=A4,=20
> DAT0e, DAT1=00
> i2c_adapter i2c-0: client [eeprom] registered to adapter
> registering 0-0052
> i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0053
> i801 smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD?,ADD=A6,=20
> DAT0e, DAT1=00
> i801 smbus 0000:00:1f.3: Error: no response!
> i801 smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD?, ADD=A6,=20
> DAT0e, DAT1=00
> i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0054
> i801 smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD?,ADD=A8,=20
> DAT0e, DAT1=00
> i801 smbus 0000:00:1f.3: Error: no response!
> i801 smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD?, ADD=A8,=20
> DAT0e, DAT1=00
> i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0055
> i801 smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD?,ADD=AA,=20
> DAT0e, DAT1=00
> i801 smbus 0000:00:1f.3: Error: no response!
> i801 smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD?, ADD=AA,=20
> DAT0e, DAT1=00
> i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0056
> i801 smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD?,ADD=AC,=20
> DAT0e, DAT1=00
> i801 smbus 0000:00:1f.3: Error: no response!
> i801 smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD?, ADD=AC,=20
> DAT0e, DAT1=00
> i2c_adapter i2c-0: found normal i2c_range entry for adapter 0, addr 0057
> i801 smbus 0000:00:1f.3: Transaction (pre): CNT=00, CMD?,ADD=AE,=20
> DAT0e, DAT1=00
> i801 smbus 0000:00:1f.3: Error: no response!
> i801 smbus 0000:00:1f.3: Transaction (post): CNT=00, CMD?, ADD=AE,=20
> DAT0e, DAT1=00
>

