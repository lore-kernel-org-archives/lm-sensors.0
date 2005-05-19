From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: eeprom driver
Message-Id: <20020201105452.C1871@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


You can read the contents of the eeproms more directly my looking in
the directories /proc/sys/dev/sensors/*eeprom*.  It is possible that
that slot is having issues.  Although your computer sounds like it is
running correctly??  If the eeprom(s) were unreadable, then at least
that DIMM would not be used for RAM for the system since the DIMM
contains the timings and such.


Phil

On Fri, Feb 01, 2002 at 07:31:43PM +0100, Jean Delvare wrote:
> 
> Hello
> 
> I'm using your i2c/lm_sensors eeprom driver and it seems there is
> something not working in my case.
> 
> The system is a Sony Vaio laptop (PCG-GR214EP) recently bought in France.
> The only thing sensors(-detect) will see are the memory slots. There are
> two SO-DIMM slots.
> 
> sensors-detect will see them, first with confidence 8, second with
> confidence 1 only.
> 
> When then running sensors, the first slot is read correctly :
> 
> eeprom-i2c-0-50
> Adapter: SMBus I801 adapter at 1880
> Algorithm: Non-I2C SMBus adapter
> Memory type :         SDRAM DIMM SPD
> SDRAM Size (MB):      256
> 
> But the second slot won't show anything :
> 
> eeprom-i2c-0-57
> Adapter: SMBus I801 adapter at 1880
> Algorithm: Non-I2C SMBus adapter
> 
> If I swap the two memory chips I own (128Mb and 256Mb), the first slot
> will say 128, and the second one keep silent, so the issue is a slot-level
> one.
> 
> I guess that something is not-standard with the second slot, which
> explains why the confidence level was that low. I'm willing to help you
> analyse the problem and find out how to solve it.
> 
> If it helps, loaded modules are :
> 
> eeprom
> i2c-proc
> i2c-i801
> i2c-core
> 
> and /proc/bus contains :
> 
> i2c
> i2c-0
> 
> cat i2c says :
> 
> i2c-0   smbus          SMBus I801 adapter at 1880   Non-I2C SMBus adapter
> 
> cat i2c-0 says :
> 
> cat: i2c-0: Invalid argument
> 
> If you want me to run tests, debug something... just tell me what to do. I
> think I got the required skills.
> 
> Thanks.
> 
> -- 
>        /~~       Jean "Khali" Delvare
>   -----\_                        mail: delvare@ensicaen.ismra.fr
>  --------\                http://www.ensicaen.ismra.fr/~delvare/
> ---=ISMRA/- ____________________________________________________

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
