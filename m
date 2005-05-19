From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: adm1032EB in i2c?
Message-Id: <3FF1F02E.9040206@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

what's with the adm1032eb entry in i2c/kernel/Module.mk?
did it come in accidentally with this patch?



ifneq ($(shell if grep -q '^CONFIG_I2C_ADM1032EB=y' $(LINUX)/.config; then echo 1; fi),1)
KERNELTARGETS += $(MODULE_DIR)/i2c-adm1032eb.o
endif

----------------------------
revision 1.23
date: 2003/12/24 16:40:39;  author: khali;  state: Exp;  lines: +5 -2
(Khali) Remove -o and -g args to install, as was done for lm_sensors
        by mds on suggestion by Haakon Riiser.
