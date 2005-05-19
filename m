From: steinhau@andrew.cmu.edu (Steinar Hauan)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: lm_sensors for 2.6 kernels
Message-Id: <Pine.LNX.4.58-035.0401251037500.2678@unix46.andrew.cmu.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello,

  one of my goals for the next couple of months is to get lm_sensors
  working properly on my computer cluster where i work. the expected
  timeframe for a 2.6 kernel upgrade is may/june this year.

  my main interest is to obtain status info for Intel E7xxx chipsets;
  the current test system is a SuperMicro P4SAA (E7205) mobo.
  when running "sensors-detect", i end up with all modules loading and

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)

  your status page says this driver (and 2.6 support) is in beta.
  being impatient, i naturally tried to

gcc -c -Wall -DMODULE -D__KERNEL__ -O6 \
    -I${KPATH}/linux-2.6.1-p4/include w83627hf.c

  but -- as your documentation says -- it "will not compile".

  --> i'll be happy/willing to participate in some testing here
      if you think it would be of use yet.

regards,
--
  Steinar Hauan, dept of ChemE  --  hauan@cmu.edu
  Carnegie Mellon University, Pittsburgh PA, USA
