From: maurice@harddata.com (Maurice Hilarius)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: lmsensors on Tyan S2466 motherboard
Message-Id: <5.1.0.14.2.20020223105744.0427c230@mail.harddata.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am interested in getting lmsensors working on the Tyan S2466 motherboard 
(AMD 768MPX)
I asked Tyan's people if they could share some info on their 
implementation, and the following is what I got.
I do not know of this is useful or not, but I thought it could not hurt to 
send..

On this subject, I wonder if anyone is working on this?

Thanks!

======================Winbond83627HF SuperI/O & Hardware Monitor chip
and
Winbond83782D Hardware Monitor chip.

W83627HF SMBus slave address is 0x2C
Sensor                pin#            address
CPU1 FAN              113                0x28
CPU2 FAN              112                0x29
CPU1 Core Voltage     100                0x20
CPU2 Core Voltage      99                0x21
System Voltage 3.3V    98                0x22
System Voltage 12V     96                0x24
System Voltage -12V    95                0x25
VRM1 Temperature      104                0x27
DDR Temperature       102                0x50(bank2)
AGP Temperature       103                0x50(bank1)


W83782D SMBus slave address is 0x2D
Sensor                pin#             address
Chassis Fan 1          20                0x28
Chassis Fan 2          19                0x29
Chassis Fan 3          18                0x2A
System Voltage 5V      33                0x23
AGP Voltage            34                0x22
DDR Voltage            32                0x24
Battery Voltage        30                0x51(bank5)
Standby 3.3V           28                0x26
CPU1 Temperature       39                0x50(bank1)
CPU2 Temperature       38                0x50(bank2)
VRM2 Temperature       40                0x27


With our best regards,

Maurice W. Hilarius       Telephone: 01-780-456-9771
Hard Data Ltd.               FAX:       01-780-456-9772
11060 - 166 Avenue        mailto:maurice@harddata.com
Edmonton, AB, Canada      http://www.harddata.com/
    T5X 1Y3

Ask me about the UP1500 Alpha - Full systems from $3,500!
