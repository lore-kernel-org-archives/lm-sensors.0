From: Graham Medlin <glmedlin@ncsu.edu>
Date: Tue, 19 Jun 2012 19:46:48 +0000
Subject: [lm-sensors] No sensors detected PE600SC
Message-Id: <CALK30xCab=jL+AuL=_y3QV0deW9U5HtB_ZoEK0NDTVe0fSZLTg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Have a Dell PowerEdge 600sc running Ubuntu 12.04 Server. Hate to
retire the golden egg laying goose, its solid. The fan is running at
100%, sounds like a 747, so I wanted to check it with lm_sensors...

Running "sensors-detect" yields no for everything except:
     ...
     Do you want to scan for Super I/O sensors? (YES/no): y
     Probing for Super-I/O at 0x2e/0x2f
     Trying family `National Semiconductor/ITE'...               Yes
     Found `Nat. Semi. PC8741x Super IO'
         (no hardware monitoring capabilities)
     ...
     ...
     Do you want to probe the I2C/SMBus adapters now? (YES/no): y
     Using driver `i2c-piix4' for device 0000:00:0f.0: ServerWorks
CSB6 South Bridge
     Sorry, no sensors were detected.
     ...

The CSB6 bus is listed as supported, but I haven't been able to track
down what the sensors are.

Back when this was a Windows machine, I ran Everest Home, and it was
able to read everything, and claimed LM81	and MAX1617A chips for
whatever its worth...

Googling found exactly one reference claiming this was possible on a
linux machine:
     http://lists.us.dell.com/pipermail/linux-poweredge/2005-July/021985.html

I tried with no luck:
     modprobe -r i2c-piix4
     modprobe i2c-piix4

I'm not sure if its related, but "i2cdetect -l" returns nothing.

Below is part of the output of "lspci -nn -vv"
     00:0f.0 Host bridge [0600]: Broadcom CSB6 South Bridge [1166:0203] (rev a0)
          Subsystem: Broadcom Device [1166:0201]
          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
          Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
          Latency: 32
          Kernel modules: i2c-piix4, sworks-agp

Any help would be awesome! Thanks!
-Graham

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
