From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: [W.Braun@HSTee.de: Troubles with i2c-piix4]
Message-Id: <20030703124231.GB575@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Wolfgang Braun <W.Braun@HSTee.de> -----

From: Wolfgang Braun <W.Braun@HSTee.de>
Organization: H&S Tee-Gesellschaft mbH
Subject: Troubles with i2c-piix4
To: frodol@dds.nl
X-MIME-Autoconverted: from quoted-printable to 8bit by morannon.frodo.local id h63BP4FI021656
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 

Hi Frodo,

sorry to desturb You, but I think, You are the only ones who are able to help
me.

Problem:
===Module "i2c-piix4" does not load like expected, see the following answers to
my commands

SRV-LIN-01:/ # modprobe i2c-piix4
/lib/modules/2.4.19-4GB-SMP/kernel/drivers/i2c/i2c-piix4.o: init_module:
Operation not permitted
Hint: insmod errors can be caused by incorrect module parameters, including
invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.19-4GB-SMP/kernel/drivers/i2c/i2c-piix4.o: insmod
/lib/modules/2.4.19-4GB-SMP/kernel/drivers/i2c/i2c-piix4.o failed
/lib/modules/2.4.19-4GB-SMP/kernel/drivers/i2c/i2c-piix4.o: insmod i2c-piix4
failed

SRV-LIN-01:/ # modprobe i2c-piix4 force=1
/lib/modules/2.4.19-4GB-SMP/kernel/drivers/i2c/i2c-piix4.o: init_module:
Operation not permitted
Hint: insmod errors can be caused by incorrect module parameters, including
invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.19-4GB-SMP/kernel/drivers/i2c/i2c-piix4.o: insmod
/lib/modules/2.4.19-4GB-SMP/kernel/drivers/i2c/i2c-piix4.o failed
/lib/modules/2.4.19-4GB-SMP/kernel/drivers/i2c/i2c-piix4.o: insmod i2c-piix4
failed


Hardware:
====
IBM xSeries Server Type 8671, Mod. 4BX
IBMs ChipSet Info:
  ServerWorks Grand Champion 4.0 LE
  CSB5 South Bridge
  ISMP Serviceprocessor Hitachi H8S2148

Software:
===SuSE Enterprise Server 1.0
Kernel 2.4.19-4GB-SMP (build by my own)
  (same problem with original SuSE-kernel)


Do You have any idea how to get it work ???

Many thanks Wolfgang.


----- End forwarded message -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
