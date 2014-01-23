From: Ryan <ryan@desfo.org>
Date: Thu, 23 Jan 2014 07:57:37 +0000
Subject: Re: [lm-sensors] sensors
Message-Id: <52E0CB71.9080007@desfo.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.21.0207072332570.12801-100000@ond.vein.hu>
In-Reply-To: <Pine.LNX.4.21.0207072332570.12801-100000@ond.vein.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

hello jean,

I don't see anything unusable when I run lspci.

$ lspci
00:00.0 Host bridge: Intel Corporation Core Processor DRAM Controller
(rev 18)
00:01.0 PCI bridge: Intel Corporation Core Processor PCI Express x16
Root Port (rev 18)
00:02.0 VGA compatible controller: Intel Corporation Core Processor
Integrated Graphics Controller (rev 18)
00:16.0 Communication controller: Intel Corporation 5 Series/3400 Series
Chipset HECI Controller (rev 06)
00:16.3 Serial controller: Intel Corporation 5 Series/3400 Series
Chipset KT Controller (rev 06)
00:19.0 Ethernet controller: Intel Corporation 82577LM Gigabit Network
Connection (rev 06)
00:1a.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 06)
00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset
High Definition Audio (rev 06)
00:1c.0 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
Express Root Port 1 (rev 06)
00:1c.1 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
Express Root Port 2 (rev 06)
00:1c.2 PCI bridge: Intel Corporation 5 Series/3400 Series Chipset PCI
Express Root Port 3 (rev 06)
00:1d.0 USB controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 06)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev a6)
00:1f.0 ISA bridge: Intel Corporation Mobile 5 Series Chipset LPC
Interface Controller (rev 06)
00:1f.2 SATA controller: Intel Corporation 5 Series/3400 Series Chipset
6 port SATA AHCI Controller (rev 06)
00:1f.3 SMBus: Intel Corporation 5 Series/3400 Series Chipset SMBus
Controller (rev 06)
00:1f.6 Signal processing controller: Intel Corporation 5 Series/3400
Series Chipset Thermal Subsystem (rev 06)
01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Park [Mobility Radeon HD 5430/5450/5470]
01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cedar HDMI
Audio [Radeon HD 5400/6300 Series]
03:00.0 Network controller: Intel Corporation Centrino Advanced-N 6200
(rev 35)
3f:00.0 Host bridge: Intel Corporation Core Processor QuickPath
Architecture Generic Non-core Registers (rev 05)
3f:00.1 Host bridge: Intel Corporation Core Processor QuickPath
Architecture System Address Decoder (rev 05)
3f:02.0 Host bridge: Intel Corporation Core Processor QPI Link 0 (rev 05)
3f:02.1 Host bridge: Intel Corporation Core Processor QPI Physical 0
(rev 05)
3f:02.2 Host bridge: Intel Corporation Core Processor Reserved (rev 05)
3f:02.3 Host bridge: Intel Corporation Core Processor Reserved (rev 05)


On 01/23/2014 02:41 AM, Jean Delvare wrote:
> On Wed, 22 Jan 2014 20:59:30 -0800, Guenter Roeck wrote:
>> On 01/22/2014 03:27 PM, Ryan wrote:
>>  > radeon-pci-0100
>>  > Adapter: PCI adapter
>>  > temp1:       -128.0=B0C  (crit =3D +120.0=B0C, hyst =3D +90.0=B0C)
>>
>> This suggests that there is either no temperature sensor attached to
>> the graphics adapter (that is most likely), or that it is broken.
> First time I see this. I'd suggest that Ryan reports this to the radeon
> driver folks. I think all recent Radeon chips are supposed to have at
> least an internal thermal sensor. If I'm wrong then the ones which do
> not shouldn't instantiate a hwmon class device at all.
>
> There's another odd thing about this graphics chipset. From
> lshw_short.txt:
>
> /0/100/1/0                  generic        Illegal Vendor ID
> /0/100/1/0.1                multimedia     Cedar HDMI Audio [Radeon HD 54=
00/6300 Series]
>
> So the main PCI device has a wrong device ID. I'm curious how the
> radeon driver even manages to bind to it then. Does lspci look wrong
> too?
>
> Could be defective hardware...
>
> You may also try removing radeon.dpm=3D1 from your boot command line and
> see if it makes any difference. Which reminds me I should really add it
> back on mine, I forgot to do so last time I reinstalled my system.
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
