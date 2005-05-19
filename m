From: catalyst@gmx.net (JC Wong)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: i2c-2.6.4 failed on 2.4.x kernel
Message-Id: <20020723061809.GA1247@polaroids.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

Updated i2c-2.6.4 and lm_sensors-2.6.4 patch on 2.4.19-rc3-ac2 kernel.
No problem on 'make dep' & 'make bzImage'.

Here is the error during 'make modules';

make -C i2c modules
make[2]: Entering directory `/home/catalyst/src/linux/drivers/i2c'
make[2]: *** No rule to make target `i2c-algo-8xx.c', needed by
`i2c-core.o'.  Stop.
make[2]: Leaving directory `/home/catalyst/src/linux/drivers/i2c'
make[1]: *** [_modsubdir_i2c] Error 2
make[1]: Leaving directory `/home/catalyst/src/linux/drivers'
make: *** [_mod_drivers] Error 2

No problem on previous 2.6.3 source.Here I attached my kernel configure
setting for i2c and lm_sensors.Using Adapter: ISA adapter
'via686a-isa-6000' here.

------------------------------

# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_BITLP is not set
# CONFIG_I2C_BITELV is not set
# CONFIG_I2C_BITVELLE is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_MAINBOARD=y
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_HYDRA is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_TSUNAMI is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_SIS5595 is not set
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m
# CONFIG_I2C_VOODOO3 is not set
CONFIG_I2C_ISA=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

# Hardware sensors support
#
CONFIG_SENSORS=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1024 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_FSCSCY is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_MAXILIFE is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_MTP008 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_VIA686A=m
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_OTHER is not set

Further advice needed,Thanks.

CaT.
-- 
JC Wong,Singapore   http://polaroids.webhop.org/~catalyst
  ICQ: 19663610               catalyst@gmx.net          
---------------------------------------------------------
I must have a prodigious quantity of mind; it takes me as much as a
week sometimes to make it up.
                -- Mark Twain, "The Innocents Abroad"
