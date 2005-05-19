From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: Issues with Arima HDAMA Opteron Motherboard
Message-Id: <3F948371.2090105@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E13FD85@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E13FD85@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The problem is that the i2c-amd756 driver doesn't have the PCI entries 
for the AMD8111 in it.  The AMD8111 has *two* SMBus interfaces on it. 
One is SMBus 2.0 and the other is the amd756 compatible bus that most 
commonly has devices connected to it.

 >>Load `i2c-amd756' (say NO if built into your kernel)? (YES/no):
 >>/lib/modules/2.4.19MARi2c-NUMA/kernel/drivers/i2c/busses/i2c-amd756.o: init_module: No such device
 >>Hint: insmod errors can be caused by incorrect module parameters, 
including invalid IO or IRQ parameters.
 >>      You may find more information in syslog or the output from dmesg
 >>/lib/modules/2.4.19MARi2c-NUMA/kernel/drivers/i2c/busses/i2c-amd756.o: insmod /lib/modules/2.4.19MARi2c-NUMA/kernel/drivers/i2c/busses/i2c-amd756.o failed
 >>/lib/modules/2.4.19MARi2c-NUMA/kernel/drivers/i2c/busses/i2c-amd756.o: insmod i2c-amd756 failed
 >>Loading failed... skipping.

So it fails to attach to the chip and you don't have the BUS you need to 
see the devices.

I've been meaning to submit a patch for this, but I haven't had the time 
to get one together.  The patch is very simple.

:v)

Mark Studebaker wrote:
> no you don't need i2c-algo-biths.
> You can use 'make -k' to keep going after an error.
> 
> Try rmmoding the amd8111 module, then running sensors-detect again,
> then saying no when it asks to load it, but say yes to the 756 module.
> Also see if there is any info in dmesg if it fails to load.
> 
> Marc Rieffel wrote:
> 
>>[Correction:  This system has an ADM1026 chip, not a Sinbond chip.]
>>
>>I'm having trouble with i2c and lm_sensors on my dual Opteron Arima motherboard.  This has an AMD 8111 chip and an ADM 1026jst chip.  I'm running 64-bit SuSE.
>>
>>When I try to build i2c, I get an error,
>>
>>gcc -I/lib/modules/2.4.19MARi2c-NUMA/build/include -nostdinc -I /usr/lib64/gcc-lib/x86_64-suse-linux/3.2.2/include -Wall -O2 -DLM_SENSORS -D__KERNEL__ -DMODULE -fomit-frame-pointer -DEXPORT_SYMTAB -fno-strict-aliasing -fno-common -fomit-frame-pointer -mno-red-zone -mcmodel=kernel -fno-reorder-blocks -finline-limit 00 -fno-strength-reduce -c kernel/i2c-algo-biths.c -o kernel/i2c-algo-biths.o
>>/tmp/ccP00QFi.s: Assembler messages:
>>/tmp/ccP00QFi.s:1424: Error: Incorrect register `%rdx' used with `l' suffix
>>make: *** [kernel/i2c-algo-biths.o] Error 1
>>
>># gcc -v
>>Reading specs from /usr/lib64/gcc-lib/x86_64-suse-linux/3.2.2/specs
>>Configured with: ../configure --enable-threads=posix --prefix=/usr --with-local-prefix=/usr/local --infodir=/usr/share/info --mandir=/usr/share/man --libdir=/usr/lib64 --enable-languages=c,c++,f77,objc,java,ada --enable-libgcj --with-gxx-include-dir=/usr/include/g++ --with-slibdir=/lib --with-system-zlib --enable-shared --enable-__cxa_atexit x86_64-suse-linux
>>Thread model: posix
>>gcc version 3.2.2 (SuSE Linux)
>>
>># uname -a
>>Linux gb0008 2.4.19MARi2c-NUMA #2 Fri Oct 17 06:39:18 PDT 2003 x86_64 unknown
>>
>>I don't know if I need this module or not.  If I disable i2c-algo-biths in kernel/Module.mk, then I'm able to compile,
>>
>>< ifneq ($(shell if grep -q '^CONFIG_I2C_ALGOBITHS=y' $(LINUX)/.config; then echo 1; fi),1)
>>< KERNELTARGETS += $(MODULE_DIR)/i2c-algo-biths.o
>>< KERNELINCLUDES += $(MODULE_DIR)/i2c-algo-biths.h
>>< endif
>>---
>>
>>>#ifneq ($(shell if grep -q '^CONFIG_I2C_ALGOBITHS=y' $(LINUX)/.config; then echo 1; fi),1)
>>>#KERNELTARGETS += $(MODULE_DIR)/i2c-algo-biths.o
>>>#KERNELINCLUDES += $(MODULE_DIR)/i2c-algo-biths.h
>>>#endif
>>
>>lm_sensors compiles OK.  I can't detect any sensors, though:
>>
>>gb0008:/tmp/marc/lm_sensors-2.8.1 # prog/detect/sensors-detect
>>
>>This program will help you determine which I2C/SMBus modules you need to
>>load to use lm_sensors most effectively. You need to have i2c and
>>lm_sensors installed before running this program.
>>Also, you need to be `root', or at least have access to the /dev/i2c-*
>>files, for most things.
>>If you have patched your kernel and have some drivers built-in, you can
>>safely answer NO if asked to load some modules. In this case, things may
>>seem a bit confusing, but they will still work.
>>
>> System vendor (DMI): AMD
>> BIOS version (DMI): PMLC00-7
>> We can start with probing for (PCI) I2C or SMBus adapters.
>> You do not need any special privileges for this.
>> Do you want to probe now? (YES/no):
>>gb0008:/tmp/marc/lm_sensors-2.8.1 # lsmod|grep i2
>>i2c-proc                9608   0
>>i2c-dev                 5792   0
>>i2c-core               23460   0  [i2c-proc i2c-dev]
>>gb0008:/tmp/marc/lm_sensors-2.8.1 # rmmod i2c-proc i2c-dev
>>gb0008:/tmp/marc/lm_sensors-2.8.1 # prog/detect/sensors-detect
>>
>>This program will help you determine which I2C/SMBus modules you need to
>>load to use lm_sensors most effectively. You need to have i2c and
>>lm_sensors installed before running this program.
>>Also, you need to be `root', or at least have access to the /dev/i2c-*
>>files, for most things.
>>If you have patched your kernel and have some drivers built-in, you can
>>safely answer NO if asked to load some modules. In this case, things may
>>seem a bit confusing, but they will still work.
>>
>> System vendor (DMI): AMD
>> BIOS version (DMI): PMLC00-7
>> We can start with probing for (PCI) I2C or SMBus adapters.
>> You do not need any special privileges for this.
>> Do you want to probe now? (YES/no):
>>Probing for PCI bus adapters...
>>Use driver `i2c-amd8111' for device 00:07.2: AMD-8111 SMBus 2.0
>>Use driver `i2c-amd756' for device 00:07.3: AMD-8111 ACPI
>>Probe succesfully concluded.
>>
>> We will now try to load each adapter module in turn.
>>Load `i2c-amd8111' (say NO if built into your kernel)? (YES/no):
>>Module loaded succesfully.
>>Load `i2c-amd756' (say NO if built into your kernel)? (YES/no):
>>/lib/modules/2.4.19MARi2c-NUMA/kernel/drivers/i2c/busses/i2c-amd756.o: init_module: No such device
>>Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.
>>      You may find more information in syslog or the output from dmesg
>>/lib/modules/2.4.19MARi2c-NUMA/kernel/drivers/i2c/busses/i2c-amd756.o: insmod /lib/modules/2.4.19MARi2c-NUMA/kernel/drivers/i2c/busses/i2c-amd756.o failed
>>/lib/modules/2.4.19MARi2c-NUMA/kernel/drivers/i2c/busses/i2c-amd756.o: insmod i2c-amd756 failed
>>Loading failed... skipping.
>> Do you now want to be prompted for non-detectable adapters? (yes/NO):
>> To continue, we need module `i2c-dev' to be loaded.
>> If it is built-in into your kernel, you can safely skip this.
>> i2c-dev is not loaded. Do you want to load it now? (YES/no):
>> Module loaded succesfully.
>>
>> We are now going to do the adapter probings. Some adapters may hang halfway
>> through; we can't really help that. Also, some chips will be double detected;
>> we choose the one with the highest confidence value in that case.
>> If you found that the adapter hung after probing a certain address, you can
>> specify that address to remain unprobed. That often
>> includes address 0x69 (clock chip).
>>
>>Next adapter: SMBus2 AMD8111 adapter at 1000 (Non-I2C SMBus 2.0 adapter)
>>Do you want to scan it? (YES/no/selectively):
>>Client found at address 0x08
>>
>> Some chips are also accessible through the ISA bus. ISA probes are
>> typically a bit more dangerous, as we have to write to I/O ports to do
>> this.  Do you want to scan the ISA bus? (YES/no):
>>Probing for `National Semiconductor LM78'
>>  Trying address 0x0290... Failed!
>>Probing for `National Semiconductor LM78-J'
>>  Trying address 0x0290... Failed!
>>Probing for `National Semiconductor LM79'
>>  Trying address 0x0290... Failed!
>>Probing for `Winbond W83781D'
>>  Trying address 0x0290... Failed!
>>Probing for `Winbond W83782D'
>>  Trying address 0x0290... Failed!
>>Probing for `Winbond W83627HF'
>>  Trying address 0x0290... Failed!
>>Probing for `Winbond W83697HF'
>>  Trying address 0x0290... Failed!
>>Probing for `Silicon Integrated Systems SIS5595'
>>  Trying general detect... Failed!
>>Probing for `VIA Technologies VT82C686 Integrated Sensors'
>>  Trying general detect... Failed!
>>Probing for `VIA Technologies VT8231 Integrated Sensors'
>>  Trying general detect... Failed!
>>Probing for `ITE IT8705F / IT8712F / SiS 950'
>>  Trying address 0x0290... Failed!
>>Probing for `IPMI BMC KCS'
>>  Trying address 0x0ca0... Failed!
>>Probing for `IPMI BMC SMIC'
>>  Trying address 0x0ca8... Failed!
>>
>> Some Super I/O chips may also contain sensors. Super I/O probes are
>> typically a bit more dangerous, as we have to write to I/O ports to do
>> this.  Do you want to scan for Super I/O sensors? (YES/no):
>>Probing for `SMSC 47M10x Super IO Fan Sensors'
>>  Failed! (0xe1)
>>Probing for `SMSC 47M14x Super IO Fan Sensors'
>>  Failed! (0xe1)
>>Probing for `VT1211 Super IO Sensors'
>>  Failed! (0xe1)
>>Probing for `Winbond W83627HF Super IO Sensors'
>>  Failed! (0xe1)
>>Probing for `Winbond W83627THF Super IO Sensors'
>>  Failed! (0xe1)
>>Probing for `Winbond W83697HF Super IO Sensors'
>>  Failed! (0xe1)
>>
>> Sorry, no chips were detected.
>> Either your sensors are not supported, or they are
>> connected to an I2C bus adapter that we do not support.
>> See doc/FAQ, doc/lm_sensors-FAQ.html, or
>> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
>> (FAQ #4.24.3) for further information.
>> If you find out what chips are on your board, see
>> http://secure.netroedge.com/~lm78/newdrivers.html for driver status.
>>
>>When I try to manually insert the adm1026 module, it inserts but finds nothing,
>>
>># modprobe adm1026
>>
>>adm1026: Version 2.8.1 (20031005)
>>adm1026: See http://www.penguincomputing.com/lm_sensors for more info.
>>
>> # /usr/local/bin/sensors
>>No sensors found!
>>
>>Any suggestions?
>>
>>Thanks.
> 
> 



-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
