From: dieter.jurzitza@t-online.de (Dieter Jurzitza)
Date: Sat, 02 Sep 2006 17:29:30 +0000
Subject: [lm-sensors] Question on piix4
Message-Id: <200609021929.30351.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear listmembers,
can some gentle person give me some insight in how to understand the following 
messages:
Sep  2 13:04:06 linux kernel: piix4_smbus 0000:00:0f.0: Found 0000:00:0f.0 
device
Sep  2 13:04:06 linux kernel: piix4_smbus 0000:00:0f.0: Unusual config 
register value
Sep  2 13:04:06 linux kernel: piix4_smbus 0000:00:0f.0: Try using fix_hstcfg=1 
if you experience problems
Sep  2 13:04:06 linux kernel: piix4_smbus 0000:00:0f.0: Illegal Interrupt 
configuration (or code out of date)!
Is this potentially harmful? Should I do something about it?
I reinserted the module with parameter fix_hstcfg=1, sensors-detect finds no 
devices but it says:
******
Next adapter: SMBus PIIX4 adapter at 0580
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x03
Client found at address 0x04
Client found at address 0x05
Client found at address 0x06
Client found at address 0x07
Client found at address 0x08
Client found at address 0x09
Probing for `Smart Battery Charger'... Failed!
Client found at address 0x0a
Probing for `Smart Battery Manager/Selector'... Failed!
Client found at address 0x0b
Probing for `Smart Battery'... Failed!
Client found at address 0x0c
Client found at address 0x0d
Client found at address 0x0e
Client found at address 0x0f
*****
What do I know when seeing "Client found at address XXXX"?
Thank you very much in helping understand,
take care


Dieter Jurzitza

-- 
-----------------------------------------------------------

                               |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <??__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------

