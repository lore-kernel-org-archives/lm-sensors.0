From: mlybarger@gmail.com (Mark Lybarger)
Date: Fri, 07 Apr 2006 01:30:20 +0000
Subject: [lm-sensors] netfinity 6000r crash running sensors-detect
Message-Id: <a0fb11cc0604061830p1fa2b583ncce954706af98b94@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <a0fb11cc0604031304m792d8a8oef1f1a81c10e23ad@mail.gmail.com>
In-Reply-To: <a0fb11cc0604031304m792d8a8oef1f1a81c10e23ad@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

here's the output from when it crashed.  note that the sensors modules
were all loaded, but sensors wasn't working.  also, the box doesn't
come up so cleanly after it crashes.
arabica mark # sensors
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!
For older kernels, make sure you have done 'modprobe i2c-proc'!
arabica mark # lsmod
Module                  Size  Used by
i2c_dev                10112  0
nfs                   187588  1
lockd                  57736  2 nfs
sunrpc                137660  3 nfs,lockd
lm92                   10384  0
eeprom                  7696  0
pcspkr                  3076  0
rtc                     9748  0
parport_pc             37572  0
parport                33864  1 parport_pc
floppy                 57188  0
i2c_piix4               9488  0
i2c_savage4             4740  0
i2c_algo_bit            9352  1 i2c_savage4
i2c_core               20736  5 i2c_dev,lm92,eeprom,i2c_piix4,i2c_algo_bit
pcnet32                27780  0
mii                     6272  1 pcnet32
sworks_agp              9888  0
agpgart                33484  1 sworks_agp
dm_mirror              21200  0
dm_mod                 53656  1 dm_mirror
sbp2                   22788  0
ohci1394               32052  0
ieee1394               91704  2 sbp2,ohci1394
sl811_hcd              13056  0
ohci_hcd               19972  0
uhci_hcd               30992  0
usb_storage            67264  0
usbhid                 43872  0
ehci_hcd               29192  0
usbcore               115460  7
sl811_hcd,ohci_hcd,uhci_hcd,usb_storage,usbhid,ehci_hcd
arabica mark # sensors-detect
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
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:0f.0: ServerWorks OSB4 South Bridge
Use driver `i2c-savage4' for device 00:06.0: S3 Savage 4
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-piix4' already loaded.
Module `i2c-savage4' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

  To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
  specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus PIIX4 adapter at 0440
Do you want to scan it? (YES/no/selectively):
Client found at address 0x21
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Client found at address 0x22
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Client found at address 0x23
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Client at address 0x50 can not be probed - unload all client drivers first!
Client at address 0x51 can not be probed - unload all client drivers first!
Client found at address 0x52



On 4/5/06, Rudolf Marek <r.marek at sh.cvut.cz> wrote:
> Mark Lybarger wrote:
> > running sensors-detect on my system causes it to crash. i have a
> > netfinity 6000r machine, quad p4, 4gb ram.
>
> What sage the crash occurs please? When you probe this ISA bus or SMBus?
> What exactly is the last thing you can see on screen?
>
> (Can you run sensors-detect and find out please?)
>
> Please can you check manuals if there is something about IMPI or BMC?
> Can you see temps in bios?
>
> Thanks,
>
> Regards
> Rudolf
>

