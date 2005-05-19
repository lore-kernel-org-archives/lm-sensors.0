From: adc@angstrom.com (Atish Datta Chowdhury)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: adm1026 on dual opteron : No sensors Found
Message-Id: <1053468785.3ecaa871cebf7@rand.angstrom.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
       Appreciate any help on getting an adm1026 on a dual opteron
working. I am listing my observtions below. 'Will be grateful for
any solution to this..:

     Problem summary:
     ----------------

     Motherboard : Arima (BIOS 1.50) dual opteron

     When using lm_sensors with the patch from penguincomputing (Philip
Pokorney), the adm1026 can be detected by sensors-detect, but even after
     a correct build and install of the suggested modules, we get the 
     following error upon running sensors:
     "No sensors found"

     Possible cause:
     ---------------

     We did not see the adm1026 either under /proc/sys/dev or /proc/bus/i2c
     The modules loaded at the time of running sensors were:
     i2c-core, i2c-dev, i2c-proc, i2c-amd756, adm1026.
     Are there patches (e.g to adm1026 or i2c-proc) that we are missing?

     Detailed description:
     ----------------------

     1) downloaded i2c-2.7.0 and lm_sensors 2.7.0 from
     http://www2.lm-sensors.nu/~lm78/download.html
     2) patch adm1026 on to lm_Sensors-2.7.0 from  
ftp.penguincomputing.com/pub/updates/lmsensors/lm_sensors-2.7.0-adm1026-9.patch
     
     3) Build (64 bit) against 2.4.19 (Suse's distribution : United Linux 1.0))
        builds with nominal problems
     4) Install  (both i2c and lm_sensors)
     5) sensors-detect finds adm1026 off the SMBus AMD8111 adapter
        and lists i2c-amd756,  adm1026.
     6) insmod modules i2c-core, i2c-dev, i2c-porc, i2c-isa , i2c-amd756 and
     adm1026:

     i2c-core.o: i2c core module version 2.7.0 (20021208)
     i2c-dev.o: i2c /dev entries driver module version 2.7.0 (20021208)
     i2c-proc.o version 2.7.0 (20021208)
     i2c-amd756.o version 2.7.0 (20021208)
     i2c-amd756.o: Found AMD8111 SMBus controller.
     adm1026: Version 2.7.0 (20021208)
     adm1026: See http://www.penguincomputing.com/lm_sensors for more info.

     7) "sensors" gives:
     No sensors found!

-thanks and regards,
Atish

Atish Datta Chowdhury
Software Engineer
Angstrom Microsystems
