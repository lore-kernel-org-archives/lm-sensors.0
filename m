From: no tellin <no.tellin@gmail.com>
Date: Mon, 22 Nov 2010 17:06:26 +0000
Subject: Re: [lm-sensors] lm-sensors config file for Asus K8N-DL motherboard
Message-Id: <AANLkTinGgJBKCF=JKbPpcepCkoRszmscQgerT2fsdFeX@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTinYEMqSH_PMmVOqV4bn1a9qFoagtVo4AHpG=57H@mail.gmail.com>
In-Reply-To: <AANLkTinYEMqSH_PMmVOqV4bn1a9qFoagtVo4AHpG=57H@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, Nov 21, 2010 at 5:03 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
>
> On 11/20/2010 09:41 PM, no tellin wrote:
>>
>> /etc/sensors.d/asus_k8n-dl.conf
>
> Hmm, most asus board now a days do not allow direct access to their
> hwmon ic's (the resources for the i2c controller/ =A0the superio ports
> are marked as reserved in acpi).
>
> Did you try this with a recent kernel ? Normally the kernel should
> disallow access to the relevant hwmon ic's and the asus_atk0110 driver
> which gives access to hwmon info through an asus specific acpi
> interface should autoload.
>
> <snip>
>
>> # Warning: 'sensors-detect' will report the wrong Winbond I2C chip.
>> Board inspection
>> # and the official manual both indicate 'w83792d'.
>
> Hmm, was this with a recent sensors-detect? If so that seems like
> a bug in sensors-detect to me, can you please start a separate
> thread about this?
>
> Regards,
>
> Hans
>
>

Kernel:

# uname -a
Linux slizard 2.6.35.4 #1 SMP Sat Aug 28 00:05:36 EDT 2010 x86_64 AMD
Opteron(tm) Processor 242 AuthenticAMD GNU/Linux


Sensors detect:

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `w83627hf':
  * ISA bus, address 0x290
    Chip `Winbond W83627THF/THG Super IO Sensors' (confidence: 9)


lm_senors version:

# emerge -s lm_sensors
Searching...
[ Results for search key : lm_sensors ]
[ Applications found : 1 ]

*  sys-apps/lm_sensors
      Latest version available: 3.2.0
      Latest version installed: 3.1.2-r1
      Size of files: 161 kB
      Homepage:      http://www.lm-sensors.org/
      Description:   Hardware Monitoring user-space utilities
      License:       GPL-2 LGPL-2.1


FWIW, I don't believe the K8N-DL includes support for asus_atk0110.
The board dates back to 2005 and was never continued in later
revisions. The board uses the nVidia CK804 chipset. Since nVidia is no
longer in the motherboard chipset business, this board has been EOLed
for awhile. i.e. -- There has only been the single version.

This is the output from lspci:

00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev =
a3)
00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97
Audio Controller (rev a2)
00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev =
f3)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev =
f3)
00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
01:09.0 RAID bus controller: Silicon Image, Inc. SiI 3114
[SATALink/SATARaid] Serial ATA Controller (rev 02)
02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751
Gigabit Ethernet PCI Express (rev 11)
04:00.0 VGA compatible controller: ATI Technologies Inc R430 [Radeon
X800 (PCIE)]
04:00.1 Display controller: ATI Technologies Inc R430 [Radeon X800]
(PCIE) (Secondary)

Hope this helps.

Guy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
