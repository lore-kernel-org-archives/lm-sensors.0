From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: lm_sensors on Itanium
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E3E29EF@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've attached the output from dmidecode 2.3, in case it's of use.  

I can't load SMSC47m1:

[root@gb0010 lm_sensors-2.8.4]# modprobe smsc47m1
/lib/modules/2.4.18-e.12MARsmp.mr18k/kernel/drivers/i2c/chips/smsc47m1.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.18-e.12MARsmp.mr18k/kernel/drivers/i2c/chips/smsc47m1.o: insmod /lib/modules/2.4.18-e.12MARsmp.mr18k/kernel/drivers/i2c/chips/smsc47m1.o failed
/lib/modules/2.4.18-e.12MARsmp.mr18k/kernel/drivers/i2c/chips/smsc47m1.o: insmod smsc47m1 failed

I can load adm1026, but it doesn't seem to have any effect, perhaps because it's missing a bridge chip or something,

[root@gb0010 lm_sensors-2.8.4]# modprobe adm1026
[root@gb0010 lm_sensors-2.8.4]# cat /proc/sys/dev/sensors/chips

[root@gb0010 lm_sensors-2.8.4]# lsmod|grep adm
adm1026                36952   0  (unused)
i2c-proc               20336   0  [adm1026]
i2c-core               44048   0  [adm1026 i2c-proc i2c-algo-bit i2c-dev]

Also, here's what I get when I try to load non-detectable adapters.  If I let it scan " ELV Parallel port adaptor (Bit-shift algorithm)", it goes into space until I kill it.


[root@gb0010 lm_sensors-2.8.4]# prog/detect/sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Sorry, no PCI bus adapters found.

 We will now try to load each adapter module in turn.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): yes
Load `i2c-elektor' (say NO if built into your kernel)? (YES/no):
modprobe: Can't locate module i2c-elektor
Loading failed... skipping.
Load `i2c-elv' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
Load `i2c-philips-par' (say NO if built into your kernel)? (YES/no):
modprobe: Can't locate module i2c-philips-par
Loading failed... skipping.
Load `i2c-velleman' (say NO if built into your kernel)? (YES/no):
/lib/modules/2.4.18-e.12MARsmp.mr18k/kernel/drivers/i2c/i2c-velleman.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.18-e.12MARsmp.mr18k/kernel/drivers/i2c/i2c-velleman.o: insmod /lib/modules/2.4.18-e.12MARsmp.mr18k/kernel/drivers/i2c/i2c-velleman.o failed
/lib/modules/2.4.18-e.12MARsmp.mr18k/kernel/drivers/i2c/i2c-velleman.o: insmod i2c-velleman failed
Loading failed... skipping.
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: ELV Parallel port adaptor (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively): no

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Some Super I/O chips may also contain sensors. Super I/O probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x5101)
Probing for `SMSC 47M10x Super IO Fan Sensors'
  Failed! (0x51)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x51)
Probing for `VT1211 Super IO Sensors'
  Failed!
Probing for `Winbond W83627HF Super IO Sensors'
  Failed!
Probing for `Winbond W83627THF Super IO Sensors'
  Failed!
Probing for `Winbond W83637HF Super IO Sensors'
  Failed!
Probing for `Winbond W83697HF Super IO Sensors'
  Failed!
Probing for `Winbond W83697UF Super IO PWM'
  Failed!

 Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.
 See doc/FAQ, doc/lm_sensors-FAQ.html, or
 http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
 (FAQ #4.24.3) for further information.
 If you find out what chips are on your board, see
 http://secure.netroedge.com/~lm78/newdrivers.html for driver status.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dmidecode.out
Type: application/octet-stream
Size: 14104 bytes
Desc: dmidecode.out
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040302/8edfcd69/dmidecode.obj
