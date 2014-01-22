From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Jan 2014 02:31:54 +0000
Subject: Re: [lm-sensors] sensors command now hangs
Message-Id: <52DF2D9A.2020400@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <52DD6890.1060301@gmail.com>
In-Reply-To: <52DD6890.1060301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 01/20/2014 10:18 AM, David Anderson wrote:
>
> For the last couple weeks a 'sensors' command hangs
> and never completes after a day or so of running.

Hi David,

key question ... what changed ? If it didn't hang before,
something must have changed.

> I have a cron script that runs sensors every hour
>   and logs chip temps.
> When that stops logging tells when sensors
> stopped completing. Those incomplete tasks hang around till reboot.
>
> Suggestions? Advice?  Thanks in advance for any help.
>
> Other than the sensors command things seem to run normally.
> 10 or 11 cores plus the GPU run 100%  doing
> boinc/seti@home and more.  Producing results that get verified
> by other folks.
>
>
>
> Ubuntu 13.10.
> Linux Dseti3 3.11.0-15-generic #23-Ubuntu SMP Mon Dec 9 18:17:04 UTC 2013=
 x86_64
>   x86_64 x86_64 GNU/Linux
> MOBO:  Supermicro Super X8DTN+  rev 2.00
>

This and information below suggests that IPMI is running in your system.
IPMI does not synchronize with other means accessing system hardware,
specifically in respect to environmental monitoring.

It might well be that IPMI software interferes with your monitoring code.
If you are running any IPMI application in parallel, you'll likely have to =
decide
one way or another. If you don't use IPMI but it is enabled, you might
want to consider disabling it.

Can you look into that ?

Thanks,
Guenter

> Outputs following:
> lspci -nn
> ic2detect -l  (this produces no output)
> dmesg
> lsmod
> sensors-detect
> sensors (right after reboot, when it does not hang).
>
>
>
> lspci -nn
>
> 00:00.0 Host bridge [0600]: Intel Corporation 5520 I/O Hub to ESI Port [8=
086:340
> 6] (rev 22)
> 00:01.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI Ex=
press R
> oot Port 1 [8086:3408] (rev 22)
> 00:03.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI Ex=
press R
> oot Port 3 [8086:340a] (rev 22)
> 00:05.0 PCI bridge [0604]: Intel Corporation 5520/X58 I/O Hub PCI Express=
 Root P
> ort 5 [8086:340c] (rev 22)
> 00:07.0 PCI bridge [0604]: Intel Corporation 5520/5500/X58 I/O Hub PCI Ex=
press R
> oot Port 7 [8086:340e] (rev 22)
> 00:09.0 PCI bridge [0604]: Intel Corporation 7500/5520/5500/X58 I/O Hub P=
CI Expr
> ess Root Port 9 [8086:3410] (rev 22)
> 00:13.0 PIC [0800]: Intel Corporation 7500/5520/5500/X58 I/O Hub I/OxAPIC=
 Interr
> upt Controller [8086:342d] (rev 22)
> 00:14.0 PIC [0800]: Intel Corporation 7500/5520/5500/X58 I/O Hub System M=
anageme
> nt Registers [8086:342e] (rev 22)
> 00:14.1 PIC [0800]: Intel Corporation 7500/5520/5500/X58 I/O Hub GPIO and=
 Scratc
> h Pad Registers [8086:3422] (rev 22)
> 00:14.2 PIC [0800]: Intel Corporation 7500/5520/5500/X58 I/O Hub Control =
Status
> and RAS Registers [8086:3423] (rev 22)
> 00:14.3 PIC [0800]: Intel Corporation 7500/5520/5500/X58 I/O Hub Throttle=
 Regist
> ers [8086:3438] (rev 22)
> 00:16.0 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset=
 QuickD
> ata Technology Device [8086:3430] (rev 22)
> 00:16.1 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset=
 QuickD
> ata Technology Device [8086:3431] (rev 22)
> 00:16.2 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset=
 QuickD
> ata Technology Device [8086:3432] (rev 22)
> 00:16.3 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset=
 QuickD
> ata Technology Device [8086:3433] (rev 22)
> 00:16.4 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset=
 QuickD
> ata Technology Device [8086:3429] (rev 22)
> 00:16.5 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset=
 QuickD
> ata Technology Device [8086:342a] (rev 22)
> 00:16.6 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset=
 QuickD
> ata Technology Device [8086:342b] (rev 22)
> 00:16.7 System peripheral [0880]: Intel Corporation 5520/5500/X58 Chipset=
 QuickD
> ata Technology Device [8086:342c] (rev 22)
> 00:1a.0 USB controller [0c03]: Intel Corporation 82801JI (ICH10 Family) U=
SB UHCI
>   Controller #4 [8086:3a37]
> 00:1a.1 USB controller [0c03]: Intel Corporation 82801JI (ICH10 Family) U=
SB UHCI
>   Controller #5 [8086:3a38]
> 00:1a.2 USB controller [0c03]: Intel Corporation 82801JI (ICH10 Family) U=
SB UHCI
>   Controller #6 [8086:3a39]
> 00:1a.7 USB controller [0c03]: Intel Corporation 82801JI (ICH10 Family) U=
SB2 EHC
> I Controller #2 [8086:3a3c]
> 00:1c.0 PCI bridge [0604]: Intel Corporation 82801JI (ICH10 Family) PCI E=
xpress
> Root Port 1 [8086:3a40]
> 00:1c.4 PCI bridge [0604]: Intel Corporation 82801JI (ICH10 Family) PCI E=
xpress
> Root Port 5 [8086:3a48]
> 00:1d.0 USB controller [0c03]: Intel Corporation 82801JI (ICH10 Family) U=
SB UHCI
>   Controller #1 [8086:3a34]
> 00:1d.1 USB controller [0c03]: Intel Corporation 82801JI (ICH10 Family) U=
SB UHCI
>   Controller #2 [8086:3a35]
> 00:1d.2 USB controller [0c03]: Intel Corporation 82801JI (ICH10 Family) U=
SB UHCI
>   Controller #3 [8086:3a36]
> 00:1d.7 USB controller [0c03]: Intel Corporation 82801JI (ICH10 Family) U=
SB2 EHC
> I Controller #1 [8086:3a3a]
> 00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge [8086:244e]=
 (rev 9
> 0)
> 00:1f.0 ISA bridge [0601]: Intel Corporation 82801JIR (ICH10R) LPC Interf=
ace Con
> troller [8086:3a16]
> 00:1f.2 IDE interface [0101]: Intel Corporation 82801JI (ICH10 Family) 4 =
port SA
> TA IDE Controller #1 [8086:3a20]
> 00:1f.3 SMBus [0c05]: Intel Corporation 82801JI (ICH10 Family) SMBus Cont=
roller
> [8086:3a30]
> 00:1f.5 IDE interface [0101]: Intel Corporation 82801JI (ICH10 Family) 2 =
port SA
> TA IDE Controller #2 [8086:3a26]
> 01:01.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [A=
MD/ATI]
>   ES1000 [1002:515e] (rev 02)
> 02:00.0 IDE interface [0101]: JMicron Technology Corp. JMB368 IDE control=
ler [19
> 7b:2368]
> 04:00.0 PCI bridge [0604]: Intel Corporation 6700PXH PCI Express-to-PCI B=
ridge A
>   [8086:0329] (rev 09)
> 04:00.2 PCI bridge [0604]: Intel Corporation 6700PXH PCI Express-to-PCI B=
ridge B
>   [8086:032a] (rev 09)
> 08:00.0 VGA compatible controller [0300]: NVIDIA Corporation GK104 [GeFor=
ce GTX
> 760] [10de:1187] (rev a1)
> 08:00.1 Audio device [0403]: NVIDIA Corporation GK104 HDMI Audio Controll=
er [10d
> e:0e0a] (rev a1)
> 0a:00.0 Ethernet controller [0200]: Intel Corporation 82576 Gigabit Netwo=
rk Conn
> ection [8086:10c9] (rev 01)
> 0a:00.1 Ethernet controller [0200]: Intel Corporation 82576 Gigabit Netwo=
rk Conn
> ection [8086:10c9] (rev 01)
> fe:00.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series QuickPath =
Archite
> cture Generic Non-core Registers [8086:2c70] (rev 02)
> fe:00.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series QuickPath =
Archite
> cture System Address Decoder [8086:2d81] (rev 02)
> fe:02.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series QPI Link 0=
 [8086:
> 2d90] (rev 02)
> fe:02.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series QPI Physic=
al 0 [8
> 086:2d91] (rev 02)
> fe:02.2 Host bridge [0600]: Intel Corporation Xeon 5600 Series Mirror Por=
t Link
> 0 [8086:2d92] (rev 02)
> fe:02.3 Host bridge [0600]: Intel Corporation Xeon 5600 Series Mirror Por=
t Link
> 1 [8086:2d93] (rev 02)
> fe:02.4 Host bridge [0600]: Intel Corporation Xeon 5600 Series QPI Link 1=
 [8086:
> 2d94] (rev 02)
> fe:02.5 Host bridge [0600]: Intel Corporation Xeon 5600 Series QPI Physic=
al 1 [8
> 086:2d95] (rev 02)
> fe:03.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Registers [8086:2d98] (rev 02)
> fe:03.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Target Address Decoder [8086:2d99] (rev 02)
> fe:03.2 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller RAS Registers [8086:2d9a] (rev 02)
> fe:03.4 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Test Registers [8086:2d9c] (rev 02)
> fe:04.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 0 Control [8086:2da0] (rev 02)
> fe:04.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 0 Address [8086:2da1] (rev 02)
> fe:04.2 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 0 Rank [8086:2da2] (rev 02)
> fe:04.3 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 0 Thermal Control [8086:2da3] (rev 02)
> fe:05.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 1 Control [8086:2da8] (rev 02)
> fe:05.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 1 Address [8086:2da9] (rev 02)
> fe:05.2 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 1 Rank [8086:2daa] (rev 02)
> fe:05.3 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 1 Thermal Control [8086:2dab] (rev 02)
> fe:06.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 2 Control [8086:2db0] (rev 02)
> fe:06.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 2 Address [8086:2db1] (rev 02)
> fe:06.2 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 2 Rank [8086:2db2] (rev 02)
> fe:06.3 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 2 Thermal Control [8086:2db3] (rev 02)
> ff:00.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series QuickPath =
Archite
> cture Generic Non-core Registers [8086:2c70] (rev 02)
> ff:00.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series QuickPath =
Archite
> cture System Address Decoder [8086:2d81] (rev 02)
> ff:02.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series QPI Link 0=
 [8086:
> 2d90] (rev 02)
> ff:02.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series QPI Physic=
al 0 [8
> 086:2d91] (rev 02)
> ff:02.2 Host bridge [0600]: Intel Corporation Xeon 5600 Series Mirror Por=
t Link
> 0 [8086:2d92] (rev 02)
> ff:02.3 Host bridge [0600]: Intel Corporation Xeon 5600 Series Mirror Por=
t Link
> 1 [8086:2d93] (rev 02)
> ff:02.4 Host bridge [0600]: Intel Corporation Xeon 5600 Series QPI Link 1=
 [8086:
> 2d94] (rev 02)
> ff:02.5 Host bridge [0600]: Intel Corporation Xeon 5600 Series QPI Physic=
al 1 [8
> 086:2d95] (rev 02)
> ff:03.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Registers [8086:2d98] (rev 02)
> ff:03.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Target Address Decoder [8086:2d99] (rev 02)
> ff:03.2 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller RAS Registers [8086:2d9a] (rev 02)
> ff:03.4 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Test Registers [8086:2d9c] (rev 02)
> ff:04.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 0 Control [8086:2da0] (rev 02)
> ff:04.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 0 Address [8086:2da1] (rev 02)
> ff:04.2 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 0 Rank [8086:2da2] (rev 02)
> ff:04.3 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 0 Thermal Control [8086:2da3] (rev 02)
> ff:05.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 1 Control [8086:2da8] (rev 02)
> ff:05.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 1 Address [8086:2da9] (rev 02)
> ff:05.2 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 1 Rank [8086:2daa] (rev 02)
> ff:05.3 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 1 Thermal Control [8086:2dab] (rev 02)
> ff:06.0 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 2 Control [8086:2db0] (rev 02)
> ff:06.1 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 2 Address [8086:2db1] (rev 02)
> ff:06.2 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 2 Rank [8086:2db2] (rev 02)
> ff:06.3 Host bridge [0600]: Intel Corporation Xeon 5600 Series Integrated=
 Memory
>   Controller Channel 2 Thermal Control [8086:2db3] (rev 02)
>
> ic2detect -l
> does not show any output.
>
> dmesg output
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Initializing cgroup subsys cpuacct
> [    0.000000] Linux version 3.11.0-15-generic (buildd@batsu) (gcc versio=
n 4.8.1
>   (Ubuntu/Linaro 4.8.1-10ubuntu8) ) #23-Ubuntu SMP Mon Dec 9 18:17:04 UTC=
 2013 (U
> buntu 3.11.0-15.23-generic 3.11.10)
> [    0.000000] Command line: BOOT_IMAGE=3D/boot/vmlinuz-3.11.0-15-generic=
 root=3DUUI
> D=3D670968bd-3485-489a-8498-0a508f833e0a ro quiet splash nomodeset
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   Centaur CentaurHauls
> [    0.000000] e820: BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009e7ff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x000000000009e800-0x000000000009ffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000000e6000-0x00000000000fffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bf76ffff] usa=
ble
> [    0.000000] BIOS-e820: [mem 0x00000000bf770000-0x00000000bf77dfff] ACP=
I data
> [    0.000000] BIOS-e820: [mem 0x00000000bf77e000-0x00000000bf7cffff] ACP=
I NVS
> [    0.000000] BIOS-e820: [mem 0x00000000bf7d0000-0x00000000bf7dffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000bf7ec000-0x00000000bfffffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x00000000ffc00000-0x00000000ffffffff] res=
erved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000083fffffff] usa=
ble
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] SMBIOS 2.6 present.
> [    0.000000] DMI: Supermicro X8DTN/X8DTN, BIOS 080016  10/06/2010
> [    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> re=
served
> [    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000000] No AGP bridge found
> [    0.000000] e820: last_pfn =3D 0x840000 max_arch_pfn =3D 0x400000000
> [    0.000000] MTRR default type: uncachable
> [    0.000000] MTRR fixed ranges enabled:
> [    0.000000]   00000-9FFFF write-back
> [    0.000000]   A0000-BFFFF uncachable
> [    0.000000]   C0000-D3FFF write-protect
> [    0.000000]   D4000-DFFFF uncachable
> [    0.000000]   E0000-EBFFF write-through
> [    0.000000]   EC000-FFFFF write-protect
> [    0.000000] MTRR variable ranges enabled:
> [    0.000000]   0 base 0000000000 mask F800000000 write-back
> [    0.000000]   1 base 0800000000 mask FFC0000000 write-back
> [    0.000000]   2 base 00C0000000 mask FFC0000000 uncachable
> [    0.000000]   3 base 00BF800000 mask FFFF800000 uncachable
> [    0.000000]   4 disabled
> [    0.000000]   5 disabled
> [    0.000000]   6 disabled
> [    0.000000]   7 disabled
> [    0.000000]   8 disabled
> [    0.000000]   9 disabled
> [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600=
070106
> [    0.000000] original variable MTRRs
> [    0.000000] reg 0, base: 0GB, range: 32GB, type WB
> [    0.000000] reg 1, base: 32GB, range: 1GB, type WB
> [    0.000000] reg 2, base: 3GB, range: 1GB, type UC
> [    0.000000] reg 3, base: 3064MB, range: 8MB, type UC
> [    0.000000] total RAM covered: 32760M
> [    0.000000] Found optimal setting for mtrr clean up
> [    0.000000]  gran_size: 64K     chunk_size: 16M     num_reg: 7 lose cov
> er RAM: 0G
> [    0.000000] New variable MTRRs
> [    0.000000] reg 0, base: 0GB, range: 2GB, type WB
> [    0.000000] reg 1, base: 2GB, range: 1GB, type WB
> [    0.000000] reg 2, base: 3064MB, range: 8MB, type UC
> [    0.000000] reg 3, base: 4GB, range: 4GB, type WB
> [    0.000000] reg 4, base: 8GB, range: 8GB, type WB
> [    0.000000] reg 5, base: 16GB, range: 16GB, type WB
> [    0.000000] reg 6, base: 32GB, range: 1GB, type WB
> [    0.000000] e820: update [mem 0xbf800000-0xffffffff] usable =3D=3D> re=
served
> [    0.000000] e820: last_pfn =3D 0xbf770 max_arch_pfn =3D 0x400000000
> [    0.000000] found SMP MP-table at [mem 0x000ff780-0x000ff78f] mapped a=
t [ffff
> 8800000ff780]
> [    0.000000] Scanning 1 areas for low memory corruption
> [    0.000000] Base memory trampoline at [ffff880000098000] 98000 size 24=
576
> [    0.000000] Using GB pages for direct mapping
> [    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
> [    0.000000]  [mem 0x00000000-0x000fffff] page 4k
> [    0.000000] BRK [0x01fd1000, 0x01fd1fff] PGTABLE
> [    0.000000] BRK [0x01fd2000, 0x01fd2fff] PGTABLE
> [    0.000000] BRK [0x01fd3000, 0x01fd3fff] PGTABLE
> [    0.000000] init_memory_mapping: [mem 0x83fe00000-0x83fffffff]
> [    0.000000]  [mem 0x83fe00000-0x83fffffff] page 1G
> [    0.000000] init_memory_mapping: [mem 0x83c000000-0x83fdfffff]
> [    0.000000]  [mem 0x83c000000-0x83fdfffff] page 1G
> [    0.000000] init_memory_mapping: [mem 0x800000000-0x83bffffff]
> [    0.000000]  [mem 0x800000000-0x83bffffff] page 1G
> [    0.000000] init_memory_mapping: [mem 0x00100000-0xbf76ffff]
> [    0.000000]  [mem 0x00100000-0x001fffff] page 4k
> [    0.000000]  [mem 0x00200000-0x3fffffff] page 2M
> [    0.000000]  [mem 0x40000000-0x7fffffff] page 1G
> [    0.000000]  [mem 0x80000000-0xbf5fffff] page 2M
> [    0.000000]  [mem 0xbf600000-0xbf76ffff] page 4k
> [    0.000000] init_memory_mapping: [mem 0x100000000-0x7ffffffff]
> [    0.000000]  [mem 0x100000000-0x7ffffffff] page 1G
> [    0.000000] RAMDISK: [mem 0x34f78000-0x367b3fff]
> [    0.000000] ACPI: RSDP 00000000000f9fa0 00024 (v02 ACPIAM)
> [    0.000000] ACPI: XSDT 00000000bf770100 0006C (v01 SMCI 20101006 M
> SFT 00000097)
> [    0.000000] ACPI: FACP 00000000bf770290 000F4 (v03 100610 FACP1507 201=
01006 M
> SFT 00000097)
> [    0.000000] ACPI: DSDT 00000000bf7706c0 05CBE (v01  1F280 1F280000 000=
00000 I
> NTL 20051117)
> [    0.000000] ACPI: FACS 00000000bf77e000 00040
> [    0.000000] ACPI: APIC 00000000bf770390 00136 (v01 100610 APIC1507 201=
01006 M
> SFT 00000097)
> [    0.000000] ACPI: MCFG 00000000bf7704d0 0003C (v01 100610 OEMMCFG 2010=
1006 M
> SFT 00000097)
> [    0.000000] ACPI: SLIT 00000000bf770510 00030 (v01 100610 OEMSLIT 2010=
1006 M
> SFT 00000097)
> [    0.000000] ACPI: OEMB 00000000bf77e040 00082 (v01 100610 OEMB1507 201=
01006 M
> SFT 00000097)[    0.000000] ACPI: SRAT 00000000bf77a6c0 00190 (v01 100610=
 OEMSRAT  00000001 I
> NTL 00000001)
> [    0.000000] ACPI: HPET 00000000bf77a850 00038 (v01 100610 OEMHPET 2010=
1006 M
> SFT 00000097)
> [    0.000000] ACPI: DMAR 00000000bf77e0d0 00140 (v01    AMI OEMDMAR 0000=
0001 M
> SFT 00000097)
> [    0.000000] ACPI: SSDT 00000000bf780f30 00363 (v01 DpgPmm CpuPm 000000=
12 I
> NTL 20051117)
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x10 -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x12 -> Node 0
> [    0.000000] SRAT: PXM 0 -> APIC 0x14 -> Node 0
> [    0.000000] SRAT: PXM 1 -> APIC 0x20 -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x22 -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x24 -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x30 -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x32 -> Node 1
> [    0.000000] SRAT: PXM 1 -> APIC 0x34 -> Node 1
> [    0.000000] SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
> [    0.000000] SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
> [    0.000000] SRAT: Node 0 PXM 0 [mem 0x100000000-0x53fffffff]
> [    0.000000] SRAT: Node 1 PXM 1 [mem 0x540000000-0x83fffffff]
> [    0.000000] NUMA: Initialized distance table, cnt=3D2
> [    0.000000] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000=
-0xbfff
> ffff] -> [mem 0x00000000-0xbfffffff]
> [    0.000000] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x10000000=
0-0x53f
> ffffff] -> [mem 0x00000000-0x53fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x00000000-0x53fffffff]
> [    0.000000]   NODE_DATA [mem 0x53fffb000-0x53fffffff]
> [    0.000000] Initmem setup node 1 [mem 0x540000000-0x83fffffff]
> [    0.000000]   NODE_DATA [mem 0x83fff8000-0x83fffcfff]
> [    0.000000]  [ffffea0000000000-ffffea0014ffffff] PMD -> [ffff88052be00=
000-fff
> f88053fdfffff] on node 0
> [    0.000000]  [ffffea0015000000-ffffea0020ffffff] PMD -> [ffff880833600=
000-fff
> f88083f5fffff] on node 1
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
> [    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
> [    0.000000]   Normal   [mem 0x100000000-0x83fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x00001000-0x0009dfff]
> [    0.000000]   node   0: [mem 0x00100000-0xbf76ffff]
> [    0.000000]   node   0: [mem 0x100000000-0x53fffffff]
> [    0.000000]   node   1: [mem 0x540000000-0x83fffffff]
> [    0.000000] On node 0 totalpages: 5240589
> [    0.000000]   DMA zone: 64 pages used for memmap
> [    0.000000]   DMA zone: 21 pages reserved
> [    0.000000]   DMA zone: 3997 pages, LIFO batch:0
> [    0.000000]   DMA32 zone: 12190 pages used for memmap
> [    0.000000]   DMA32 zone: 780144 pages, LIFO batch:31
> [    0.000000]   Normal zone: 69632 pages used for memmap
> [    0.000000]   Normal zone: 4456448 pages, LIFO batch:31
> [    0.000000] On node 1 totalpages: 3145728
> [    0.000000]   Normal zone: 49152 pages used for memmap
> [    0.000000]   Normal zone: 3145728 pages, LIFO batch:31
> [    0.000000] ACPI: PM-Timer IO Port: 0x808
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)[ 0.0000=
00] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x04] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x10] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x12] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x14] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x20] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x22] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x24] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x30] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x32] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x34] enabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x8c] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x8d] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x8e] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x8f] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x11] lapic_id[0x90] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x12] lapic_id[0x91] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x13] lapic_id[0x92] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x14] lapic_id[0x93] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x15] lapic_id[0x94] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x16] lapic_id[0x95] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x17] lapic_id[0x96] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x18] lapic_id[0x97] disabled)
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
> [    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
> [    0.000000] IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI =
0-23
> [    0.000000] ACPI: IOAPIC (id[0x03] address[0xfec8a000] gsi_base[24])
> [    0.000000] IOAPIC[1]: apic_id 3, version 32, address 0xfec8a000, GSI =
24-47
> [    0.000000] ACPI: IOAPIC (id[0x05] address[0xfec80000] gsi_base[48])
> [    0.000000] IOAPIC[2]: apic_id 5, version 32, address 0xfec80000, GSI =
48-71
> [    0.000000] ACPI: IOAPIC (id[0x06] address[0xfec80400] gsi_base[72])
> [    0.000000] IOAPIC[3]: apic_id 6, version 32, address 0xfec80400, GSI =
72-95
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.000000] ACPI: IRQ0 used by override.
> [    0.000000] ACPI: IRQ2 used by override.
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
> [    0.000000] smpboot: Allowing 24 CPUs, 12 hotplug CPUs
> [    0.000000] nr_irqs_gsi: 112
> [    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009efff]
> [    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000e5fff]
> [    0.000000] PM: Registered nosave memory: [mem 0x000e6000-0x000fffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf770000-0xbf77dfff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf77e000-0xbf7cffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf7d0000-0xbf7dffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf7e0000-0xbf7ebfff]
> [    0.000000] PM: Registered nosave memory: [mem 0xbf7ec000-0xbfffffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xc0000000-0xdfffffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xfedfffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> [    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffbfffff]
> [    0.000000] PM: Registered nosave memory: [mem 0xffc00000-0xffffffff]
> [    0.000000] e820: [mem 0xc0000000-0xdfffffff] available for PCI devices
> [    0.000000] Booting paravirtualized kernel on bare hardware
> [    0.000000] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:2=
4 nr_no
> de_ids:2
> [    0.000000] PERCPU: Embedded 29 pages/cpu @ffff88052bc00000 s86720 r81=
92 d238
> 72 u131072
> [    0.000000] pcpu-alloc: s86720 r8192 d23872 u131072 alloc=3D1*2097152
> [    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 12 14 16 18 20 22 -- -- =
-- --
> [    0.000000] pcpu-alloc: [1] 06 07 08 09 10 11 13 15 17 19 21 23 -- -- =
-- --
> [    0.000000] Built 2 zonelists in Zone order, mobility grouping on. Tot=
al pag
> es: 8255258
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: BOOT_IMAGE=3D/boot/vmlinuz-3.11.0-15-=
generic r
> oot=3DUUID=3D670968bd-3485-489a-8498-0a508f833e0a ro quiet splash nomodes=
et
> [    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
> [    0.000000] Checking aperture...
> [    0.000000] No AGP bridge found
> [    0.000000] Calgary: detecting Calgary via BIOS EBDA area
> [    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - baili=
ng!
> [    0.000000] Memory: 32910616K/33545268K available (7149K kernel code, =
1082K r
> wdata, 3312K rodata, 1364K init, 1420K bss, 634652K reserved)
> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D24=
, Nodes=3D2
> [    0.000000] Hierarchical RCU implementation.
> [    0.000000]     RCU dyntick-idle grace-period acceleration is enabled.
> [    0.000000]     RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu_ids=
=3D24.
> [    0.000000]     Offload RCU callbacks from all CPUs
> [    0.000000]     Offload RCU callbacks from CPUs: 0-255.
> [    0.000000] NR_IRQS:16640 nr_irqs:2096 16
> [    0.000000] Console: colour VGA+ 80x25
> [    0.000000] console [tty0] enabled
> [    0.000000] allocated 134217728 bytes of page_cgroup
> [    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't w=
ant memor
> y cgroups
> [    0.000000] Enabling automatic NUMA balancing. Configure with numa_bal=
ancing=3D
>   or sysctl
> [    0.000000] hpet clockevent registered
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.004000] tsc: Detected 2933.470 MHz processor
> [    0.000006] Calibrating delay loop (skipped), value calculated using t=
imer fr
> equency.. 5866.94 BogoMIPS (lpj=3D11733880)
> [    0.000008] pid_max: default: 32768 minimum: 301
> [    0.000056] Security Framework initialized
> [    0.000084] AppArmor: AppArmor initialized
> [    0.000085] Yama: becoming mindful.
> [    0.001896] Dentry cache hash table entries: 4194304 (order: 13, 33554=
432 byt
> es)
> [    0.008116] Inode-cache hash table entries: 2097152 (order: 12, 167772=
16 byte
> s)
> [    0.010762] Mount-cache hash table entries: 256
> [    0.010976] Initializing cgroup subsys memory
> [    0.010995] Initializing cgroup subsys devices
> [    0.010996] Initializing cgroup subsys freezer
> [    0.010997] Initializing cgroup subsys blkio
> [    0.010999] Initializing cgroup subsys perf_event
> [    0.011004] Initializing cgroup subsys hugetlb
> [    0.011025] CPU: Physical Processor ID: 0
> [    0.011026] CPU: Processor Core ID: 0
> [    0.011034] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.011034] ENERGY_PERF_BIAS: View and update with x86_energy_perf_pol=
icy(8)
> [    0.011036] mce: CPU supports 9 MCE banks
> [    0.011044] CPU0: Thermal monitoring enabled (TM1)
> [    0.011052] Last level iTLB entries: 4KB 512, 2MB 7, 4MB 7
> [    0.011052] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32
> [    0.011052] tlb_flushall_shift: 6
> [    0.011131] Freeing SMP alternatives memory: 28K (ffffffff81e65000 - f=
fffffff
> 81e6c000)
> [    0.012902] ACPI: Core revision 20130517
> [    0.015237] ACPI: All ACPI Tables successfully acquired
> [    0.037505] ftrace: allocating 27844 entries in 109 pages
> [    0.048841] dmar: Host address width 40
> [    0.048843] dmar: DRHD base: 0x000000fbffe000 flags: 0x1
> [    0.048849] dmar: IOMMU 0: reg_base_addr fbffe000 ver 1:0 cap c9078010=
6f0462
> ecap f020f6
> [    0.048851] dmar: RMRR base: 0x000000000e6000 end: 0x000000000e9fff
> [    0.048852] dmar: RMRR base: 0x000000bf7ec000 end: 0x000000bf7fffff
> [    0.048853] dmar: ATSR flags: 0x0
> [    0.049096] Switched APIC routing to physical flat.
> [    0.049792] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=
=3D-1
> [    0.089466] smpboot: CPU0: Intel(R) Xeon(R) CPU           X5670 @ 2.93=
GHz (f
> am: 06, model: 2c, stepping: 02)
> [    0.194906] Performance Events: PEBS fmt1+, 16-deep LBR, Westmere even=
ts, Int
> el PMU driver.
> [    0.194911] perf_event_intel: CPUID marked event: 'bus cycles' unavail=
able
> [    0.194913] ... version:                3
> [    0.194913] ... bit width:              48
> [    0.194914] ... generic registers:      4
> [    0.194915] ... value mask:             0000ffffffffffff
> [    0.194916] ... max period:             000000007fffffff
> [    0.194917] ... fixed-purpose events:   3
> [    0.194917] ... event mask:             000000070000000f
> [    0.210134] NMI watchdog: enabled on all CPUs, permanently consumes on=
e hw-PM
> U counter.
> [    0.196681] smpboot: Booting Node   0, Processors  #1 #2 #3 #4 #5 OK
> [    0.263159] smpboot: Booting Node   1, Processors  #6 #7 #8 #9 #10 #11
> [    0.436981] Brought up 12 CPUs
> [    0.436983] smpboot: Total of 12 processors activated (70402.95 BogoMI=
PS)
> [    0.450622] devtmpfs: initialized
> [    0.453419] EVM: security.selinux
> [    0.453421] EVM: security.SMACK64
> [    0.453422] EVM: security.capability
> [    0.453478] PM: Registering ACPI NVS region [mem 0xbf77e000-0xbf7cffff=
] (3358
> 72 bytes)
> [    0.454333] regulator-dummy: no parameters
> [    0.454360] RTC time: 17:04:16, date: 01/20/14
> [    0.454403] NET: Registered protocol family 16
> [    0.454527] ACPI: bus type PCI registered
> [    0.454529] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.454583] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xe00000=
00-0xef
> ffffff] (base 0xe0000000)
> [    0.454586] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E=
820
> [    0.466477] PCI: Using configuration type 1 for base access
> [    0.467636] bio: create slab <bio-0> at 0
> [    0.467865] ACPI: Added _OSI(Module Device)
> [    0.467867] ACPI: Added _OSI(Processor Device)
> [    0.467868] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.467869] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.468568] ACPI: EC: Look up EC in DSDT
> [    0.469357] ACPI: Executed 1 blocks of module-level executable AML code
> [    0.470820] \_SB_:_OSC evaluation returned wrong type
> [    0.470822] _OSC request data:1 1f
> [    0.477872] ACPI: SSDT 00000000bf77e210 02D18 (v01 DpgPmm P001Ist 0000=
0011 I
> NTL 20051117)
> [    0.478168] ACPI: Dynamic OEM Table Load:
> [    0.478170] ACPI: SSDT           (null) 02D18 (v01 DpgPmm P001Ist 0000=
0011 I
> NTL 20051117)
> [    0.478398] ACPI: Interpreter enabled
> [    0.478405] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State=
 [\_S2_
> ] (20130517/hwxface-571)
> [    0.478408] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State=
 [\_S3_
> ] (20130517/hwxface-571)
> [    0.478415] ACPI: (supports S0 S1 S4 S5)
> [    0.478417] ACPI: Using IOAPIC for interrupt routing
> [    0.478442] PCI: Using host bridge windows from ACPI; if necessary, us=
e "pci=3D
> nocrs" and report a bug[    0.478506] ACPI: No dock devices found.
> [    0.483991] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.484133] acpi PNP0A08:00: Requesting ACPI _OSC control (0x1d)
> [    0.484336] acpi PNP0A08:00: ACPI _OSC control (0x1c) granted
> [    0.484523] PCI host bridge to bus 0000:00
> [    0.484526] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.484528] pci_bus 0000:00: root bus resource [io 0x0000-0x0cf7]
> [    0.484529] pci_bus 0000:00: root bus resource [io 0x0d00-0xffff]
> [    0.484531] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bf=
fff]
> [    0.484532] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000df=
fff]
> [    0.484533] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdffff=
fff]
> [    0.484535] pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfed8f=
fff]
> [    0.484545] pci 0000:00:00.0: [8086:3406] type 00 class 0x060000
> [    0.484590] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
> [    0.484653] pci 0000:00:01.0: [8086:3408] type 01 class 0x060400
> [    0.484700] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> [    0.484739] pci 0000:00:01.0: System wakeup disabled by ACPI
> [    0.484771] pci 0000:00:03.0: [8086:340a] type 01 class 0x060400
> [    0.484817] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
> [    0.484857] pci 0000:00:03.0: System wakeup disabled by ACPI
> [    0.484885] pci 0000:00:05.0: [8086:340c] type 01 class 0x060400
> [    0.484932] pci 0000:00:05.0: PME# supported from D0 D3hot D3cold
> [    0.484968] pci 0000:00:05.0: System wakeup disabled by ACPI
> [    0.484996] pci 0000:00:07.0: [8086:340e] type 01 class 0x060400
> [    0.485042] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
> [    0.485079] pci 0000:00:07.0: System wakeup disabled by ACPI
> [    0.485109] pci 0000:00:09.0: [8086:3410] type 01 class 0x060400
> [    0.485155] pci 0000:00:09.0: PME# supported from D0 D3hot D3cold
> [    0.485192] pci 0000:00:09.0: System wakeup disabled by ACPI
> [    0.485221] pci 0000:00:13.0: [8086:342d] type 00 class 0x080020
> [    0.485231] pci 0000:00:13.0: reg 0x10: [mem 0xfec8a000-0xfec8afff]
> [    0.485271] pci 0000:00:13.0: PME# supported from D0 D3hot D3cold
> [    0.485327] pci 0000:00:14.0: [8086:342e] type 00 class 0x080000
> [    0.485421] pci 0000:00:14.1: [8086:3422] type 00 class 0x080000
> [    0.485520] pci 0000:00:14.2: [8086:3423] type 00 class 0x080000
> [    0.485611] pci 0000:00:14.3: [8086:3438] type 00 class 0x080000
> [    0.485699] pci 0000:00:16.0: [8086:3430] type 00 class 0x088000
> [    0.485709] pci 0000:00:16.0: reg 0x10: [mem 0xf9cd8000-0xf9cdbfff 64b=
it]
> [    0.485805] pci 0000:00:16.1: [8086:3431] type 00 class 0x088000
> [    0.485815] pci 0000:00:16.1: reg 0x10: [mem 0xf9cdc000-0xf9cdffff 64b=
it]
> [    0.485911] pci 0000:00:16.2: [8086:3432] type 00 class 0x088000
> [    0.485922] pci 0000:00:16.2: reg 0x10: [mem 0xf9ce0000-0xf9ce3fff 64b=
it]
> [    0.486017] pci 0000:00:16.3: [8086:3433] type 00 class 0x088000
> [    0.486027] pci 0000:00:16.3: reg 0x10: [mem 0xf9ce4000-0xf9ce7fff 64b=
it]
> [    0.486121] pci 0000:00:16.4: [8086:3429] type 00 class 0x088000
> [    0.486132] pci 0000:00:16.4: reg 0x10: [mem 0xf9ce8000-0xf9cebfff 64b=
it]
> [    0.486227] pci 0000:00:16.5: [8086:342a] type 00 class 0x088000
> [    0.486238] pci 0000:00:16.5: reg 0x10: [mem 0xf9cec000-0xf9ceffff 64b=
it]
> [    0.486333] pci 0000:00:16.6: [8086:342b] type 00 class 0x088000
> [    0.486344] pci 0000:00:16.6: reg 0x10: [mem 0xf9cf0000-0xf9cf3fff 64b=
it]
> [    0.486442] pci 0000:00:16.7: [8086:342c] type 00 class 0x088000
> [    0.486452] pci 0000:00:16.7: reg 0x10: [mem 0xf9cf4000-0xf9cf7fff 64b=
it]
> [    0.486549] pci 0000:00:1a.0: [8086:3a37] type 00 class 0x0c0300
> [    0.486586] pci 0000:00:1a.0: reg 0x20: [io  0x8400-0x841f]
> [    0.486664] pci 0000:00:1a.0: System wakeup disabled by ACPI
> [    0.486693] pci 0000:00:1a.1: [8086:3a38] type 00 class 0x0c0300
> [    0.486730] pci 0000:00:1a.1: reg 0x20: [io  0x8480-0x849f]
> [    0.486805] pci 0000:00:1a.1: System wakeup disabled by ACPI
> [    0.486839] pci 0000:00:1a.2: [8086:3a39] type 00 class 0x0c0300
> [    0.486876] pci 0000:00:1a.2: reg 0x20: [io  0x8800-0x881f]
> [    0.486953] pci 0000:00:1a.2: System wakeup disabled by ACPI
> [    0.486989] pci 0000:00:1a.7: [8086:3a3c] type 00 class 0x0c0320
> [    0.487008] pci 0000:00:1a.7: reg 0x10: [mem 0xf9cfa000-0xf9cfa3ff][  =
  0.487089] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
> [    0.487128] pci 0000:00:1a.7: System wakeup disabled by ACPI
> [    0.487155] pci 0000:00:1c.0: [8086:3a40] type 01 class 0x060400
> [    0.487215] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.487254] pci 0000:00:1c.0: System wakeup disabled by ACPI
> [    0.487287] pci 0000:00:1c.4: [8086:3a48] type 01 class 0x060400
> [    0.487347] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
> [    0.487412] pci 0000:00:1d.0: [8086:3a34] type 00 class 0x0c0300
> [    0.487450] pci 0000:00:1d.0: reg 0x20: [io  0x8880-0x889f]
> [    0.487523] pci 0000:00:1d.0: System wakeup disabled by ACPI
> [    0.487551] pci 0000:00:1d.1: [8086:3a35] type 00 class 0x0c0300
> [    0.487589] pci 0000:00:1d.1: reg 0x20: [io  0x8c00-0x8c1f]
> [    0.487662] pci 0000:00:1d.1: System wakeup disabled by ACPI
> [    0.487693] pci 0000:00:1d.2: [8086:3a36] type 00 class 0x0c0300
> [    0.487731] pci 0000:00:1d.2: reg 0x20: [io  0x9000-0x901f]
> [    0.487808] pci 0000:00:1d.2: System wakeup disabled by ACPI
> [    0.487842] pci 0000:00:1d.7: [8086:3a3a] type 00 class 0x0c0320
> [    0.487861] pci 0000:00:1d.7: reg 0x10: [mem 0xf9cfc000-0xf9cfc3ff]
> [    0.487942] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
> [    0.487984] pci 0000:00:1d.7: System wakeup disabled by ACPI
> [    0.488012] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
> [    0.488084] pci 0000:00:1e.0: System wakeup disabled by ACPI
> [    0.488113] pci 0000:00:1f.0: [8086:3a16] type 00 class 0x060100
> [    0.488184] pci 0000:00:1f.0: address space collision: [io 0x0800-0x08=
7f] co
> nflicts with ACPI CPU throttle [??? 0x00000810-0x00000815 flags 0x8000000=
0]
> [    0.488188] pci 0000:00:1f.0: quirk: [io  0x0500-0x053f] claimed by IC=
H6 GPIO
> [    0.488191] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 1 PIO at 0a00=
 (mask
> 00ff)
> [    0.488195] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 3 PIO at 0290=
 (mask
> 001f)
> [    0.488197] pci 0000:00:1f.0: ICH7 LPC Generic IO decode 4 PIO at 0ca0=
 (mask
> 000f)
> [    0.488277] pci 0000:00:1f.2: [8086:3a20] type 00 class 0x01018f
> [    0.488290] pci 0000:00:1f.2: reg 0x10: [io  0xac00-0xac07]
> [    0.488297] pci 0000:00:1f.2: reg 0x14: [io  0xa880-0xa883]
> [    0.488304] pci 0000:00:1f.2: reg 0x18: [io  0xa800-0xa807]
> [    0.488310] pci 0000:00:1f.2: reg 0x1c: [io  0xa480-0xa483]
> [    0.488317] pci 0000:00:1f.2: reg 0x20: [io  0xa400-0xa40f]
> [    0.488324] pci 0000:00:1f.2: reg 0x24: [io  0xa080-0xa08f]
> [    0.488404] pci 0000:00:1f.3: [8086:3a30] type 00 class 0x0c0500
> [    0.488417] pci 0000:00:1f.3: reg 0x10: [mem 0xf9cfe000-0xf9cfe0ff 64b=
it]
> [    0.488435] pci 0000:00:1f.3: reg 0x20: [io  0x0400-0x041f]
> [    0.488503] pci 0000:00:1f.5: [8086:3a26] type 00 class 0x010185
> [    0.488517] pci 0000:00:1f.5: reg 0x10: [io  0x9c00-0x9c07]
> [    0.488523] pci 0000:00:1f.5: reg 0x14: [io  0x9880-0x9883]
> [    0.488530] pci 0000:00:1f.5: reg 0x18: [io  0x9800-0x9807]
> [    0.488536] pci 0000:00:1f.5: reg 0x1c: [io  0x9480-0x9483]
> [    0.488543] pci 0000:00:1f.5: reg 0x20: [io  0x9400-0x940f]
> [    0.488550] pci 0000:00:1f.5: reg 0x24: [io  0x9080-0x908f]
> [    0.488683] pci 0000:0a:00.0: [8086:10c9] type 00 class 0x020000
> [    0.488695] pci 0000:0a:00.0: reg 0x10: [mem 0xfbe60000-0xfbe7ffff]
> [    0.488703] pci 0000:0a:00.0: reg 0x14: [mem 0xfbe40000-0xfbe5ffff]
> [    0.488711] pci 0000:0a:00.0: reg 0x18: [io  0xe880-0xe89f]
> [    0.488719] pci 0000:0a:00.0: reg 0x1c: [mem 0xfbe1c000-0xfbe1ffff]
> [    0.488740] pci 0000:0a:00.0: reg 0x30: [mem 0xfbe20000-0xfbe3ffff pre=
f]
> [    0.488780] pci 0000:0a:00.0: PME# supported from D0 D3hot D3cold
> [    0.488814] pci 0000:0a:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.488830] pci 0000:0a:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit][    0.488938] pci 0000:0a:00.1: reg 0x30: [mem 0xfbea0000-0xfbebffff p=
ref]
> [    0.488978] pci 0000:0a:00.1: PME# supported from D0 D3hot D3cold
> [    0.489008] pci 0000:0a:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.489024] pci 0000:0a:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.494846] pci 0000:00:01.0: PCI bridge to [bus 0a]
> [    0.494851] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
> [    0.494855] pci 0000:00:01.0:   bridge window [mem 0xfbe00000-0xfbefff=
ff]
> [    0.494908] pci 0000:00:03.0: PCI bridge to [bus 09]
> [    0.494961] pci 0000:08:00.0: [10de:1187] type 00 class 0x030000
> [    0.494970] pci 0000:08:00.0: reg 0x10: [mem 0xfa000000-0xfaffffff]
> [    0.494979] pci 0000:08:00.0: reg 0x14: [mem 0xd8000000-0xdfffffff 64b=
it pref
> ]
> [    0.494987] pci 0000:08:00.0: reg 0x1c: [mem 0xd6000000-0xd7ffffff 64b=
it pref
> ]
> [    0.494993] pci 0000:08:00.0: reg 0x24: [io  0xdc00-0xdc7f]
> [    0.494999] pci 0000:08:00.0: reg 0x30: [mem 0xf9f80000-0xf9ffffff pre=
f]
> [    0.495068] pci 0000:08:00.1: [10de:0e0a] type 00 class 0x040300
> [    0.495077] pci 0000:08:00.1: reg 0x10: [mem 0xfbdfc000-0xfbdfffff]
> [    0.502843] pci 0000:00:05.0: PCI bridge to [bus 08]
> [    0.502848] pci 0000:00:05.0:   bridge window [io  0xd000-0xdfff]
> [    0.502853] pci 0000:00:05.0:   bridge window [mem 0xf9f00000-0xfbdfff=
ff]
> [    0.502859] pci 0000:00:05.0:   bridge window [mem 0xd6000000-0xdfffff=
ff 64bi
> t pref]
> [    0.502907] pci 0000:00:07.0: PCI bridge to [bus 07]
> [    0.502965] pci 0000:04:00.0: [8086:0329] type 01 class 0x060400
> [    0.502978] pci 0000:04:00.0: PXH quirk detected; SHPC device MSI disa=
bled
> [    0.503026] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
> [    0.503046] pci 0000:04:00.0: System wakeup disabled by ACPI
> [    0.503073] pci 0000:04:00.2: [8086:032a] type 01 class 0x060400
> [    0.503086] pci 0000:04:00.2: PXH quirk detected; SHPC device MSI disa=
bled
> [    0.503134] pci 0000:04:00.2: PME# supported from D0 D3hot D3cold
> [    0.503151] pci 0000:04:00.2: System wakeup disabled by ACPI
> [    0.503175] pci 0000:04:00.0: disabling ASPM on pre-1.1 PCIe device. Y=
ou can
>   enable it with 'pcie_aspm=3Dforce'
> [    0.503181] pci 0000:00:09.0: PCI bridge to [bus 04-06]
> [    0.503247] pci 0000:04:00.0: PCI bridge to [bus 06]
> [    0.503311] pci 0000:04:00.2: PCI bridge to [bus 05]
> [    0.503373] pci 0000:00:1c.0: PCI bridge to [bus 03]
> [    0.503437] pci 0000:02:00.0: [197b:2368] type 00 class 0x010185
> [    0.503465] pci 0000:02:00.0: reg 0x10: [io  0xc400-0xc407]
> [    0.503478] pci 0000:02:00.0: reg 0x14: [io  0xcc00-0xcc03]
> [    0.503490] pci 0000:02:00.0: reg 0x18: [io  0xc880-0xc887]
> [    0.503503] pci 0000:02:00.0: reg 0x1c: [io  0xc800-0xc803]
> [    0.503515] pci 0000:02:00.0: reg 0x20: [io  0xc480-0xc48f]
> [    0.503539] pci 0000:02:00.0: reg 0x30: [mem 0xf9ef0000-0xf9efffff pre=
f]
> [    0.503633] pci 0000:02:00.0: disabling ASPM on pre-1.1 PCIe device. Y=
ou can
>   enable it with 'pcie_aspm=3Dforce'
> [    0.503642] pci 0000:00:1c.4: PCI bridge to [bus 02]
> [    0.503645] pci 0000:00:1c.4:   bridge window [io  0xc000-0xcfff]
> [    0.503648] pci 0000:00:1c.4:   bridge window [mem 0xf9e00000-0xf9efff=
ff]
> [    0.503688] pci 0000:01:01.0: [1002:515e] type 00 class 0x030000
> [    0.503704] pci 0000:01:01.0: reg 0x10: [mem 0xc8000000-0xcfffffff pre=
f]
> [    0.503713] pci 0000:01:01.0: reg 0x14: [io  0xb000-0xb0ff]
> [    0.503722] pci 0000:01:01.0: reg 0x18: [mem 0xf9dd0000-0xf9ddffff]
> [    0.503752] pci 0000:01:01.0: reg 0x30: [mem 0xf9de0000-0xf9dfffff pre=
f]
> [    0.503778] pci 0000:01:01.0: supports D1 D2
> [    0.503833] pci 0000:00:1e.0: PCI bridge to [bus 01] (subtractive deco=
de)
> [    0.503836] pci 0000:00:1e.0:   bridge window [io  0xb000-0xbfff]
> [    0.503839] pci 0000:00:1e.0:   bridge window [mem 0xf9d00000-0xf9dfff=
ff]
> [    0.503844] pci 0000:00:1e.0:   bridge window [mem 0xc8000000-0xcfffff=
ff 64bi
> t pref]
> [    0.503845] pci 0000:00:1e.0:   bridge window [io  0x0000-0x0cf7] (sub=
tractiv
> e decode)[    0.503847] pci 0000:00:1e.0:   bridge window [io 0x0d00-0xff=
ff] (subtractiv
> e decode)
> [    0.503848] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bff=
ff] (su
> btractive decode)
> [    0.503850] pci 0000:00:1e.0:   bridge window [mem 0x000d0000-0x000dff=
ff] (su
> btractive decode)
> [    0.503851] pci 0000:00:1e.0:   bridge window [mem 0xc0000000-0xdfffff=
ff] (su
> btractive decode)
> [    0.503853] pci 0000:00:1e.0:   bridge window [mem 0xf0000000-0xfed8ff=
ff] (su
> btractive decode)
> [    0.504454] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 =
14 15)
> [    0.504497] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 =
14 15)
> [    0.504539] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 1=
4 *15)
> [    0.504580] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 =
14 15)
> [    0.504621] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 1=
4 15) *
> 0, disabled.
> [    0.504663] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 *7 10 11 12 =
14 15)
> [    0.504704] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 1=
4 15) *
> 0, disabled.
> [    0.504746] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 *=
14 15)
> [    0.504821] ACPI: Enabled 1 GPEs in block 00 to 3F
> [    0.504826] ACPI: \_SB_.PCI0: notify handler is installed
> [    0.504855] Found 1 acpi root devices
> [    0.504951] vgaarb: device added: PCI:0000:08:00.0,decodes=3Dio+mem,ow=
ns=3Dio+mem
> ,locks=3Dnone
> [    0.504959] vgaarb: device added: PCI:0000:01:01.0,decodes=3Dio+mem,ow=
ns=3Dnone,l
> ocks=3Dnone
> [    0.504960] vgaarb: loaded
> [    0.504961] vgaarb: bridge control possible 0000:01:01.0
> [    0.504962] vgaarb: bridge control possible 0000:08:00.0
> [    0.505112] SCSI subsystem initialized
> [    0.505114] ACPI: bus type ATA registered
> [    0.505159] libata version 3.00 loaded.
> [    0.505172] ACPI: bus type USB registered
> [    0.505183] usbcore: registered new interface driver usbfs
> [    0.505192] usbcore: registered new interface driver hub
> [    0.505212] usbcore: registered new device driver usb
> [    0.505337] PCI: Using ACPI for IRQ routing
> [    0.510630] PCI: Discovered peer bus fe
> [    0.510631] PCI: root bus fe: using default resources
> [    0.510632] PCI: Probing PCI hardware (bus fe)
> [    0.510653] PCI host bridge to bus 0000:fe
> [    0.510656] pci_bus 0000:fe: root bus resource [io 0x0000-0xffff]
> [    0.510657] pci_bus 0000:fe: root bus resource [mem 0x00000000-0xfffff=
fffff]
> [    0.510659] pci_bus 0000:fe: No busn resource found for root bus, will=
 use [b
> us fe-ff]
> [    0.510663] pci 0000:fe:00.0: [8086:2c70] type 00 class 0x060000
> [    0.510700] pci 0000:fe:00.1: [8086:2d81] type 00 class 0x060000
> [    0.510735] pci 0000:fe:02.0: [8086:2d90] type 00 class 0x060000
> [    0.510767] pci 0000:fe:02.1: [8086:2d91] type 00 class 0x060000
> [    0.510798] pci 0000:fe:02.2: [8086:2d92] type 00 class 0x060000
> [    0.510833] pci 0000:fe:02.3: [8086:2d93] type 00 class 0x060000
> [    0.510865] pci 0000:fe:02.4: [8086:2d94] type 00 class 0x060000
> [    0.510899] pci 0000:fe:02.5: [8086:2d95] type 00 class 0x060000
> [    0.510931] pci 0000:fe:03.0: [8086:2d98] type 00 class 0x060000
> [    0.510964] pci 0000:fe:03.1: [8086:2d99] type 00 class 0x060000
> [    0.510995] pci 0000:fe:03.2: [8086:2d9a] type 00 class 0x060000
> [    0.511024] pci 0000:fe:03.4: [8086:2d9c] type 00 class 0x060000
> [    0.511057] pci 0000:fe:04.0: [8086:2da0] type 00 class 0x060000
> [    0.511088] pci 0000:fe:04.1: [8086:2da1] type 00 class 0x060000
> [    0.511118] pci 0000:fe:04.2: [8086:2da2] type 00 class 0x060000
> [    0.511148] pci 0000:fe:04.3: [8086:2da3] type 00 class 0x060000
> [    0.511181] pci 0000:fe:05.0: [8086:2da8] type 00 class 0x060000[ 0.51=
1214] pci 0000:fe:05.1: [8086:2da9] type 00 class 0x060000
> [    0.511245] pci 0000:fe:05.2: [8086:2daa] type 00 class 0x060000
> [    0.511276] pci 0000:fe:05.3: [8086:2dab] type 00 class 0x060000
> [    0.511310] pci 0000:fe:06.0: [8086:2db0] type 00 class 0x060000
> [    0.511340] pci 0000:fe:06.1: [8086:2db1] type 00 class 0x060000
> [    0.511370] pci 0000:fe:06.2: [8086:2db2] type 00 class 0x060000
> [    0.511402] pci 0000:fe:06.3: [8086:2db3] type 00 class 0x060000
> [    0.511451] pci_bus 0000:fe: busn_res: [bus fe-ff] end is updated to fe
> [    0.511455] PCI: Discovered peer bus ff
> [    0.511456] PCI: root bus ff: using default resources
> [    0.511457] PCI: Probing PCI hardware (bus ff)
> [    0.511474] PCI host bridge to bus 0000:ff
> [    0.511475] pci_bus 0000:ff: root bus resource [io 0x0000-0xffff]
> [    0.511477] pci_bus 0000:ff: root bus resource [mem 0x00000000-0xfffff=
fffff]
> [    0.511478] pci_bus 0000:ff: No busn resource found for root bus, will=
 use [b
> us ff-ff]
> [    0.511482] pci 0000:ff:00.0: [8086:2c70] type 00 class 0x060000
> [    0.511516] pci 0000:ff:00.1: [8086:2d81] type 00 class 0x060000
> [    0.511548] pci 0000:ff:02.0: [8086:2d90] type 00 class 0x060000
> [    0.511577] pci 0000:ff:02.1: [8086:2d91] type 00 class 0x060000
> [    0.511607] pci 0000:ff:02.2: [8086:2d92] type 00 class 0x060000
> [    0.511636] pci 0000:ff:02.3: [8086:2d93] type 00 class 0x060000
> [    0.511665] pci 0000:ff:02.4: [8086:2d94] type 00 class 0x060000
> [    0.511695] pci 0000:ff:02.5: [8086:2d95] type 00 class 0x060000
> [    0.511724] pci 0000:ff:03.0: [8086:2d98] type 00 class 0x060000
> [    0.511754] pci 0000:ff:03.1: [8086:2d99] type 00 class 0x060000
> [    0.511780] pci 0000:ff:03.2: [8086:2d9a] type 00 class 0x060000
> [    0.511809] pci 0000:ff:03.4: [8086:2d9c] type 00 class 0x060000
> [    0.511839] pci 0000:ff:04.0: [8086:2da0] type 00 class 0x060000
> [    0.511866] pci 0000:ff:04.1: [8086:2da1] type 00 class 0x060000
> [    0.511894] pci 0000:ff:04.2: [8086:2da2] type 00 class 0x060000
> [    0.511923] pci 0000:ff:04.3: [8086:2da3] type 00 class 0x060000
> [    0.511953] pci 0000:ff:05.0: [8086:2da8] type 00 class 0x060000
> [    0.511982] pci 0000:ff:05.1: [8086:2da9] type 00 class 0x060000
> [    0.512012] pci 0000:ff:05.2: [8086:2daa] type 00 class 0x060000
> [    0.512040] pci 0000:ff:05.3: [8086:2dab] type 00 class 0x060000
> [    0.512070] pci 0000:ff:06.0: [8086:2db0] type 00 class 0x060000
> [    0.512099] pci 0000:ff:06.1: [8086:2db1] type 00 class 0x060000
> [    0.512125] pci 0000:ff:06.2: [8086:2db2] type 00 class 0x060000
> [    0.512154] pci 0000:ff:06.3: [8086:2db3] type 00 class 0x060000
> [    0.512192] pci_bus 0000:ff: busn_res: [bus ff] end is updated to ff
> [    0.512196] PCI: pci_cache_line_size set to 64 bytes
> [    0.512304] e820: reserve RAM buffer [mem 0x0009e800-0x0009ffff]
> [    0.512306] e820: reserve RAM buffer [mem 0xbf770000-0xbfffffff]
> [    0.512378] NetLabel: Initializing
> [    0.512379] NetLabel:  domain hash size =3D 128
> [    0.512380] NetLabel:  protocols =3D UNLABELED CIPSOv4
> [    0.512388] NetLabel:  unlabeled traffic allowed by default
> [    0.512436] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
> [    0.512440] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
> [    0.514474] Switched to clocksource hpet
> [    0.518872] AppArmor: AppArmor Filesystem Enabled
> [    0.518886] pnp: PnP ACPI init
> [    0.518893] ACPI: bus type PNP registered
> [    0.518944] system 00:00: [mem 0xfbf00000-0xfbffffff] could not be res=
erved
> [    0.518947] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
> [    0.518949] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
> [    0.518950] system 00:00: [mem 0xfe000000-0xfebfffff] has been reserved
> [    0.518952] system 00:00: [mem 0xfec8a000-0xfec8afff] could not be res=
erved
> [    0.518954] system 00:00: [mem 0xfed10000-0xfed10fff] has been reserved
> [    0.518956] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (acti=
ve)
> [    0.518984] pnp 00:01: [dma 4]
> [    0.518998] pnp 00:01: Plug and Play ACPI device, IDs PNP0200 (active)=
[    0.519024] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.519043] pnp 00:03: Plug and Play ACPI device, IDs PNP0800 (active)
> [    0.519064] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
> [    0.519216] pnp 00:05: [dma 0 disabled]
> [    0.519258] pnp 00:05: Plug and Play ACPI device, IDs PNP0501 (active)
> [    0.519402] pnp 00:06: [dma 0 disabled]
> [    0.519459] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
> [    0.519620] pnp 00:07: [dma 2]
> [    0.519655] pnp 00:07: Plug and Play ACPI device, IDs PNP0700 (active)
> [    0.519791] system 00:08: [io  0x04d0-0x04d1] has been reserved
> [    0.519794] system 00:08: [io  0x0800-0x087f] could not be reserved
> [    0.519796] system 00:08: [io  0x0500-0x057f] could not be reserved
> [    0.519798] system 00:08: [mem 0xfed1c000-0xfed1ffff] has been reserved
> [    0.519800] system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    0.519802] system 00:08: [mem 0xfed40000-0xfed8ffff] has been reserved
> [    0.519804] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
> [    0.519859] pnp 00:09: Plug and Play ACPI device, IDs PNP0103 (active)
> [    0.519941] system 00:0a: [mem 0xfec00000-0xfec00fff] could not be res=
erved
> [    0.519943] system 00:0a: [mem 0xfee00000-0xfee00fff] has been reserved
> [    0.519945] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
> [    0.520010] pnp 00:0b: Plug and Play ACPI device, IDs PNP0f03 PNP0f13 =
(active
> )
> [    0.520083] system 00:0c: [io  0x0a00-0x0a0f] has been reserved
> [    0.520085] system 00:0c: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
> [    0.520126] system 00:0d: [io  0x0ca2-0x0ca3] has been reserved
> [    0.520128] system 00:0d: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
> [    0.520192] system 00:0e: [mem 0xe0000000-0xefffffff] has been reserved
> [    0.520194] system 00:0e: Plug and Play ACPI device, IDs PNP0c02 (acti=
ve)
> [    0.520338] system 00:0f: [mem 0x00000000-0x0009ffff] could not be res=
erved
> [    0.520340] system 00:0f: [mem 0x000c0000-0x000cffff] could not be res=
erved
> [    0.520341] system 00:0f: [mem 0x000e0000-0x000fffff] could not be res=
erved
> [    0.520343] system 00:0f: [mem 0x00100000-0xbfffffff] could not be res=
erved
> [    0.520345] system 00:0f: [mem 0xfed90000-0xffffffff] could not be res=
erved
> [    0.520347] system 00:0f: Plug and Play ACPI device, IDs PNP0c01 (acti=
ve)
> [    0.520438] pnp: PnP ACPI: found 16 devices
> [    0.520439] ACPI: bus type PNP unregistered
> [    0.527304] PCI: max bus depth: 2 pci_try_num: 3
> [    0.527358] pci 0000:00:1f.0: BAR 13: [io  0x0800-0x087f] has bogus al=
ignment
> [    0.527362] pci 0000:00:1c.0: BAR 14: assigned [mem 0xc0000000-0xc01ff=
fff]
> [    0.527364] pci 0000:00:1c.0: BAR 15: assigned [mem 0xc0200000-0xc03ff=
fff 64b
> it pref]
> [    0.527366] pci 0000:00:1c.4: BAR 15: assigned [mem 0xc0400000-0xc05ff=
fff 64b
> it pref]
> [    0.527368] pci 0000:00:1c.0: BAR 13: assigned [io 0x1000-0x1fff]
> [    0.527379] pci 0000:0a:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527390] pci 0000:0a:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527400] pci 0000:0a:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527410] pci 0000:0a:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527420] pci 0000:0a:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527430] pci 0000:0a:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527440] pci 0000:0a:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527450] pci 0000:0a:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527461] pci 0000:0a:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527471] pci 0000:0a:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527481] pci 0000:0a:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527483] pci 0000:0a:00.0: BAR 7: can't assign mem (size 0x20000)
> [    0.527493] pci 0000:0a:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527495] pci 0000:0a:00.0: BAR 10: can't assign mem (size 0x20000)
> [    0.527505] pci 0000:0a:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527507] pci 0000:0a:00.1: BAR 7: can't assign mem (size 0x20000)
> [    0.527517] pci 0000:0a:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527518] pci 0000:0a:00.1: BAR 10: can't assign mem (size 0x20000)
> [    0.527520] pci 0000:00:01.0: PCI bridge to [bus 0a][ 0.527522] pci 00=
00:00:01.0:   bridge window [io  0xe000-0xefff]
> [    0.527525] pci 0000:00:01.0:   bridge window [mem 0xfbe00000-0xfbefff=
ff]
> [    0.527530] pci 0000:00:03.0: PCI bridge to [bus 09]
> [    0.527537] pci 0000:00:05.0: PCI bridge to [bus 08]
> [    0.527539] pci 0000:00:05.0:   bridge window [io  0xd000-0xdfff]
> [    0.527542] pci 0000:00:05.0:   bridge window [mem 0xf9f00000-0xfbdfff=
ff]
> [    0.527545] pci 0000:00:05.0:   bridge window [mem 0xd6000000-0xdfffff=
ff 64bi
> t pref]
> [    0.527549] pci 0000:00:07.0: PCI bridge to [bus 07]
> [    0.527556] pci 0000:04:00.0: PCI bridge to [bus 06]
> [    0.527563] pci 0000:04:00.2: PCI bridge to [bus 05]
> [    0.527570] pci 0000:00:09.0: PCI bridge to [bus 04-06]
> [    0.527577] pci 0000:00:1c.0: PCI bridge to [bus 03]
> [    0.527579] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> [    0.527583] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc01fff=
ff]
> [    0.527586] pci 0000:00:1c.0:   bridge window [mem 0xc0200000-0xc03fff=
ff 64bi
> t pref]
> [    0.527590] pci 0000:00:1c.4: PCI bridge to [bus 02]
> [    0.527592] pci 0000:00:1c.4:   bridge window [io  0xc000-0xcfff]
> [    0.527596] pci 0000:00:1c.4:   bridge window [mem 0xf9e00000-0xf9efff=
ff]
> [    0.527599] pci 0000:00:1c.4:   bridge window [mem 0xc0400000-0xc05fff=
ff 64bi
> t pref]
> [    0.527603] pci 0000:00:1e.0: PCI bridge to [bus 01]
> [    0.527605] pci 0000:00:1e.0:   bridge window [io  0xb000-0xbfff]
> [    0.527609] pci 0000:00:1e.0:   bridge window [mem 0xf9d00000-0xf9dfff=
ff]
> [    0.527612] pci 0000:00:1e.0:   bridge window [mem 0xc8000000-0xcfffff=
ff 64bi
> t pref]
> [    0.527617] PCI: No. 2 try to assign unassigned res
> [    0.527618] release child resource [mem 0xfbe1c000-0xfbe1ffff]
> [    0.527619] release child resource [mem 0xfbe20000-0xfbe3ffff pref]
> [    0.527620] release child resource [mem 0xfbe40000-0xfbe5ffff]
> [    0.527621] release child resource [mem 0xfbe60000-0xfbe7ffff]
> [    0.527622] release child resource [mem 0xfbe9c000-0xfbe9ffff]
> [    0.527623] release child resource [mem 0xfbea0000-0xfbebffff pref]
> [    0.527624] release child resource [mem 0xfbec0000-0xfbedffff]
> [    0.527624] release child resource [mem 0xfbee0000-0xfbefffff]
> [    0.527626] pci 0000:00:01.0: resource 14 [mem 0xfbe00000-0xfbefffff] =
release
> d
> [    0.527627] pci 0000:00:01.0: PCI bridge to [bus 0a]
> [    0.527643] pci 0000:0a:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527654] pci 0000:0a:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527664] pci 0000:0a:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527674] pci 0000:0a:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527720] pci 0000:00:1f.0: BAR 13: [io  0x0800-0x087f] has bogus al=
ignment
> [    0.527722] pci 0000:00:01.0: BAR 14: assigned [mem 0xc0600000-0xc07ff=
fff]
> [    0.527724] pci 0000:00:01.0: BAR 15: assigned [mem 0xc0800000-0xc08ff=
fff pre
> f]
> [    0.527735] pci 0000:0a:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527745] pci 0000:0a:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527755] pci 0000:0a:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527766] pci 0000:0a:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527776] pci 0000:0a:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527786] pci 0000:0a:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527796] pci 0000:0a:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527806] pci 0000:0a:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527816] pci 0000:0a:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527826] pci 0000:0a:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527837] pci 0000:0a:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527847] pci 0000:0a:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527848] pci 0000:0a:00.0: BAR 0: assigned [mem 0xc0600000-0xc061ff=
ff]
> [    0.527852] pci 0000:0a:00.0: BAR 1: assigned [mem 0xc0620000-0xc063ff=
ff]
> [    0.527856] pci 0000:0a:00.0: BAR 6: assigned [mem 0xc0800000-0xc081ff=
ff pref
> ]
> [    0.527858] pci 0000:0a:00.1: BAR 0: assigned [mem 0xc0640000-0xc065ff=
ff]
> [    0.527861] pci 0000:0a:00.1: BAR 1: assigned [mem 0xc0660000-0xc067ff=
ff]
> [    0.527865] pci 0000:0a:00.1: BAR 6: assigned [mem 0xc0820000-0xc083ff=
ff pref
> ]
> [    0.527866] pci 0000:0a:00.0: BAR 3: assigned [mem 0xc0680000-0xc0683f=
ff]
> [    0.527878] pci 0000:0a:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527880] pci 0000:0a:00.0: BAR 7: assigned [mem 0xc0684000-0xc06a3f=
ff 64bi
> t]
> [    0.527896] pci 0000:0a:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527897] pci 0000:0a:00.0: BAR 10: assigned [mem 0xc06a4000-0xc06c3=
fff 64b
> it]
> [    0.527905] pci 0000:0a:00.1: BAR 3: assigned [mem 0xc06c4000-0xc06c7f=
ff]
> [    0.527917] pci 0000:0a:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527918] pci 0000:0a:00.1: BAR 7: assigned [mem 0xc06c8000-0xc06e7f=
ff 64bi
> t]
> [    0.527934] pci 0000:0a:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64=
bit]
> [    0.527936] pci 0000:0a:00.1: BAR 10: assigned [mem 0xc06e8000-0xc0707=
fff 64b
> it]
> [    0.527943] pci 0000:00:01.0: PCI bridge to [bus 0a]
> [    0.527945] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
> [    0.527948] pci 0000:00:01.0:   bridge window [mem 0xc0600000-0xc07fff=
ff]
> [    0.527951] pci 0000:00:01.0:   bridge window [mem 0xc0800000-0xc08fff=
ff pref
> ]
> [    0.527955] pci 0000:00:03.0: PCI bridge to [bus 09]
> [    0.527961] pci 0000:00:05.0: PCI bridge to [bus 08]
> [    0.527963] pci 0000:00:05.0:   bridge window [io  0xd000-0xdfff]
> [    0.527967] pci 0000:00:05.0:   bridge window [mem 0xf9f00000-0xfbdfff=
ff]
> [    0.527969] pci 0000:00:05.0:   bridge window [mem 0xd6000000-0xdfffff=
ff 64bi
> t pref]
> [    0.527973] pci 0000:00:07.0: PCI bridge to [bus 07]
> [    0.527980] pci 0000:04:00.0: PCI bridge to [bus 06]
> [    0.527987] pci 0000:04:00.2: PCI bridge to [bus 05]
> [    0.527994] pci 0000:00:09.0: PCI bridge to [bus 04-06]
> [    0.528001] pci 0000:00:1c.0: PCI bridge to [bus 03]
> [    0.528003] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> [    0.528006] pci 0000:00:1c.0:   bridge window [mem 0xc0000000-0xc01fff=
ff]
> [    0.528009] pci 0000:00:1c.0:   bridge window [mem 0xc0200000-0xc03fff=
ff 64bi
> t pref]
> [    0.528014] pci 0000:00:1c.4: PCI bridge to [bus 02]
> [    0.528016] pci 0000:00:1c.4:   bridge window [io  0xc000-0xcfff]
> [    0.528020] pci 0000:00:1c.4:   bridge window [mem 0xf9e00000-0xf9efff=
ff]
> [    0.528023] pci 0000:00:1c.4:   bridge window [mem 0xc0400000-0xc05fff=
ff 64bi
> t pref]
> [    0.528027] pci 0000:00:1e.0: PCI bridge to [bus 01]
> [    0.528029] pci 0000:00:1e.0:   bridge window [io  0xb000-0xbfff]
> [    0.528033] pci 0000:00:1e.0:   bridge window [mem 0xf9d00000-0xf9dfff=
ff]
> [    0.528036] pci 0000:00:1e.0:   bridge window [mem 0xc8000000-0xcfffff=
ff 64bi
> t pref]
> [    0.528059] pci 0000:00:1c.0: enabling device (0104 -> 0107)
> [    0.528197] pci 0000:00:1e.0: setting latency timer to 64
> [    0.528201] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
> [    0.528203] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff]
> [    0.528204] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff]
> [    0.528206] pci_bus 0000:00: resource 7 [mem 0x000d0000-0x000dffff]
> [    0.528207] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xdfffffff]
> [    0.528209] pci_bus 0000:00: resource 9 [mem 0xf0000000-0xfed8ffff]
> [    0.528210] pci_bus 0000:0a: resource 0 [io  0xe000-0xefff]
> [    0.528211] pci_bus 0000:0a: resource 1 [mem 0xc0600000-0xc07fffff]
> [    0.528213] pci_bus 0000:0a: resource 2 [mem 0xc0800000-0xc08fffff pre=
f]
> [    0.528215] pci_bus 0000:08: resource 0 [io  0xd000-0xdfff]
> [    0.528216] pci_bus 0000:08: resource 1 [mem 0xf9f00000-0xfbdfffff]
> [    0.528217] pci_bus 0000:08: resource 2 [mem 0xd6000000-0xdfffffff 64b=
it pref
> ]
> [    0.528219] pci_bus 0000:03: resource 0 [io  0x1000-0x1fff]
> [    0.528221] pci_bus 0000:03: resource 1 [mem 0xc0000000-0xc01fffff]
> [    0.528222] pci_bus 0000:03: resource 2 [mem 0xc0200000-0xc03fffff 64b=
it pref
> ]
> [    0.528224] pci_bus 0000:02: resource 0 [io  0xc000-0xcfff]
> [    0.528225] pci_bus 0000:02: resource 1 [mem 0xf9e00000-0xf9efffff]
> [    0.528227] pci_bus 0000:02: resource 2 [mem 0xc0400000-0xc05fffff 64b=
it pref
> ]
> [    0.528228] pci_bus 0000:01: resource 0 [io  0xb000-0xbfff]
> [    0.528229] pci_bus 0000:01: resource 1 [mem 0xf9d00000-0xf9dfffff]
> [    0.528231] pci_bus 0000:01: resource 2 [mem 0xc8000000-0xcfffffff 64b=
it pref
> ]
> [    0.528232] pci_bus 0000:01: resource 4 [io  0x0000-0x0cf7]
> [    0.528234] pci_bus 0000:01: resource 5 [io  0x0d00-0xffff]
> [    0.528235] pci_bus 0000:01: resource 6 [mem 0x000a0000-0x000bffff]
> [    0.528237] pci_bus 0000:01: resource 7 [mem 0x000d0000-0x000dffff]
> [    0.528238] pci_bus 0000:01: resource 8 [mem 0xc0000000-0xdfffffff]
> [    0.528239] pci_bus 0000:01: resource 9 [mem 0xf0000000-0xfed8ffff]
> [    0.528241] pci_bus 0000:fe: resource 4 [io  0x0000-0xffff]
> [    0.528242] pci_bus 0000:fe: resource 5 [mem 0x00000000-0xffffffffff]
> [    0.528244] pci_bus 0000:ff: resource 4 [io  0x0000-0xffff]
> [    0.528246] pci_bus 0000:ff: resource 5 [mem 0x00000000-0xffffffffff]
> [    0.528281] NET: Registered protocol family 2
> [    0.528610] TCP established hash table entries: 262144 (order: 10, 419=
4304 by
> tes)
> [    0.529291] TCP bind hash table entries: 65536 (order: 8, 1048576 byte=
s)
> [    0.529454] TCP: Hash tables configured (established 262144 bind 65536)
> [    0.529481] TCP: reno registered
> [    0.529515] UDP hash table entries: 16384 (order: 7, 524288 bytes)
> [    0.529627] UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes)
> [    0.529824] NET: Registered protocol family 1
> [    0.530957] pci 0000:08:00.0: Boot video device
> [    0.530967] pci 0000:04:00.0: rerouting interrupts for [8086:0329]
> [    0.530971] pci 0000:04:00.2: rerouting interrupts for [8086:032a]
> [    0.531020] PCI: CLS 256 bytes, default 64
> [    0.531060] Trying to unpack rootfs image as initramfs...
> [    0.883281] Freeing initrd memory: 24816K (ffff880034f78000 - ffff8800=
367b400
> 0)
> [    0.883298] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    0.883300] software IO TLB [mem 0xbb770000-0xbf770000] (64MB) mapped =
at [fff
> f8800bb770000-ffff8800bf76ffff]
> [    0.883663] Scanning for low memory corruption every 60 seconds
> [    0.884045] Initialise module verification
> [    0.884089] audit: initializing netlink socket (disabled)
> [    0.884104] type=3D2000 audit(1390237456.736:1): initialized
> [    0.906420] bounce pool size: 64 pages
> [    0.906429] HugeTLB registered 2 MB page size, pre-allocated 0 pages
> [    0.908190] zbud: loaded
> [    0.908318] VFS: Disk quotas dquot_6.5.2
> [    0.908365] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.908860] fuse init (API version 7.22)
> [    0.908951] msgmni has been set to 32768
> [    0.909518] Key type asymmetric registered
> [    0.909520] Asymmetric key parser 'x509' registered
> [    0.909564] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 2
> 52)
> [    0.909606] io scheduler noop registered
> [    0.909607] io scheduler deadline registered (default)
> [    0.909633] io scheduler cfq registered
> [    0.909794] pcieport 0000:00:01.0: irq 112 for MSI/MSI-X
> [    0.909857] pcieport 0000:00:03.0: irq 113 for MSI/MSI-X
> [    0.909916] pcieport 0000:00:05.0: irq 114 for MSI/MSI-X[ 0.910034] pc=
ieport 0000:00:09.0: irq 116 for MSI/MSI-X
> [    0.910093] pcieport 0000:00:1c.0: irq 117 for MSI/MSI-X
> [    0.910164] pcieport 0000:00:1c.4: irq 118 for MSI/MSI-X
> [    0.910245] aer 0000:00:01.0:pcie02: service driver aer loaded
> [    0.910263] aer 0000:00:03.0:pcie02: service driver aer loaded
> [    0.910280] aer 0000:00:05.0:pcie02: service driver aer loaded
> [    0.910297] aer 0000:00:07.0:pcie02: service driver aer loaded
> [    0.910315] aer 0000:00:09.0:pcie02: service driver aer loaded
> [    0.910324] pcieport 0000:00:01.0: Signaling PME through PCIe PME inte=
rrupt
> [    0.910326] pci 0000:0a:00.0: Signaling PME through PCIe PME interrupt
> [    0.910327] pci 0000:0a:00.1: Signaling PME through PCIe PME interrupt
> [    0.910330] pcie_pme 0000:00:01.0:pcie01: service driver pcie_pme load=
ed
> [    0.910336] pcieport 0000:00:03.0: Signaling PME through PCIe PME inte=
rrupt
> [    0.910338] pcie_pme 0000:00:03.0:pcie01: service driver pcie_pme load=
ed
> [    0.910344] pcieport 0000:00:05.0: Signaling PME through PCIe PME inte=
rrupt
> [    0.910345] pci 0000:08:00.0: Signaling PME through PCIe PME interrupt
> [    0.910347] pci 0000:08:00.1: Signaling PME through PCIe PME interrupt
> [    0.910350] pcie_pme 0000:00:05.0:pcie01: service driver pcie_pme load=
ed
> [    0.910355] pcieport 0000:00:07.0: Signaling PME through PCIe PME inte=
rrupt
> [    0.910358] pcie_pme 0000:00:07.0:pcie01: service driver pcie_pme load=
ed
> [    0.910363] pcieport 0000:00:09.0: Signaling PME through PCIe PME inte=
rrupt
> [    0.910365] pci 0000:04:00.0: Signaling PME through PCIe PME interrupt
> [    0.910366] pci 0000:04:00.2: Signaling PME through PCIe PME interrupt
> [    0.910368] pcie_pme 0000:00:09.0:pcie01: service driver pcie_pme load=
ed
> [    0.910393] pcieport 0000:00:1c.0: Signaling PME through PCIe PME inte=
rrupt
> [    0.910396] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme load=
ed
> [    0.910409] pcieport 0000:00:1c.4: Signaling PME through PCIe PME inte=
rrupt
> [    0.910411] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
> [    0.910414] pcie_pme 0000:00:1c.4:pcie01: service driver pcie_pme load=
ed
> [    0.910428] ioapic: probe of 0000:00:13.0 failed with error -22
> [    0.910437] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> [    0.910447] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> [    0.910500] intel_idle: MWAIT substates: 0x1120
> [    0.910502] intel_idle: v0.4 model 0x2C
> [    0.910502] intel_idle: lapic_timer_reliable_states 0xffffffff
> [    0.910625] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0=
C0C:00/
> input/input0
> [    0.910629] ACPI: Power Button [PWRB]
> [    0.910658] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/in=
put/inp
> ut1
> [    0.910660] ACPI: Power Button [PWRF]
> [    0.910724] ACPI: Requesting acpi_cpufreq
> [    0.911051] GHES: HEST is not enabled!
> [    0.911113] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    0.931469] 00:05: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
> [    0.951830] 00:06: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
> [    0.953037] Linux agpgart interface v0.103
> [    0.954326] brd: module loaded
> [    0.954998] loop: module loaded
> [    0.955086] ata_piix 0000:00:1f.2: version 2.13
> [    0.955174] ata_piix 0000:00:1f.2: MAP [
> [    0.955175]  P0 P2 P1 P3 ]
> [    0.955206] ata_piix 0000:00:1f.2: setting latency timer to 64
> [    0.955381] scsi0 : ata_piix
> [    0.955738] scsi1 : ata_piix
> [    0.956014] ata1: SATA max UDMA/133 cmd 0xac00 ctl 0xa880 bmdma 0xa400=
 irq 19
> [    0.956018] ata2: SATA max UDMA/133 cmd 0xa800 ctl 0xa480 bmdma 0xa408=
 irq 19
> [    0.956090] ata_piix 0000:00:1f.5: MAP [
> [    0.956091]  P0 -- P1 -- ]
> [    0.956116] ata_piix 0000:00:1f.5: setting latency timer to 64
> [    0.956246] scsi2 : ata_piix
> [    0.956509] scsi3 : ata_piix
> [    0.956744] ata3: SATA max UDMA/133 cmd 0x9c00 ctl 0x9880 bmdma 0x9400=
 irq 19[    0.956747] ata4: SATA max UDMA/133 cmd 0x9800 ctl 0x9480 bmdma 0=
x9408 irq 19
> [    0.956959] libphy: Fixed MDIO Bus: probed
> [    0.957020] tun: Universal TUN/TAP device driver, 1.6
> [    0.957021] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> [    0.957058] PPP generic driver version 2.4.2
> [    0.957096] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    0.957097] ehci-pci: EHCI PCI platform driver
> [    0.957181] ehci-pci 0000:00:1a.7: setting latency timer to 64
> [    0.957193] ehci-pci 0000:00:1a.7: EHCI Host Controller
> [    0.957197] ehci-pci 0000:00:1a.7: new USB bus registered, assigned bu=
s numbe
> r 1
> [    0.957209] ehci-pci 0000:00:1a.7: debug port 1
> [    0.961119] ehci-pci 0000:00:1a.7: cache line size of 256 is not suppo=
rted
> [    0.961130] ehci-pci 0000:00:1a.7: irq 18, io mem 0xf9cfa000
> [    0.970384] ehci-pci 0000:00:1a.7: USB 2.0 started, EHCI 1.00
> [    0.970403] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
> [    0.970404] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D
> 1
> [    0.970405] usb usb1: Product: EHCI Host Controller
> [    0.970407] usb usb1: Manufacturer: Linux 3.11.0-15-generic ehci_hcd
> [    0.970408] usb usb1: SerialNumber: 0000:00:1a.7
> [    0.970484] hub 1-0:1.0: USB hub found
> [    0.970488] hub 1-0:1.0: 6 ports detected
> [    0.970649] ehci-pci 0000:00:1d.7: setting latency timer to 64
> [    0.970660] ehci-pci 0000:00:1d.7: EHCI Host Controller
> [    0.970665] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bu=
s numbe
> r 2
> [    0.970675] ehci-pci 0000:00:1d.7: debug port 1
> [    0.974574] ehci-pci 0000:00:1d.7: cache line size of 256 is not suppo=
rted
> [    0.974585] ehci-pci 0000:00:1d.7: irq 23, io mem 0xf9cfc000
> [    0.986376] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
> [    0.986386] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
> [    0.986388] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D
> 1
> [    0.986389] usb usb2: Product: EHCI Host Controller
> [    0.986390] usb usb2: Manufacturer: Linux 3.11.0-15-generic ehci_hcd
> [    0.986392] usb usb2: SerialNumber: 0000:00:1d.7
> [    0.986457] hub 2-0:1.0: USB hub found
> [    0.986460] hub 2-0:1.0: 6 ports detected
> [    0.986548] ehci-platform: EHCI generic platform driver
> [    0.986554] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    0.986555] ohci-pci: OHCI PCI platform driver
> [    0.986564] ohci-platform: OHCI generic platform driver
> [    0.986568] uhci_hcd: USB Universal Host Controller Interface driver
> [    0.986644] uhci_hcd 0000:00:1a.0: setting latency timer to 64
> [    0.986647] uhci_hcd 0000:00:1a.0: UHCI Host Controller
> [    0.986650] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bu=
s numbe
> r 3
> [    0.986680] uhci_hcd 0000:00:1a.0: irq 16, io base 0x00008400
> [    0.986703] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
> [    0.986705] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D
> 1
> [    0.986706] usb usb3: Product: UHCI Host Controller
> [    0.986707] usb usb3: Manufacturer: Linux 3.11.0-15-generic uhci_hcd
> [    0.986709] usb usb3: SerialNumber: 0000:00:1a.0
> [    0.986778] hub 3-0:1.0: USB hub found
> [    0.986781] hub 3-0:1.0: 2 ports detected
> [    0.986905] uhci_hcd 0000:00:1a.1: setting latency timer to 64
> [    0.986908] uhci_hcd 0000:00:1a.1: UHCI Host Controller
> [    0.986912] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bu=
s numbe
> r 4
> [    0.986938] uhci_hcd 0000:00:1a.1: irq 21, io base 0x00008480[ 0.98696=
2] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D
> 1
> [    0.986963] usb usb4: Product: UHCI Host Controller
> [    0.986965] usb usb4: Manufacturer: Linux 3.11.0-15-generic uhci_hcd
> [    0.986966] usb usb4: SerialNumber: 0000:00:1a.1
> [    0.987034] hub 4-0:1.0: USB hub found
> [    0.987036] hub 4-0:1.0: 2 ports detected
> [    0.987161] uhci_hcd 0000:00:1a.2: setting latency timer to 64
> [    0.987163] uhci_hcd 0000:00:1a.2: UHCI Host Controller
> [    0.987167] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bu=
s numbe
> r 5
> [    0.987187] uhci_hcd 0000:00:1a.2: irq 19, io base 0x00008800
> [    0.987209] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
> [    0.987211] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D
> 1
> [    0.987212] usb usb5: Product: UHCI Host Controller
> [    0.987214] usb usb5: Manufacturer: Linux 3.11.0-15-generic uhci_hcd
> [    0.987215] usb usb5: SerialNumber: 0000:00:1a.2
> [    0.987283] hub 5-0:1.0: USB hub found
> [    0.987286] hub 5-0:1.0: 2 ports detected
> [    0.987406] uhci_hcd 0000:00:1d.0: setting latency timer to 64
> [    0.987408] uhci_hcd 0000:00:1d.0: UHCI Host Controller
> [    0.987412] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bu=
s numbe
> r 6
> [    0.987432] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00008880
> [    0.987453] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
> [    0.987455] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D
> 1
> [    0.987456] usb usb6: Product: UHCI Host Controller
> [    0.987457] usb usb6: Manufacturer: Linux 3.11.0-15-generic uhci_hcd
> [    0.987459] usb usb6: SerialNumber: 0000:00:1d.0
> [    0.987520] hub 6-0:1.0: USB hub found
> [    0.987523] hub 6-0:1.0: 2 ports detected
> [    0.987645] uhci_hcd 0000:00:1d.1: setting latency timer to 64
> [    0.987647] uhci_hcd 0000:00:1d.1: UHCI Host Controller
> [    0.987651] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bu=
s numbe
> r 7
> [    0.987673] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00008c00
> [    0.987695] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
> [    0.987696] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D
> 1
> [    0.987697] usb usb7: Product: UHCI Host Controller
> [    0.987699] usb usb7: Manufacturer: Linux 3.11.0-15-generic uhci_hcd
> [    0.987700] usb usb7: SerialNumber: 0000:00:1d.1
> [    0.987762] hub 7-0:1.0: USB hub found
> [    0.987765] hub 7-0:1.0: 2 ports detected
> [    0.987885] uhci_hcd 0000:00:1d.2: setting latency timer to 64
> [    0.987887] uhci_hcd 0000:00:1d.2: UHCI Host Controller
> [    0.987891] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bu=
s numbe
> r 8
> [    0.987911] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00009000
> [    0.987933] usb usb8: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
> [    0.987934] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, Se=
rialNumber=3D
> 1
> [    0.987936] usb usb8: Product: UHCI Host Controller
> [    0.987937] usb usb8: Manufacturer: Linux 3.11.0-15-generic uhci_hcd
> [    0.987938] usb usb8: SerialNumber: 0000:00:1d.2
> [    0.988000] hub 8-0:1.0: USB hub found
> [    0.988003] hub 8-0:1.0: 2 ports detected
> [    0.988105] i8042: PNP: PS/2 Controller [PNP0f03:PS2M] at 0x60,0x64 ir=
q 12[    0.990460] mousedev: PS/2 mouse device common for all mice
> [    0.990567] rtc_cmos 00:02: RTC can wake from S4
> [    0.990672] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
> [    0.990695] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvr=
am, hpe
> t irqs
> [    0.990745] device-mapper: uevent: version 1.0.3
> [    0.990794] device-mapper: ioctl: 4.25.0-ioctl (2013-06-26) initialise=
d: dm-d
> evel@redhat.com
> [    0.990958] cpuidle: using governor ladder
> [    0.991157] cpuidle: using governor menu
> [    0.991172] ledtrig-cpu: registered to indicate activity on CPUs
> [    0.991254] TCP: cubic registered
> [    0.991340] NET: Registered protocol family 10
> [    0.991535] NET: Registered protocol family 17
> [    0.991540] Key type dns_resolver registered
> [    0.991850] PM: Hibernation image not present or could not be loaded.
> [    0.991853] Loading module verification certificates
> [    0.992669] MODSIGN: Loaded cert 'Magrathea: Glacier signing key: 9da8=
9dd2dae
> ca3a3cb171fe18502208f132adef8'
> [    0.992677] registered taskstats version 1
> [    0.995106] Key type trusted registered
> [    0.996863] Key type encrypted registered
> [    0.999112] AppArmor: AppArmor sha1 policy hashing enabled
> [    0.999824]   Magic number: 14:786:87
> [    0.999856] button LNXPWRBN:00: hash matches
> [    0.999887] memory memory240: hash matches
> [    1.000170] rtc_cmos 00:02: setting system clock to 2014-01-20 17:04:1=
7 UTC (
> 1390237457)
> [    1.003236] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
> [    1.003238] EDD information not available.
> [    1.285021] ata4: SATA link down (SStatus 0 SControl 300)
> [    1.295666] ata3: SATA link down (SStatus 0 SControl 300)
> [    1.686283] usb 6-1: new low-speed USB device number 2 using uhci_hcd
> [    1.750328] ata2.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.750340] ata2.01: SATA link down (SStatus 0 SControl 300)
> [    1.750461] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    1.750474] ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    1.759437] ata2.00: ATA-8: WDC WD2002FAEX-007BA0, 05.01D05, max UDMA/=
133
> [    1.759442] ata2.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 0/=
32)
> [    1.767501] ata2.00: configured for UDMA/133
> [    1.767516] ata1.00: ATA-8: WDC WD2002FAEX-007BA0, 05.01D05, max UDMA/=
133
> [    1.767520] ata1.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 0/=
32)
> [    1.767538] ata1.01: ATAPI: Optiarc DVD RW AD-7260S, 1.01, max UDMA/100
> [    1.774622] ata1.00: configured for UDMA/133
> [    1.790437] ata1.01: configured for UDMA/100
> [    1.791315] scsi 0:0:0:0: Direct-Access     ATA      WDC WD2002FAEX-0 =
05.0 PQ
> : 0 ANSI: 5
> [    1.791537] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.0=
0 TB/1.
> 81 TiB)
> [    1.791575] sd 0:0:0:0: [sda] Write Protect is off
> [    1.791577] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    1.791589] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enable=
d, does
> n't support DPO or FUA
> [    1.791636] sd 0:0:0:0: Attached scsi generic sg0 type 0
> [    1.793234] scsi 0:0:1:0: CD-ROM            Optiarc  DVD RW AD-7260S 1=
.01 PQ
> : 0 ANSI: 5
> [    1.803462] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form=
2 cdda
> tray
> [    1.803465] cdrom: Uniform CD-ROM driver Revision: 3.20
> [    1.803708] sr 0:0:1:0: Attached scsi CD-ROM sr0
> [    1.803935] sr 0:0:1:0: Attached scsi generic sg1 type 5
> [    1.804369] scsi 1:0:0:0: Direct-Access     ATA      WDC WD2002FAEX-0 =
05.0 PQ
> : 0 ANSI: 5[    1.804631] sd 1:0:0:0: Attached scsi generic sg2 type 0
> [    1.804727] sd 1:0:0:0: [sdb] 3907029168 512-byte logical blocks: (2.0=
0 TB/1.
> 81 TiB)
> [    1.805081] sd 1:0:0:0: [sdb] Write Protect is off
> [    1.805087] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> [    1.805227] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enable=
d, does
> n't support DPO or FUA
> [    1.834448]  sda: sda1 sda2 sda3
> [    1.835074] sd 0:0:0:0: [sda] Attached SCSI disk
> [    1.843963]  sdb: sdb1 sdb2 sdb3
> [    1.845138] sd 1:0:0:0: [sdb] Attached SCSI disk
> [    1.847389] Freeing unused kernel memory: 1364K (ffffffff81d10000 - ff=
ffffff8
> 1e65000)
> [    1.847391] Write protecting the kernel read-only data: 12288k
> [    1.851112] Freeing unused kernel memory: 1032K (ffff8800016fe000 - ff=
ff88000
> 1800000)
> [    1.853450] Freeing unused kernel memory: 784K (ffff880001b3c000 - fff=
f880001
> c00000)
> [    1.863311] usb 6-1: New USB device found, idVendor=3D046d, idProduct=
=3Dc31c
> [    1.863316] usb 6-1: New USB device strings: Mfr=3D1, Product=3D2, Ser=
ialNumber=3D0
> [    1.863319] usb 6-1: Product: USB Keyboard
> [    1.863322] usb 6-1: Manufacturer: Logitech
> [    1.868994] systemd-udevd[220]: starting version 204
> [    1.882208] tsc: Refined TSC clocksource calibration: 2933.437 MHz
> [    1.889807] Floppy drive(s): fd0 is 1.44M
> [    1.891903] pps_core: LinuxPPS API ver. 1 registered
> [    1.891905] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolf=
o Giome
> tti <giometti@linux.it>
> [    1.894929] PTP clock support registered
> [    1.895526] scsi4 : pata_jmicron
> [    1.895713] scsi5 : pata_jmicron
> [    1.895755] ata5: PATA max UDMA/100 cmd 0xc400 ctl 0xcc00 bmdma 0xc480=
 irq 16
> [    1.895757] ata6: PATA max UDMA/100 cmd 0xc880 ctl 0xc800 bmdma 0xc488=
 irq 16
> [    1.896738] dca service started, version 1.12.1
> [    1.901805] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.=
0.5-k
> [    1.901807] igb: Copyright (c) 2007-2013 Intel Corporation.
> [    1.901921] [drm] Initialized drm 1.1.0 20060810
> [    1.902075] igb 0000:0a:00.0: irq 119 for MSI/MSI-X
> [    1.902081] igb 0000:0a:00.0: irq 120 for MSI/MSI-X
> [    1.902085] igb 0000:0a:00.0: irq 121 for MSI/MSI-X
> [    1.902089] igb 0000:0a:00.0: irq 122 for MSI/MSI-X
> [    1.902094] igb 0000:0a:00.0: irq 123 for MSI/MSI-X
> [    1.902098] igb 0000:0a:00.0: irq 124 for MSI/MSI-X
> [    1.902102] igb 0000:0a:00.0: irq 125 for MSI/MSI-X
> [    1.902106] igb 0000:0a:00.0: irq 126 for MSI/MSI-X
> [    1.902111] igb 0000:0a:00.0: irq 127 for MSI/MSI-X
> [    1.905896] FDC 0 is a post-1991 82077
> [    1.915259] hidraw: raw HID events driver (C) Jiri Kosina
> [    1.927964] [drm] VGACON disable radeon kernel modesetting.
> [    1.927966] [drm] radeon userspace modesetting enabled.
> [    1.928250] pci 0000:01:01.0: enabling device (0080 -> 0083)
> [    1.928555] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
> [    1.928558] [drm] No driver support for vblank timestamp query.
> [    1.928561] [drm] Initialized radeon 1.33.0 20080528 for 0000:01:01.0 =
on mino
> r 0
> [    1.960312] usbcore: registered new interface driver usbhid
> [    1.960314] usbhid: USB HID core driver
> [    1.964733] input: Logitech USB Keyboard as /devices/pci0000:00/0000:0=
0:1d.0/
> usb6/6-1/6-1:1.0/input/input2[    1.978688] hid-generic 0003:046D:C31C.00=
02: input,hidraw1: USB HID v1.10 Dev
> ice [Logitech USB Keyboard] on usb-0000:00:1d.0-1/input1
> [    2.102654] igb 0000:0a:00.0: added PHC on eth0
> [    2.102658] igb 0000:0a:00.0: Intel(R) Gigabit Ethernet Network Connec=
tion
> [    2.102662] igb 0000:0a:00.0: eth0: (PCIe:2.5Gb/s:Width x4) 00:25:90:1=
8:7a:2a
> [    2.102665] igb 0000:0a:00.0: eth0: PBA No: Unknown
> [    2.102668] igb 0000:0a:00.0: Using MSI-X interrupts. 8 rx queue(s), 8=
 tx que
> ue(s)
> [    2.102955] igb 0000:0a:00.1: irq 128 for MSI/MSI-X
> [    2.102960] igb 0000:0a:00.1: irq 129 for MSI/MSI-X
> [    2.102965] igb 0000:0a:00.1: irq 130 for MSI/MSI-X
> [    2.102969] igb 0000:0a:00.1: irq 131 for MSI/MSI-X
> [    2.102973] igb 0000:0a:00.1: irq 132 for MSI/MSI-X
> [    2.102978] igb 0000:0a:00.1: irq 133 for MSI/MSI-X
> [    2.102982] igb 0000:0a:00.1: irq 134 for MSI/MSI-X
> [    2.102987] igb 0000:0a:00.1: irq 135 for MSI/MSI-X
> [    2.102991] igb 0000:0a:00.1: irq 136 for MSI/MSI-X
> [    2.294544] igb 0000:0a:00.1: added PHC on eth1
> [    2.294549] igb 0000:0a:00.1: Intel(R) Gigabit Ethernet Network Connec=
tion
> [    2.294552] igb 0000:0a:00.1: eth1: (PCIe:2.5Gb/s:Width x4) 00:25:90:1=
8:7a:2b
> [    2.294557] igb 0000:0a:00.1: eth1: PBA No: Unknown
> [    2.294560] igb 0000:0a:00.1: Using MSI-X interrupts. 8 rx queue(s), 8=
 tx que
> ue(s)
> [    2.882519] Switched to clocksource tsc
> [    3.299482] vesafb: module verification failed: signature and/or requi=
red key
>   missing - tainting kernel
> [    3.496158] EXT4-fs (sda2): mounted filesystem with ordered data mode.=
 Opts:
> (null)
> [   16.607685] Adding 79000572k swap on /dev/sda3.  Priority:-1 extents:1=
 across
> :79000572k FS
> [   16.679406] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [   16.679411] IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
> [   16.764922] systemd-udevd[498]: starting version 204
> [   16.972682] lp: driver loaded but no devices found
> [   16.979045] i801_smbus 0000:00:1f.3: SMBus using PCI Interrupt
> [   16.982942] ipmi message handler version 39.2
> [   16.985298] IPMI System Interface driver.
> [   16.985340] ipmi_si: probing via SMBIOS
> [   16.985342] ipmi_si: Adding default-specified kcs state machine
> [   16.985344] ipmi_si: Trying default-specified kcs state machine at i/o=
 addres
> s 0xca2, slave address 0x0, irq 0
> [   16.985349] ipmi_si: Interface detection failed
> [   17.000103] shpchp: Standard Hot Plug PCI Controller Driver version: 0=
.4
> [   17.000219] EDAC MC: Ver: 3.0.0
> [   17.002553] EDAC MC1: Giving out device to 'i7core_edac.c' 'i7 core #1=
': DEV
> 0000:fe:03.0
> [   17.002636] EDAC PCI0: Giving out device to module 'i7core_edac' contr=
oller '
> EDAC PCI controller': DEV '0000:fe:03.0' (POLLED)
> [   17.002814] ipmi_si: Adding default-specified smic state machine
> [   17.002819] ipmi_si: Trying default-specified smic state machine at i/=
o addre
> ss 0xca9, slave address 0x0, irq 0
> [   17.002823] ipmi_si: Interface detection failed
> [   17.003014] EDAC MC0: Giving out device to 'i7core_edac.c' 'i7 core #0=
': DEV
> 0000:ff:03.0
> [   17.003070] EDAC PCI1: Giving out device to module 'i7core_edac' contr=
oller '
> EDAC PCI controller': DEV '0000:ff:03.0' (POLLED)
> [   17.003245] EDAC i7core: Driver loaded, 2 memory controller(s) found.
> [   17.007514] ACPI Warning: 0x0000000000000828-0x000000000000082f System=
IO conf
> licts with Region \PMRG 1 (20130517/utaddress-251)
> [   17.007520] ACPI: If an ACPI driver is available for this device, you =
should
> use it instead of the native driver
> [   17.007569] lpc_ich: Resource conflict(s) found affecting gpio_ich
> [   17.023415] device-mapper: multipath: version 1.5.1 loaded[ 17.025099]=
 microcode: CPU0 sig=3D0x206c2, pf=3D0x1, revision=3D0x13
> [   17.031130] ioatdma: Intel(R) QuickData Technology Driver 4.00
> [   17.031323] ioatdma 0000:00:16.0: irq 137 for MSI/MSI-X
> [   17.031554] igb 0000:0a:00.0: DCA enabled
> [   17.031585] igb 0000:0a:00.1: DCA enabled
> [   17.031715] ioatdma 0000:00:16.1: irq 138 for MSI/MSI-X
> [   17.031982] ioatdma 0000:00:16.2: irq 139 for MSI/MSI-X
> [   17.032238] ioatdma 0000:00:16.3: irq 140 for MSI/MSI-X
> [   17.032466] ioatdma 0000:00:16.4: irq 141 for MSI/MSI-X
> [   17.032718] ioatdma 0000:00:16.5: irq 142 for MSI/MSI-X
> [   17.032955] ioatdma 0000:00:16.6: irq 143 for MSI/MSI-X
> [   17.033216] ioatdma 0000:00:16.7: irq 144 for MSI/MSI-X
> [   17.041708] hda_intel: Disabling MSI
> [   17.041715] hda-intel 0000:08:00.1: Handle VGA-switcheroo audio client
> [   17.041739] hda-intel 0000:08:00.1: Disabling 64bit DMA
> [   17.045080] hda-intel 0000:08:00.1: Enable delay in RIRB handling
> [   17.058842] ipmi_si: Adding default-specified bt state machine
> [   17.058843] ipmi_si: Trying default-specified bt state machine at i/o =
address
>   0xe4, slave address 0x0, irq 0
> [   17.058847] ipmi_si: Interface detection failed
> [   17.070962] gpio_ich: GPIO from 195 to 255 on gpio_ich
> [   17.077163] nvidia: module license 'NVIDIA' taints kernel.
> [   17.077167] Disabling lock debugging due to kernel taint
> [   17.094826] ipmi_si: Unable to find any System Interface(s)
> [   17.140934] i2c i2c-0: Found w83795adg rev. B at 0x2f
> [   17.146880] w83795 0-002f: PECI agent 1 Tbase temperature: 100
> [   17.147394] w83795 0-002f: PECI agent 2 Tbase temperature: 100
> [   17.209397] type=3D1400 audit(1390237473.706:2): apparmor=3D"STATUS" o=
peration=3D"p
> rofile_load" parent=3D648 profile=3D"unconfined" name=3D"/sbin/dhclient" =
pid=3D649 comm=3D
> "apparmor_parser"
> [   17.209403] type=3D1400 audit(1390237473.706:3): apparmor=3D"STATUS" o=
peration=3D"p
> rofile_load" parent=3D648 profile=3D"unconfined" name=3D"/usr/lib/Network=
Manager/nm-dh
> cp-client.action" pid=3D649 comm=3D"apparmor_parser"
> [   17.209407] type=3D1400 audit(1390237473.706:4): apparmor=3D"STATUS" o=
peration=3D"p
> rofile_load" parent=3D648 profile=3D"unconfined" name=3D"/usr/lib/connman=
/scripts/dhcl
> ient-script" pid=3D649 comm=3D"apparmor_parser"
> [   17.209422] type=3D1400 audit(1390237473.706:5): apparmor=3D"STATUS" o=
peration=3D"p
> rofile_replace" parent=3D572 profile=3D"unconfined" name=3D"/sbin/dhclien=
t" pid=3D647 co
> mm=3D"apparmor_parser"
> [   17.209429] type=3D1400 audit(1390237473.706:6): apparmor=3D"STATUS" o=
peration=3D"p
> rofile_replace" parent=3D572 profile=3D"unconfined" name=3D"/usr/lib/Netw=
orkManager/nm
> -dhcp-client.action" pid=3D647 comm=3D"apparmor_parser"
> [   17.209433] type=3D1400 audit(1390237473.706:7): apparmor=3D"STATUS" o=
peration=3D"p
> rofile_replace" parent=3D572 profile=3D"unconfined" name=3D"/usr/lib/conn=
man/scripts/d
> hclient-script" pid=3D647 comm=3D"apparmor_parser"
> [   17.209443] type=3D1400 audit(1390237473.706:8): apparmor=3D"STATUS" o=
peration=3D"p
> rofile_replace" parent=3D568 profile=3D"unconfined" name=3D"/sbin/dhclien=
t" pid=3D646 co
> mm=3D"apparmor_parser"
> [   17.209448] type=3D1400 audit(1390237473.706:9): apparmor=3D"STATUS" o=
peration=3D"p
> rofile_replace" parent=3D568 profile=3D"unconfined" name=3D"/usr/lib/Netw=
orkManager/nm
> -dhcp-client.action" pid=3D646 comm=3D"apparmor_parser"
> [   17.209452] type=3D1400 audit(1390237473.706:10): apparmor=3D"STATUS" =
operation=3D"
> profile_replace" parent=3D568 profile=3D"unconfined" name=3D"/usr/lib/con=
nman/scripts/
> dhclient-script" pid=3D646 comm=3D"apparmor_parser"
> [   17.209863] type=3D1400 audit(1390237473.706:11): apparmor=3D"STATUS" =
operation=3D"
> profile_replace" parent=3D648 profile=3D"unconfined" name=3D"/usr/lib/Net=
workManager/n
> m-dhcp-client.action" pid=3D649 comm=3D"apparmor_parser"
> [   17.224402] microcode: CPU1 sig=3D0x206c2, pf=3D0x1, revision=3D0x13
> [   17.225296] microcode: CPU2 sig=3D0x206c2, pf=3D0x1, revision=3D0x13
> [   17.225758] microcode: CPU3 sig=3D0x206c2, pf=3D0x1, revision=3D0x13
> [   17.226247] microcode: CPU4 sig=3D0x206c2, pf=3D0x1, revision=3D0x13
> [   17.226623] microcode: CPU5 sig=3D0x206c2, pf=3D0x1, revision=3D0x13[ =
17.228293] microcode: CPU7 sig=3D0x206c2, pf=3D0x1, revision=3D0x13
> [   17.228831] microcode: CPU8 sig=3D0x206c2, pf=3D0x1, revision=3D0x13
> [   17.229369] microcode: CPU9 sig=3D0x206c2, pf=3D0x1, revision=3D0x13
> [   17.229779] microcode: CPU10 sig=3D0x206c2, pf=3D0x1, revision=3D0x13
> [   17.230216] microcode: CPU11 sig=3D0x206c2, pf=3D0x1, revision=3D0x13
> [   17.230675] microcode: Microcode Update Driver: v2.00 <tigran@aivazian=
.fsnet.
> co.uk>, Peter Oruba
> [   17.243673] kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL does not work prop=
erly. U
> sing workaround
> [   17.375132] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
> [   17.522803] input: HDA NVidia HDMI/DP,pcm=3D9 as /devices/pci0000:00/0=
000:00:05
> .0/0000:08:00.1/sound/card0/input4
> [   17.522989] input: HDA NVidia HDMI/DP,pcm=3D8 as /devices/pci0000:00/0=
000:00:05
> .0/0000:08:00.1/sound/card0/input5
> [   17.523217] input: HDA NVidia HDMI/DP,pcm=3D7 as /devices/pci0000:00/0=
000:00:05
> .0/0000:08:00.1/sound/card0/input6
> [   17.523470] input: HDA NVidia HDMI/DP,pcm=3D3 as /devices/pci0000:00/0=
000:00:05
> .0/0000:08:00.1/sound/card0/input7
> [   17.524520] vgaarb: device changed decodes: PCI:0000:08:00.0,olddecode=
s=3Dio+me
> m,decodes=3Dnone:owns=3Dio+mem
> [   17.524527] vgaarb: transferring owner from PCI:0000:08:00.0 to PCI:00=
00:01:0
> 1.0
> [   17.524748] [drm] Initialized nvidia-drm 0.0.0 20130102 for 0000:08:00=
.0 on m
> inor 1
> [   17.524761] NVRM: loading NVIDIA UNIX x86_64 Kernel Module 319.60 Wed =
Sep 2
> 5 14:28:26 PDT 2013
> [   18.039114] EXT4-fs (sda2): re-mounted. Opts: errors=3Dremount-ro
> [   18.121217] init: udev-fallback-graphics main process (859) terminated=
 with s
> tatus 1
> [   18.215154] input: ImPS/2 Logitech Wheel Mouse as /devices/platform/i8=
042/ser
> io1/input/input8
> [   18.314122] Bluetooth: Core ver 2.16
> [   18.314138] NET: Registered protocol family 31
> [   18.314139] Bluetooth: HCI device and connection manager initialized
> [   18.314146] Bluetooth: HCI socket layer initialized
> [   18.314148] Bluetooth: L2CAP socket layer initialized
> [   18.314153] Bluetooth: SCO socket layer initialized
> [   18.317985] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   18.317988] Bluetooth: BNEP filters: protocol multicast
> [   18.317995] Bluetooth: BNEP socket layer initialized
> [   18.318358] Bluetooth: RFCOMM TTY layer initialized
> [   18.318364] Bluetooth: RFCOMM socket layer initialized
> [   18.318366] Bluetooth: RFCOMM ver 1.11
> [   19.574715] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Contr=
ol: RX/
> TX
> [   19.574974] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [   19.998059] init: failsafe main process (930) killed by TERM signal
> [   20.527982] init: gdm main process (1326) killed by TERM signal
> [   21.483140] Ebtables v2.0 registered
> [   21.525608] ip_tables: (C) 2000-2006 Netfilter Core Team
> [   21.540172] ip6_tables: (C) 2000-2006 Netfilter Core Team
> [   23.457040] Bridge firewalling registered
> [   23.562883] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
> [   23.624471] IPv6: ADDRCONF(NETDEV_UP): virbr0: link is not ready
> [   32.779677] init: plymouth-stop pre-start process (2390) terminated wi=
th stat
> us 1
>
>
>    lsmod output
> Module                  Size  Used by
> cuse                   13274  3
> ipt_MASQUERADE         12880  3
> iptable_nat            13011  1 nf_nat_ipv4            13263  1 iptable_n=
at
> nf_nat                 26711  3 ipt_MASQUERADE,nf_nat_ipv4,iptable_nat
> nf_conntrack_ipv4      15012  2
> nf_defrag_ipv4         12729  1 nf_conntrack_ipv4
> xt_conntrack           12760  1
> nf_conntrack           91940  6 ipt_MASQUERADE,nf_nat,nf_nat_ipv4,xt_conn=
track,i
> ptable_nat,nf_conntrack_ipv4
> ipt_REJECT             12541  2
> xt_CHECKSUM            12549  1
> iptable_mangle         12695  1
> xt_tcpudp              12884  5
> bridge                110679  0
> stp                    12976  1 bridge
> llc                    14552  2 stp,bridge
> ip6table_filter        12815  0
> ip6_tables             27025  1 ip6table_filter
> iptable_filter         12810  1
> ip_tables              27239  3 iptable_filter,iptable_mangle,iptable_nat
> ebtable_nat            12807  0
> ebtables               30913  1 ebtable_nat
> x_tables               34059  11 ip6table_filter,xt_CHECKSUM,ip_tables,xt=
_tcpudp
> ,ipt_MASQUERADE,xt_conntrack,iptable_filter,ebtables,ipt_REJECT,iptable_m=
angle,i
> p6_tables
> rfcomm                 69130  4
> bnep                   19704  2
> bluetooth             372041  10 bnep,rfcomm
> binfmt_misc            17468  1
> dm_crypt               22832  0
> snd_hda_codec_hdmi     41117  1
> intel_powerclamp       14705  0
> kvm_intel             138567  0
> kvm                   431720  1 kvm_intel
> joydev                 17377  0
> w83795                 52109  0
> coretemp               13435  0
> nvidia               9451843  29
> gpio_ich               13476  0
> snd_hda_intel          48171  2
> snd_hda_codec         188738  2 snd_hda_codec_hdmi,snd_hda_intel
> snd_hwdep              13602  1 snd_hda_codec
> snd_pcm               102033  3 snd_hda_codec_hdmi,snd_hda_codec,snd_hda_=
intel
> ioatdma                67698  24
> snd_page_alloc         18710  2 snd_pcm,snd_hda_intel
> microcode              23576  0
> dm_multipath           22873  0
> scsi_dh                14882  1 dm_multipath
> snd_seq_midi           13324  0
> snd_seq_midi_event     14899  1 snd_seq_midi
> psmouse                97655  0
> serio_raw              13413  0
> snd_rawmidi            30095  1 snd_seq_midi
> snd_seq                61560  2 snd_seq_midi_event,snd_seq_midi
> snd_seq_device         14497  3 snd_seq,snd_rawmidi,snd_seq_midi
> lpc_ich                21080  0
> snd_timer              29433  2 snd_pcm,snd_seq
> snd                    69141  14 snd_hwdep,snd_timer,snd_hda_codec_hdmi,s=
nd_pcm,
> snd_seq,snd_rawmidi,snd_hda_codec,snd_hda_intel,snd_seq_device,snd_seq_mi=
di
> i7core_edac            24122  0
> shpchp                 37032  0
> edac_core              62342  2 i7core_edac
> soundcore              12680  1 snd
> mac_hid                13205  0 i2c_i801               22444  0
> lp                     17759  0
> parport                42299  1 lp
> pata_acpi              13038  0
> hid_generic            12548  0
> radeon               1402995  0
> usbhid                 53014  0
> hid                   105858  2 hid_generic,usbhid
> ttm                    84169  1 radeon
> drm_kms_helper         52710  1 radeon
> igb                   179135  0
> drm                   297056  5 ttm,drm_kms_helper,nvidia,radeon
> dca                    15130  2 igb,ioatdma
> pata_jmicron           12758  0
> ptp                    18580  1 igb
> pps_core               19057  1 ptp
> i2c_algo_bit           13413  2 igb,radeon
> floppy                 69370  0
>
>
>
> now  output of sensors-detect
>
> # sensors-detect revision 6085 (2012-10-30 18:18:45 +0100)
> # System: Supermicro X8DTN [1234567890]
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> Some south bridges, CPUs or memory controllers contain embedded sensors.
> Do you want to scan for them? This is totally safe. (YES/no): Module cpui=
d loade
> d successfully.
> Silicon Integrated Systems SIS5595...                       No
> VIA VT82C686 Integrated Sensors...                          No
> VIA VT8231 Integrated Sensors...                            No
> AMD K8 thermal sensors...                                   No
> AMD Family 10h thermal sensors...                           No
> AMD Family 11h thermal sensors...                           No
> AMD Family 12h and 14h thermal sensors...                   No
> AMD Family 15h thermal sensors...                           No
> AMD Family 15h power sensors...                             No
> Intel digital thermal sensor...                             Success!
>      (driver `coretemp')
> Intel AMB FB-DIMM thermal sensor...                         No
> VIA C7 thermal sensor...                                    No
> VIA Nano thermal sensor...                                  No
>
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): Probing for Super-I/=
O at 0x
> 2e/0x2f
> Trying family `National Semiconductor/ITE'...               No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
> Found `Winbond W83627HF/F/HG/G Super IO Sensors'            Success!
>      (address 0xa00, driver `w83627hf')
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor/ITE'...               No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> Trying family `ITE'...                                      NoSome system=
s (mainly servers) implement IPMI, a set of common interfaces
> through which system health data may be retrieved, amongst other things.
> We first try to get the information from SMBIOS. If we don't find it
> there, we have to read from arbitrary I/O ports to probe for such
> interfaces. This is normally safe. Do you want to scan for IPMI
> interfaces? (YES/no): Found `IPMI BMC Unknown' at 0xca2...
>    Success!
>      (confidence 8, driver `to-be-written')
>
> Some hardware monitoring chips are accessible through the ISA I/O ports.
> We have to write to arbitrary I/O ports to probe them. This is usually
> safe though. Yes, you do have ISA I/O ports even if you do not have any
> ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): Probing for `=
Nationa
> l Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
>
> Lastly, we can probe the I2C/SMBus adapters for connected hardware
> monitoring devices. This is the most risky part, and while it works
> reasonably well on most systems, it has been reported to cause trouble
> on some systems.
> Do you want to probe the I2C/SMBus adapters now? (YES/no): Using driver `=
i2c-i80
> 1' for device 0000:00:1f.3: Intel ICH10
> Module i2c-dev loaded successfully.
>
> Next adapter: SMBus I801 adapter at 0400 (i2c-0)
> Do you want to scan it? (YES/no/selectively):
>
> Sometimes hangs here.  Right after boot it continues.
>
> Client found at address 0x2e
> Probing for `Myson MTP008'...                               No
> Probing for `National Semiconductor LM78'...                No
> Probing for `National Semiconductor LM79'...                No
> Probing for `National Semiconductor LM80'... sensors-detect seem
> ed to hang here
>
>
> Now, after reboot the output is
> ANext adapter: SMBus I801 adapter at 0400 (i2c-0)
> Do you want to scan it? (YES/no/selectively): y
> Client found at address 0x2e
> Probing for `Myson MTP008'...                               No
> Probing for `National Semiconductor LM78'...                No
> Probing for `National Semiconductor LM79'...                No
> Probing for `National Semiconductor LM80'...                No
> Probing for `National Semiconductor LM96080'...             No
> Probing for `National Semiconductor LM85'...                No
> Probing for `National Semiconductor LM96000 or PC8374L'...  No
> Probing for `Analog Devices ADM1027'...                     No
> Probing for `Analog Devices ADT7460 or ADT7463'...          No
> Probing for `SMSC EMC6D100 or EMC6D101'...                  No
> Probing for `SMSC EMC6D102'...                              No
> Probing for `SMSC EMC6D103'...                              No
> Probing for `SMSC EMC6D103S or EMC2300'...                  No
> Probing for `SMSC EMC6W201'...                              No
> Probing for `Winbond WPCD377I'...                           No
> Probing for `Analog Devices ADT7467 or ADT7468'...          No
> Probing for `Analog Devices ADT7470'...                     No
> Probing for `Analog Devices ADT7473'...                     No
> Probing for `Analog Devices ADT7475'...                     No
> Probing for `Analog Devices ADT7476'...                     No
> Probing for `Analog Devices ADT7490'...                     No
> Probing for `Andigilog aSC7611'...                          No
> Probing for `Andigilog aSC7621'...                          No
> Probing for `National Semiconductor LM87'...                No
> Probing for `Analog Devices ADM1024'...                     No
> Probing for `National Semiconductor LM93'...                No
> Probing for `National Semiconductor LM94 or LM96194'...     No
> Probing for `Winbond W83781D'...                            No
> Probing for `Winbond W83782D'...                            No
> Probing for `Winbond W83791D'...                            No
> Probing for `Winbond W83792D'...                            No
> Probing for `Winbond W83793R/G'...                          No
> Probing for `Nuvoton W83795G/ADG'...                        No
> Probing for `Winbond W83627HF'...                           No
> Probing for `Winbond W83627EHF'...                          No
> Probing for `Winbond W83627DHG/W83667HG/W83677HG'...        No
> Probing for `Asus AS99127F (rev.1)'...                      No
> Probing for `Asus AS99127F (rev.2)'...                      No
> Probing for `Asus ASB100 Bach'...                           No
> Probing for `Winbond W83L786NR/NG/R/G'...                   No
> Probing for `Winbond W83L785TS-S'...                        No
> Probing for `Analog Devices ADM9240'...                     No
> Probing for `Dallas Semiconductor DS1780'...                No
> Probing for `National Semiconductor LM81'...                No
> Probing for `Analog Devices ADM1026'...                     No
> Probing for `Analog Devices ADM1025'...                     No
> Probing for `Maxim MAX6639'...                              No
> Probing for `Texas Instruments AMC6821'...                  No
> Probing for `Analog Devices ADM1029'...                     No
> Probing for `Analog Devices ADM1030'...                     No
> Probing for `Analog Devices ADM1031'...                     No
> Probing for `Analog Devices ADM1022'...                     No
> Probing for `Texas Instruments THMC50'...                   No
> Probing for `Analog Devices ADM1028'...                     No
> Probing for `Texas Instruments THMC51'...                   No
> Probing for `ITE IT8712F'...                                No
> Probing for `SMSC DME1737'...                               No
> Probing for `SMSC SCH5027D-NW'...                           No
> Probing for `SMSC EMC2103'...                               No
> Probing for `Fintek F75373S/SG'...                          No
> Probing for `Fintek F75375S/SP'...                          No
> Probing for `Fintek F75387SG/RG'...                         No
> Probing for `Winbond W83791SD'...                           No
> Client found at address 0x2f
> Handled by driver `w83795' (already loaded), chip type `w83795adg'
>
> Next adapter: NVIDIA i2c adapter 0 at 8:00.0 (i2c-1)
> Do you want to scan it? (yes/NO/selectively): y
> Client found at address 0x58
> Probing for `Analog Devices ADT7462'...                     No
> Probing for `Andigilog aSC7512'...                          No
>
> Next adapter: NVIDIA i2c adapter 2 at 8:00.0 (i2c-2)
> Do you want to scan it? (yes/NO/selectively): n
>
> Next adapter: NVIDIA i2c adapter 6 at 8:00.0 (i2c-3)
> Do you want to scan it? (yes/NO/selectively): n
>
> Next adapter: NVIDIA i2c adapter 7 at 8:00.0 (i2c-4)
> Do you want to scan it? (yes/NO/selectively): n
>
> Next adapter: NVIDIA i2c adapter 8 at 8:00.0 (i2c-5)
> Do you want to scan it? (yes/NO/selectively): n
>
> Next adapter: NVIDIA i2c adapter 11 at 8:00.0 (i2c-6)
> Do you want to scan it? (yes/NO/selectively): n
>
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>
> Driver `to-be-written':
>    * ISA bus, address 0xca2
>      Chip `IPMI BMC Unknown' (confidence: 8)
>
> Driver `coretemp':
>    * Chip `Intel digital thermal sensor' (confidence: 9)
>
> Driver `w83627hf':
>    * ISA bus, address 0xa00
>      Chip `Winbond W83627HF/F/HG/G Super IO Sensors' (confidence: 9)
>
> Driver `w83795':
>    * Bus `SMBus I801 adapter at 0400'
>      Busdriver `i2c_i801', I2C address 0x2f
>      Chip `w83795adg' (confidence: 6)
>
> Note: there is no driver for IPMI BMC Unknown yet.
> Check http://www.lm-sensors.org/wiki/Devices for updates.
>
> To load everything that is needed, add this to /etc/modules:
> #----cut here----
> # Chip drivers
> coretemp
> w83627hf
> w83795
> #----cut here----
> If you have some drivers built into your kernel, the list above will
> contain too many modules. Skip the appropriate ones!
>
> Do you want to add these lines automatically to /etc/modules? (yes/NO)no
>
> Unloading i2c-dev... OK
> Unloading cpuid... OK
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> Currently /etc/modules does not contain the w83627hf,
> it did before and the sensors command hung in AFAICT the same way.
>
>
> Here is output of sensors right after a reboot.
>
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:       +25.0=B0C  (high =3D +80.0=B0C, crit =3D +96.0=B0C)
> Core 1:       +19.0=B0C  (high =3D +80.0=B0C, crit =3D +96.0=B0C)
> Core 2:       +25.0=B0C  (high =3D +80.0=B0C, crit =3D +96.0=B0C)
> Core 8:       +21.0=B0C  (high =3D +80.0=B0C, crit =3D +96.0=B0C)
> Core 9:       +27.0=B0C  (high =3D +80.0=B0C, crit =3D +96.0=B0C)
> Core 10:      +26.0=B0C  (high =3D +80.0=B0C, crit =3D +96.0=B0C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 0:       +28.0=B0C  (high =3D +80.0=B0C, crit =3D +96.0=B0C)
> Core 1:       +21.0=B0C  (high =3D +80.0=B0C, crit =3D +96.0=B0C)
> Core 2:       +26.0=B0C  (high =3D +80.0=B0C, crit =3D +96.0=B0C)
> Core 8:       +22.0=B0C  (high =3D +80.0=B0C, crit =3D +96.0=B0C)
> Core 9:       +22.0=B0C  (high =3D +80.0=B0C, crit =3D +96.0=B0C)
> Core 10:      +20.0=B0C  (high =3D +80.0=B0C, crit =3D +96.0=B0C)
>
> w83795adg-i2c-0-2f
> Adapter: SMBus I801 adapter at 0400
> VCPU2:        +0.89 V  (min =3D  +0.60 V, max =3D  +1.49 V)
> VCPU1:        +0.90 V  (min =3D  +0.60 V, max =3D  +1.49 V)
> DIMM:         +1.52 V  (min =3D  +1.35 V, max =3D  +1.65 V)
> +5V:          +4.98 V  (min =3D  +4.51 V, max =3D  +5.53 V)
> +12V:        +12.02 V  (min =3D +10.80 V, max =3D +13.23 V)
> +5VSB:        +5.09 V  (min =3D  +4.51 V, max =3D  +5.53 V)
> VCPU2DIMM:    +1.54 V  (min =3D  +1.20 V, max =3D  +1.65 V)
> VCPU1DIMM:    +1.54 V  (min =3D  +1.20 V, max =3D  +1.65 V)
> in11:         +1.13 V  (min =3D  +0.00 V, max =3D  +2.05 V)
> +3.3V:        +3.26 V  (min =3D  +2.96 V, max =3D  +3.63 V)
> +3.3Vsb:      +3.26 V  (min =3D  +2.96 V, max =3D  +3.63 V)
> Vbatt:        +3.21 V  (min =3D  +2.70 V, max =3D  +3.63 V)
> CPU1:        1945 RPM  (min =3D  709 RPM)
> CPU2:        1105 RPM  (min =3D  709 RPM)
> CPU3:        4218 RPM  (min =3D  709 RPM)
> CPU4:         723 RPM  (min =3D  709 RPM)
> CPU5:         792 RPM  (min =3D  709 RPM)
> Fan6:        1356 RPM  (min =3D  709 RPM)
> Fan8:        1962 RPM  (min =3D  709 RPM)
> Northbridge:  +58.5=B0C  (high =3D +85.0=B0C, hyst =3D +80.0=B0C)
>                         (crit =3D +100.0=B0C, hyst =3D +95.0=B0C)  sensor=
 =3D thermal diode
> System temp:  +36.2=B0C  (high =3D +85.0=B0C, hyst =3D +80.0=B0C)
>                         (crit =3D +75.0=B0C, hyst =3D +70.0=B0C)  sensor =
=3D thermistor
> CPU1 temp:    +30.2=B0C  (high =3D +95.0=B0C, hyst =3D +92.0=B0C)
>                         (crit =3D +95.0=B0C, hyst =3D +92.0=B0C)  sensor =
=3D Intel PECI
> CPU2 temp:    +31.5=B0C  (high =3D +95.0=B0C, hyst =3D +92.0=B0C)
>                         (crit =3D +95.0=B0C, hyst =3D +92.0=B0C)  sensor =
=3D Intel PECI
> intrusion0:  ALARM
>
> --------------------end
>
>
> ipmi_msghandler        45306  0
>
>
> [   17.226996] microcode: CPU6 sig=3D0x206c2, pf=3D0x1, revision=3D0x13
>
>
> [    1.964907] hid-generic 0003:046D:C31C.0001: input,hidraw0: USB HID v1=
.10 Key
> board [Logitech USB Keyboard] on usb-0000:00:1d.0-1/input0
> [    1.978353] input: Logitech USB Keyboard as /devices/pci0000:00/0000:0=
0:1d.0/
> usb6/6-1/6-1:1.1/input/input3
>
>
> [    0.988106] i8042: PNP: PS/2 controller doesn't have KBD irq; using de=
fault 1
> [    0.990385] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    0.990390] serio: i8042 AUX port at 0x60,0x64 irq 12
>
> [    0.986960] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
>
>
> [    0.909975] pcieport 0000:00:07.0: irq 115 for MSI/MSI-X
>
>
>
>
>
> [    0.488882] pci 0000:0a:00.1: [8086:10c9] type 00 class 0x020000
> [    0.488893] pci 0000:0a:00.1: reg 0x10: [mem 0xfbee0000-0xfbefffff]
> [    0.488901] pci 0000:0a:00.1: reg 0x14: [mem 0xfbec0000-0xfbedffff]
> [    0.488909] pci 0000:0a:00.1: reg 0x18: [io  0xec00-0xec1f]
> [    0.488917] pci 0000:0a:00.1: reg 0x1c: [mem 0xfbe9c000-0xfbe9ffff]
>
>
>
>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
