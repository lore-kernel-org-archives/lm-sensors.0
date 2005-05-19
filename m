From: klaus@sconk.dk (Klaus Rene Hansen [Sconk])
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: Ticket #: 997
Message-Id: <20020913114208.4b96e4d8.klaus@sconk.dk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I did read the faq from the start. now i try agen.. ;-)


From FAQ:
>4.21 Sensors says 'No sensors found!'
>
>    Did sensors-detect find sensors? (If not see 4.24C)
>    Did you do what sensors-detect said?
Yes.
>    Did you 'modprobe' your sensor modules?
yes
>    Did you 'modprobe' your I2C adapter modules?
yes
>    Did you 'modprobe i2c-isa' if you have ISA sensor chips?
yes
>    Check 'lsmod'.

Module                  Size  Used by    Not tainted
eeprom                  3456   0  (unused)
lm80                    5120   0  (unused)
via686a                 7748   0  (unused)
i2c-viapro              3848   0 
w83781d                18656   0  (unused)
i2c-isa                 1220   0  (unused)
i2o_core               33280   0  (unused)
i2o_config              7336   0  (unused)
i2o_proc               41440   0  (unused)
i2c-algo-bit            7340   0  (unused)
i2c-dev                 3872   0 
i2c-algo-pcf            5088   0  (unused)
i2c-proc                6336   0  [eeprom lm80 via686a w83781d]
i2c-core               15072   0  [eeprom lm80 via686a i2c-viapro w83781d i2c-isa i2c-algo-bit i2c-dev i2c-algo-pcf i2c-proc]







Some default Signature
