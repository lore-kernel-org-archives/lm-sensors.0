From: lamar@synque.com (Lamar Willis)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: lm_sensors 2.8.1 test - more
Message-Id: <200310071329.23556.lamar@synque.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,
	lm_sensors 2.8.1 also reported a tie for my Winbond W83627HF chip:


Driver `w83781d' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF' (confidence: 8)

Driver `w83627hf' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF Super IO Sensors' (confidence: 8)

But w83781d does not show my fans, w83627hf does.

Lamar
