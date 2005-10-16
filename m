From: pavouk@pavouk.org (Pavel Ruzicka)
Date: Sun, 16 Oct 2005 23:04:21 +0000
Subject: [lm-sensors] Support for SMSC 47M15x/192
Message-Id: <200510162303.21468.pavouk@pavouk.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

sensors-detect tell me this:
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Success... found at address 0x0800
# no driver for SMSC 47M15x/192 Super IO Fan Sensors yet

I have vanilla kernel 2.6.13.4 and sensors 2.9.0 from distribution.

I tried download cvs night build and put file smsc47m1.c to drivers/hwmon/
in a kernel tree, but this was not a good idea :-)
In README there are info, that this version is only for 2.4 kernel.

I'am a little confused.
Where can I download actual kernel driver for my chip?
Is this chip now supported?

Additional info:
Board MSI RS480M2 with ATI IXP chipset.
part of lspci output:
00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5950
00:02.0 PCI bridge: ATI Technologies Inc: Unknown device 5a34
00:14.0 SMBus: ATI Technologies Inc ATI SMBus (rev 04)
00:14.3 ISA bridge: ATI Technologies Inc: Unknown device 4377

Best regards,

Pavel Ruzicka
