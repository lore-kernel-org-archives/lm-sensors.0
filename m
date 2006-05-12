From: zukov@drzukov.is-a-geek.org (=?UTF-8?B?SnVyZSBLbGFrb8SNYXI=?=)
Date: Fri, 12 May 2006 18:15:20 +0000
Subject: [lm-sensors] Support for Fintek F71872F
Message-Id: <4464D0B8.8070203@drzukov.is-a-geek.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have an Epox 9NPA7I board that uses the F71872F chip. The CVS version 
of sensors-detect returns:

Driver `f71805f' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0295 (Busdriver `i2c-isa')
    Chip `Fintek F71872F/FG Super IO Sensors' (confidence: 9)

However I am unable to successfully insert the f71805f module for the 
2.6.16 kernel. How much work still has to be done to support the F71872F 
chip? I'd be willing to program the support myself, but I would need a 
few pointers and the necessary documentation.

Thanks,
Jure

