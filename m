From: aragorn@tiscali.nl (Frans Pop)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: [patch] Ticket #1782: Enabling SMBus for Toshiba Satellite A40-211
Message-Id: <200409211812.13479.aragorn@tiscali.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(Ticket was answered by Khali 2004-09-21)
(Please CC me as I'm not a member of the list)

Thanks very much for the information you provided in the ticket.

With that start and a bit of further research, I've managed to enable the 
SMBus and am now getting readings from lm90 and eeprom sensors :-)
It's a pity the lm90 does not include FAN-readings, but well...

$ lspci
<snip>
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus 
Controller (rev 03)
</snip>

$ sensors
eeprom-i2c-0-51
Adapter: SMBus I801 adapter at d880
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at d880
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

adm1032-i2c-0-4c
Adapter: SMBus I801 adapter at d880
M/B Temp:    +35?C  (low  =   -65?C, high =  +127?C)
CPU Temp:  +33.9?C  (low  = +28.0?C, high = +72.0?C)
M/B Crit:   +127?C  (hyst =  +122?C)
CPU Crit:    +82?C  (hyst =   +77?C)
(I guess I'll have to adjust the limits a bit :-)

I have attached the output of sensors-detect, about which I have one 
question. The adm1021 is 'misdetected' with confidence 3.
Should I just ignore this or could it be that sensor is present?

I've also attached a patch for drivers/pci/quirks.c based on Debian's 2.6.7 
kernel sources.
As I needed to check for a different subsystem_vendor (and as I really don't 
know C), I have just copied the functions that were present. I would guess 
however that it would be nicer to integrate my test into the 'asus' 
functions and provide bit more general way to add new cases.
I hope you can finalize the patch and can get it included in the kernel.

Thanks again,
Frans Pop
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors-detect.txt.gz
Type: application/x-gzip
Size: 2209 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040921/44447a38/sensors-detect.txt.gz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: quirks.c.patch
Type: text/x-diff
Size: 1994 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040921/44447a38/quirks.c.bin
