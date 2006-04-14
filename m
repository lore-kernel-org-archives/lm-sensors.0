From: mmodem00@netvisao.pt (=?iso-8859-1?q?Z=E9?=)
Date: Fri, 14 Apr 2006 16:22:19 +0000
Subject: [lm-sensors] unable to configure lm_sensors
Message-Id: <200604141722.19525.mmodem00@netvisao.pt>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Im using lm_sensors from today cvs snapshot and when i run sensors-detect i 
got most probs failed:

Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8712F'
  Trying address 0x0290... Failed!
Probing for `ITE IT8705F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0xea11)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0xea11)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0xea11)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `Nat. Semi. PC87591 Super IO'
  Failed! (0xea)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0xea)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0xea)
Probing for `Nat. Semi. PC8739x Super IO'
  Success... (no hardware monitoring capabilities)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0xea)
Probing for `Nat. Semi. PC87427 Super IO'
  Failed! (0xea)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0xea)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0xea)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0xea)
Probing for `SMSC 47M15x/192/997 Super IO Fan Sensors'
  Failed! (0xea)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0xea)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0xea)
Probing for `SMSC 47M172 Super IO'
  Failed! (0xea)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0xea)
Probing for `SMSC SCH5307-NS Super IO'
  Failed! (0xea)
Probing for `SMSC LPC47M584-NC Super IO'
  Failed! (0xea)
Probing for `VT1211 Super IO Sensors'
  Failed! (0xea)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0xea)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0xea)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0xea)
Probing for `Winbond W83687THF Super IO Sensors'
  Failed! (0xea)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0xea)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0xea)
Probing for `Winbond W83L517D Super IO'
  Failed! (0xea)
Probing for `Fintek F71805F/FG Super IO Sensors'
  Failed! (0xea11)
Probing for `Fintek F71872F/FG Super IO Sensors'
  Failed! (0xea11)
Probing for `Fintek F81218D Super IO'
  Failed! (0xea11)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (0xea11)

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

 Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.

Any help?
-- 
Z?
Linux user #378762
MDE Developer - www.mde.djura.org

