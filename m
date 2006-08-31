From: devsku@gmail.com (Sunil Kumar)
Date: Thu, 31 Aug 2006 18:13:52 +0000
Subject: [lm-sensors] Is the Intel i945G supported/planned?
Message-Id: <ce9ef0d90608311113x1b3975e6xb6b3e558d527dcf@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90608291525r42520432gd67005073da32057@mail.gmail.com>
In-Reply-To: <ce9ef0d90608291525r42520432gd67005073da32057@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

$ sensors-detect
# sensors-detect revision 1.413 (2006/01/19 20:28:00)

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel ICH7
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): no
 Well, you will know best. We will just hope you edited `/etc/modules.conf'
 for automatic loading of this module. If not,
 you won't be able to open any /dev/i2c-* file (unless youhave it built-in
 into your kernel)

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no): YES
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
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8712F'
  Trying address 0x0290... Failed!
Probing for `ITE IT8705F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x7901)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x7901)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x7901)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `Nat. Semi. PC87591 Super IO'
  Failed! (0x79)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0x79)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0x79)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0x79)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0x79)
Probing for `Nat. Semi. PCPC87427 Super IO'
  Failed! (0x79)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x79)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x79)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x79)
Probing for `SMSC 47M15x/192/997 Super IO Fan Sensors'
  Failed! (0x79)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0x79)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0x79)
Probing for `SMSC 47M172 Super IO'
  Failed! (0x79)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0x79)
Probing for `SMSC SCH5307-NS Super IO'
  Failed! (0x79)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors? (YES/no): YES
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

 Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.
 See doc/FAQ, doc/lm_sensors-FAQ.html, or
 http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
 (FAQ #4.24.3) for further information.
 If you find out what chips are on your board, see
 http://secure.netroedge.com/~lm78/newdrivers.html for driver status.

I have i2c_dev in kernel, so I declined that.

Thanks for looking into this.
-Sunil

On 8/29/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:
>
> Hi Sunil,
>
> Please send us the output of sensors-detect
>
> Thanks
> regards
> Rudolf
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060831/c441d934/attachment-0001.html 
