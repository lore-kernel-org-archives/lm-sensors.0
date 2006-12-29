From: liontooth@cogweb.net (David Liontooth)
Date: Fri, 29 Dec 2006 18:36:14 +0000
Subject: [lm-sensors] ADT7476
Message-Id: <4595601E.4020303@cogweb.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4592F578.3020503@cogweb.net>
In-Reply-To: <4592F578.3020503@cogweb.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David Liontooth wrote:
> David Liontooth wrote:
>   
>> What's the status of support for the ADT7476?
>>
>> Driver `to-be-written' (should be inserted):
>>   Detects correctly:
>>   * Bus `SMBus PIIX4 adapter at 0580'
>>     Busdriver `i2c-piix4', I2C address 0x2e
>>     Chip `Analog Devices ADT7476' (confidence: 7)
>>
>> I have these on Tyan Tomcat K8SH (S3850G2NR) motherboards and am happy
>> to provide details.
>>     

# i2cdump 0 0x2e b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2e, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: c0 70 bf c1 c1 29 20 22 ff ff c1 06 57 04 ff ff    ?p???) "..??W?..
30: ff ff ff 00 00 00 00 00 ff ff ff 00 00 76 41 69    .............vAi
40: 05 00 00 0a 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ?..?..........??
50: 81 7f 81 7f ff ff ff ff ff ff ff ff 62 62 62 aa    ????........bbb?
60: aa aa 00 00 80 80 80 5a 5a 5a 64 64 64 44 40 00    ??..???ZZZdddD at .
70: 00 00 f8 00 00 00 86 9b 00 00 00 55 01 00 00 00    ..?...??...U?...
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

For comparison, here is what Reuben Farrelly 
<mailto:lm-sensors%40lm-sensors.org?Subject=%5Blm-sensors%5D%20Analogue%20Devices%20ADT7476ARQZ%20chip%20status&In-Reply-To 051126105212.51a1b259.khali%40linux-fr.org>posted
on Nov 26, 2005:

[root at typhoon <http://lists.lm-sensors.org/mailman/listinfo/lm-sensors> ~]# i2cdump 0 0x2e b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2e, mode byte
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 77 6c c3 c5 be 36 29 27 62 0c 57 0d 46 36 ff ff    wl???6)'b?W?F6..
30: 33 4c 4c 00 00 00 00 00 ff ff ff 00 00 76 41 69    3LL..........vAi
40: 05 00 00 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ?.............??
50: 81 7f 81 7f ff ff ff ff ff ff ff ff 02 22 22 7a    ????........?""z
60: 8a 80 e8 88 33 4c 4c 38 2d 2d 45 41 41 24 40 00    ????3LL8--EAA$@.
70: 00 00 00 00 00 00 1a 23 f0 00 00 55 01 00 00 00    ......?#?..U?...
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................

http://lists.lm-sensors.org/pipermail/lm-sensors/2005-November/014454.html

Descriptions of the  Tyan S3850G2NR Tomcat K8SH Opteron 939 Motherboard
(e.g., http://www.digiconcepts.com/tyan_motherboards_74.htm) confirm it
has the ADT7476.

The second request for support is at
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-June/016564.html,
with a summary at
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-June/016568.html.

Dave

> # uname -a
> Linux 2.6.19.1 #1 SMP Mon Dec 18 14:33:18 PST 2006 x86_64 GNU/Linux
>
> OS is Debian sid, the kernel is the latest stable from kernel.org
> compiled with gcc 4.1.
>
> # lspci
> 00:01.0 PCI bridge: Broadcom HT1000 PCI/PCI-X bridge
> 00:02.0 Host bridge: Broadcom HT1000 Legacy South Bridge
> 00:02.1 IDE interface: Broadcom HT1000 Legacy IDE controller
> 00:02.2 ISA bridge: Broadcom HT1000 LPC Bridge
> 00:03.0 USB Controller: Broadcom HT1000 USB Controller (rev 01)
> 00:03.1 USB Controller: Broadcom HT1000 USB Controller (rev 01)
> 00:03.2 USB Controller: Broadcom HT1000 USB Controller (rev 01)
> 00:04.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit
> Ethernet Controller (rev 05)
> 00:05.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit
> Ethernet Controller (rev 05)
> 00:06.0 VGA compatible controller: XGI - Xabre Graphics Inc Volari Z7
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> HyperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> DRAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Miscellaneous Control
> 01:0d.0 PCI bridge: Broadcom HT1000 PCI/PCI-X bridge (rev b2)
> 01:0e.0 RAID bus controller: Broadcom BCM5785 (HT1000) SATA Native SATA Mode
>
> # lsmod
> Module                  Size  Used by
> thermal                17296  0
> fan                     6280  0
> processor              22332  1 thermal
> eeprom                  8912  0
> i2c_isa                 7104  0
> i2c_dev                 9032  0
> ata_generic             9156  0
> evdev                  12160  0
> k8temp                  6976  0
> sata_svw               10180  2
> ehci_hcd               34760  0
> ohci_hcd               22596  0
> hwmon                   4296  1 k8temp
> e1000                 127296  0
> psmouse                43792  0
> i2c_piix4              10444  0
> pata_serverworks       12176  0
> i2c_core               25984  7 eeprom,i2c_isa,i2c_dev,i2c_piix4
>
> # ./sensors-detect.pl (downloaded from lm-sensors yesterday)
> # sensors-detect revision $Revision$
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-piix4' for device 0000:00:02.0: ServerWorks HT-1000
> South Bridge
>
> We will now try to load each adapter module in turn.
> Module `i2c-piix4' already loaded.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
>
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
>
> Next adapter: SMBus PIIX4 adapter at 0580 (i2c-0)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x1b
> Probing for `Maxim MAX6650/MAX6651'...                      No
> Probing for `Philips Semiconductors PCA9556'...             No
> Client found at address 0x2e
> Probing for `Myson MTP008'...                               No
> Probing for `National Semiconductor LM78'...                No
> Probing for `National Semiconductor LM78-J'...              No
> Probing for `National Semiconductor LM79'...                No
> Probing for `National Semiconductor LM80'...                No
> Probing for `National Semiconductor LM85 or LM96000'...     No
> Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... No
> Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'...        No
> Probing for `Analog Devices ADT7462'...                     No
> Probing for `Analog Devices ADT7467 or ADT7468'...          No
> Probing for `Analog Devices ADT7470'...                     No
> Probing for `Analog Devices ADT7473'...                     No
> Probing for `Analog Devices ADT7475'...                     No
> Probing for `Analog Devices ADT7476'...                     Success!
>     (confidence 7, driver `to-be-written')
> Probing for `Andigilog aSC7611'...                          No
> Probing for `Andigilog aSC7621'...                          No
> Probing for `National Semiconductor LM87'...                No
> Probing for `National Semiconductor LM93'...                No
> Probing for `Winbond W83781D'...                            No
> Probing for `Winbond W83782D'...                            No
> Probing for `Winbond W83792D'...                            No
> Probing for `Winbond W83793R/G'...                          No
> Probing for `Winbond W83791SD'...                           No
> Probing for `Winbond W83627HF'...                           No
> Probing for `Winbond W83627EHF'...                          No
> Probing for `Winbond W83627DHG'...                          No
> Probing for `Asus AS99127F (rev.1)'...                      No
> Probing for `Asus AS99127F (rev.2)'...                      No
> Probing for `Asus ASB100 Bach'...                           No
> Probing for `Winbond W83L785TS-S'...                        No
> Probing for `Analog Devices ADM9240'...                     No
> Probing for `Dallas Semiconductor DS1780'...                No
> Probing for `National Semiconductor LM81'...                No
> Probing for `Analog Devices ADM1026'...                     No
> Probing for `Analog Devices ADM1025'...                     No
> Probing for `Analog Devices ADM1024'...                     No
> Probing for `Analog Devices ADM1029'...                     No
> Probing for `Analog Devices ADM1030'...                     No
> Probing for `Analog Devices ADM1031'...                     No
> Probing for `Analog Devices ADM1022'...                     No
> Probing for `Texas Instruments THMC50'...                   No
> Probing for `Analog Devices ADM1028'...                     No
> Probing for `ITE IT8712F'...                                No
> Probing for `SMSC DME1737'...                               No
> Probing for `Fintek F75373S/SG'...                          No
> Probing for `Fintek F75375S/SP'...                          No
> Probing for `Fintek F75387SG/RG'...                         No
> Probing for `Winbond W83791D'...                            No
> Client found at address 0x40
> Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
> Client found at address 0x50
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
> Client found at address 0x51
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
> Client found at address 0x69
> Client found at address 0x6c
>
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no):
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> Probing for `Winbond W83627HF' at 0x290...                  No
> Probing for `Silicon Integrated Systems SIS5595'...         No
> Probing for `VIA VT82C686 Integrated Sensors'...            No
> Probing for `VIA VT8231 Integrated Sensors'...              No
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `ITE'...                                      No
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `ITE'...                                      Yes
> Found unknown chip with ID 0xee19
> Trying family `National Semiconductor'...                   Yes
> Found `Nat. Semi. PC8741x Super IO'
>     (no hardware monitoring capabilities)
> Trying family `SMSC'...                                     Yes
> Found unknown chip with ID 0xee19
> Trying family `VIA/Winbond/Fintek'...                       Yes
> Found unknown chip with ID 0xee19
>
> Some CPUs or memory controllers may also contain embedded sensors.
> Do you want to scan for them? (YES/no):
> AMD K8 thermal sensors...                                   Success!
>     (driver `k8temp')
> Intel Core family thermal sensor...                         No
> Intel AMB FB-DIMM thermal sensor...                         No
>
>
>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>   


