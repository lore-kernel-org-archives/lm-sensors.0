From: dirk.p@dommel.be
Date: Sun, 12 May 2013 17:42:29 +0000
Subject: [lm-sensors] k10temp
Message-Id: <20130512194229.tceeg6ht8xokc884@webmail.dommel.be>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,



This is not dramatic, but I think the temperature returned by k10temp can n=
ot be
correct. The temperature is lower than the room temperature of 14=B0C and l=
ower
than the more realistic values reported by it8728.

sensors
fam15h_power-pci-00c4
Adapter: PCI adapter
power1:       41.56 W  (crit =3D 124.95 W)

it8728-isa-0228
Adapter: ISA adapter
in0:          +0.92 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in1:          +1.50 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in2:          +2.02 V  (min =3D  +0.00 V, max =3D  +3.06 V)
+3.3V:        +3.24 V  (min =3D  +0.00 V, max =3D  +6.12 V)
in4:          +1.93 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in5:          +1.26 V  (min =3D  +0.00 V, max =3D  +3.06 V)
in6:          +2.22 V  (min =3D  +0.00 V, max =3D  +3.06 V)
3VSB:         +3.38 V  (min =3D  +0.00 V, max =3D  +6.12 V)
Vbat:         +3.05 V
fan1:          15 RPM  (min =3D    0 RPM)
fan2:           0 RPM  (min =3D    0 RPM)
fan3:           0 RPM  (min =3D    0 RPM)
fan5:           0 RPM  (min =3D    0 RPM)
temp1:        +21.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D
thermistor
temp2:        +28.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermal
diode
temp3:        +19.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermal
diode
intrusion0:  OK

k10temp-pci-00c3
Adapter: PCI adapter
temp1:         +8.0=B0C  (high =3D +70.0=B0C)
                       (crit =3D +90.0=B0C, hyst =3D +87.0=B0C)


some system info
Linux version 3.7.10-gentoo

The 3 drivers build in the kernel, other sensors drivers compiled as module=
s.

  *-core
       description: Motherboard
       product: GA-970A-DS3
       vendor: Gigabyte Technology Co., Ltd.
       physical id: 0
       version: x.x
     *-firmware
          description: BIOS
          vendor: Award Software International, Inc.
          physical id: 0
          version: F6
          date: 10/23/2012
          size: 128KiB
          capacity: 4032KiB
          capabilities: isa pci pnp upgrade shadowing cdboot bootselect
socketedrom edd int13floppy360 int13floppy1200 int13floppy720 int13floppy28=
80
int5printscreen int9keyboard int14serial int17printer int10video acpi usb
ls120boot zipboot biosbootspecification
     *-cpu
          description: CPU
          product: AMD FX(tm)-8120 Eight-Core Processor
          vendor: Advanced Micro Devices [AMD]
          physical id: 4
          bus info: cpu@0
          version: AMD FX(tm)-8120 Eight-Core Processor
          slot: Socket M2
          size: 1400MHz
          capacity: 3200MHz
          width: 64 bits
          clock: 200MHz
capabilities: fpu fpu_exception wp vme de pse tsc msr pae mce cx8 apic sep =
mtrr
pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_=
opt
pdpe1gb rdtscp x86-64 constant_tsc rep_good nopl nonstop_tsc extd_apicid
aperfmperf pni pclmulqdq monitor ssse3 cx16 sse4_1 sse4_2 popcnt aes xsave =
avx
lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefet=
ch
osvw ibs xop skinit wdt lwp fma4 nodeid_msr topoext perfctr_core arat cpb
hw_pstate npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid
decodeassists pausefilter pfthreshold cpufreq
...
          *-display UNCLAIMED
                description: VGA compatible controller
                product: Turks XT [Radeon HD 6670]
                vendor: Advanced Micro Devices [AMD] nee ATI
                physical id: 0
                bus info: pci@0000:01:00.0
                version: 00
                width: 64 bits
                clock: 33MHz
                capabilities: pm pciexpress msi vga_controller bus_master
cap_list
                configuration: latency=3D0
                resources: memory:d0000000-dfffffff memory:fddc0000-fdddffff
ioport:de00(size=3D256) memory:fdd00000-fdd1ffff






Was also looking why I got no information from the Radion card. sensors-det=
ect
tells me

Using driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc
SB600/SB700/SB800 SMBus

but does not add that module in /etc/conf.d/lm_sensors
Every time I load module i2c-piix4 I get something like

[ 2952.162696] ACPI Warning: 0x0000000000000b00-0x0000000000000b07 SystemIO
conflicts with Region \SOR1 1 (20120913/utaddress-251)
[ 2952.162708] ACPI: If an ACPI driver is available for this device, you sh=
ould
use it instead of the native driver
in dmesg.

The wrong module or something not implemented by the OEM?



Thanks,


Dirk.





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
