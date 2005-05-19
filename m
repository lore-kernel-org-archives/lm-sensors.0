From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: adm1021, PU-DLS ASUS
Message-Id: <3EC534DE.1000600@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

See below...

Zeno R.R. Davatz wrote:

> On Fri, 2003-05-16 at 18:09, Philip Pokorny wrote:
> 
> 
>>    modprobe i2c-i801
>>
> gives me:
> /lib/modules/2.4.20/lm-sensors/i2c-i801.o: init_module: No such device
> Hint: insmod errors can be caused by incorrect module parameters,
> including invalid IO or IRQ parameters.
>       You may find more information in syslog or the output from dmesg
> /lib/modules/2.4.20/lm-sensors/i2c-i801.o: insmod
> /lib/modules/2.4.20/lm-sensors/i2c-i801.o failed
> /lib/modules/2.4.20/lm-sensors/i2c-i801.o: insmod i2c-i801 failed
> 
> the log tells me:
> May 16 18:10:47 whitie kernel: i2c-i801.o version 2.7.0 (20021208)
> May 16 18:10:47 whitie kernel: i2c-i801.o: Error: Can't detect I801,
> function 3!
> May 16 18:10:47 whitie kernel: i2c-i801.o: I801 not detected, module not
> inserted.


Until you get this working, I doubt that you'll be able to access the on-board 
monitoring chip...

Is there an area in the BIOS where you can see the monitoring chip results? 
Perhaps it will display the voltages and CPU temperatures?  While you are in 
the BIOS, look for something that might be disabling the on-board SMBus or 
sensors.

See my answer to your question below for more information.


>>    modprobe i2c-isa
>>
> worked fine.


Some motherboards have sensor chips on the ISA bus.  Yours doesn't (based on 
what we see below) so you don't need to do this in the future...

>>Then run 'sensors' and see if you've found your chips.
>>
> gives me:
> adm1021-i2c-0-2d
> Adapter: ELV Parallel port adaptor
> Algorithm: Bit-shift algorithm
> Board:        -1?C  (min =   -1?C, max =   -1?C)ALARM (LOW,HIGH)
> CPU:          -1?C  (min =   -1?C, max =   -1?C)ALARM (N/A,LOW)
> die_code:  255


That's just wrong and probably caused by the broken loading of i2c-elv.

>>When replying, please include the output from:
>>
>>    ls -1 /proc/sys/dev/sensors
>>
> gives me:
> adm1021-i2c-0-2d
> chips
> 
> 
>>and
>>
>>    cat /proc/sys/dev/sensors/chips
>>
> gives me:
> 256     adm1021-i2c-0-2d
> 
> 
>>Have you run 'sensors-detect'?  What was the output?
>>
> - Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Sorry, no PCI bus adapters found.
> 
> ..
> 
> The ELV Parallel hangs. Top gives me 99.9% CPU usage.


This strongly suggests that you NOT load the elv driver.  You don't have one 
of these interfaces on the board and it's causing you problems.

     rmmod i2c-elv

and don't probe for it again.

> ISA bus gives me:
> Probing for `National Semiconductor LM78'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM78-J'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM79'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83781D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83782D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83627HF'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83697HF'
>   Trying address 0x0290... Failed!
> Probing for `Silicon Integrated Systems SIS5595'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT82C686 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT8231 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'
>   Trying address 0x0290... Failed!
> Probing for `IPMI BMC KCS'
>   Trying address 0x0ca0... Failed!
> Probing for `IPMI BMC SMIC'
>   Trying address 0x0ca8... Failed!
> 
> 
> Why would i2c-i801 not be loadable?


There are three possible reasons:

1. Your motherboard really doesn't have it.  In which case you probably don't 
have any sensors.

2. The BIOS hasn't enabled it.  It doesn't show up in your LSPCI output.  I 
expect you should be looking for a device with PCI ID 2483.  It will be on PCI 
BUS 0.  The other devices are there (2482, 2484, 2487, 2480, 248b) so perhaps 
the BIOS has disabled it.

00:00.0 Host bridge: Intel Corp.: Unknown device 254c (rev 01)
00:02.0 PCI bridge: Intel Corp.: Unknown device 2543 (rev 01)
00:1d.0 USB Controller: Intel Corp.: Unknown device 2482 (rev 02)
00:1d.1 USB Controller: Intel Corp.: Unknown device 2484 (rev 02)
00:1d.2 USB Controller: Intel Corp.: Unknown device 2487 (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev
42)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 2480 (rev 02)
00:1f.1 IDE interface: Intel Corp.: Unknown device 248b (rev 02)

3. Your motherboard is broken.  The chip is faulty and the SMBus function is 
not working.  If you get voltages, temperatures and fan speeds in the BIOS, 
that would elminate this cause.

> Thanks for your time and help.


:v)
