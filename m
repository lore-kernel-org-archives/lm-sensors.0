From: "Juerg Haefliger" <juergh@gmail.com>
Date: Tue, 29 Jan 2008 19:39:03 +0000
Subject: Re: [lm-sensors] Help with readings (k8temp - dme1737)
Message-Id: <191fb4ca0801291139x83b3043k9071ae44e245ed@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <479F751E.6080707@gmail.com>
In-Reply-To: <479F751E.6080707@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Lee,


On Jan 29, 2008 10:49 AM, Lee Harris <lee.r.harris@googlemail.com> wrote:
> Hi
>
> I have installed lm-sensors on a remote server as it has been crashing
> every few days and the logs show no obvious OS / software issues.
>
> I have got lm-sensors working I think ( after updating my kernel)
>
> My questions are:
> What is RD1 temp ?

Remote diode 1. Might be ambient.


> Which is the true cpu temp ? Core1 from K8temp or CPU temp from dme1737.

What's the meaning of life? Who knows? No seriously, I can't speak for
the k8temp but certain CPU types are broken and return bogus temp
values. You might want to send the output of 'cat /proc/cpuinfo' to
the list and have Rudolf M. take a look at it.

For the dme1737 temps, either RD1 or RD2 can be the CPU temp, that
depends on the board layout. It just happens that the current
sensors.conf file labels RD2 as the CPU temp. But given the fact that
RD2 (CPU) temp rises when you exercise the CPU and that it's the
higher of the two is a strong indication that it is indeed the CPU
temp. As for the accuracy of the reading, that depends on 2 factors
which are controlled by the board manufacturer and BIOS
implementation:
1) The conncted diode has to be of type 3904. If not, the reading will be b=
ogus.
2) The temp offset needs to be initialized properly by the BIOS. If
not, the reading will be off.

Check out the following link for guidlines on how to
calibrate/validate your CPU temp readings:
http://www.silentpcreview.com/article191-page1.html


> I ran a kernel compiling loop to 'burn' the cpu a little and both rose
> about 8=B0C.
> But is either a true figure ? Why the 20=B0 difference ?
>
> Sorry I can't give exact info on motherboard model as I have no physical
> access to the server. I will include some lspci output below.
> (I have set some sensors to Ignore in sensors.conf as they showed 0)

Can you send the output of dmidecode to the list?


> Thanks for the software.
> Lee
>
> ~# sensors
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core1 Temp:
>              +42=B0C

That's a little bit low for a CPU. What model/speed is it?


> dme1737-i2c-0-2e
> Adapter: SMBus nForce2 adapter at 88c0
> V3.3:      +3.35 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> V3.3stby:  +3.31 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Vbat:      +3.01 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> RD1 Temp:    +40=B0C  (low  =3D  -127=B0C, high =3D   +61=B0C)
> Int Temp:    +44=B0C  (low  =3D  -127=B0C, high =3D   +91=B0C)
> CPU Temp:    +60=B0C  (low  =3D  -127=B0C, high =3D   +86=B0C)

60C looks like a real CPU temp to me.

...juerg


> CPU_Fan:  1680 RPM  (min =3D    0 RPM)
> Fan3:     8557 RPM  (min =3D    0 RPM)
> ERROR: Can't get fan5 data!
> ERROR: Can't get fan6 data!
> CPU_PWM:    67      (enable =3D 2, freq =3D  25000 Hz)
> Fan3_PWM:   67      (enable =3D 2, freq =3D  25000 Hz)
> ERROR: Can't get pwm5 data!
> ERROR: Can't get pwm6 data!
> cpu0_vid: +1.350 V  (VRM Version 2.4)
>
> --------------------------------------------
>
> 00:00.0 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
> 00:00.1 RAM memory: nVidia Corporation C51 Memory Controller 0 (rev a2)
> 00:00.2 RAM memory: nVidia Corporation C51 Memory Controller 1 (rev a2)
> 00:00.3 RAM memory: nVidia Corporation C51 Memory Controller 5 (rev a2)
> 00:00.4 RAM memory: nVidia Corporation C51 Memory Controller 4 (rev a2)
> 00:00.5 RAM memory: nVidia Corporation C51 Host Bridge (rev a2)
> 00:00.6 RAM memory: nVidia Corporation C51 Memory Controller 3 (rev a2)
> 00:00.7 RAM memory: nVidia Corporation C51 Memory Controller 2 (rev a2)
> 00:02.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
> 00:03.0 PCI bridge: nVidia Corporation C51 PCI Express Bridge (rev a1)
> 00:05.0 VGA compatible controller: nVidia Corporation C51 [GeForce 6150
> LE] (rev a2)
> 00:09.0 RAM memory: nVidia Corporation MCP51 Host Bridge (rev a2)
> 00:0a.0 ISA bridge: nVidia Corporation MCP51 LPC Bridge (rev a3)
> 00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a3)
> 00:0b.0 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3)
> 00:0b.1 USB Controller: nVidia Corporation MCP51 USB Controller (rev a3)
> 00:0d.0 IDE interface: nVidia Corporation MCP51 IDE (rev f1)
> 00:0e.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller
> (rev f1)
> 00:10.0 PCI bridge: nVidia Corporation MCP51 PCI Bridge (rev a2)
> 00:14.0 Ethernet controller: nVidia Corporation MCP51 Ethernet
> Controller (rev a3)
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> HyperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> DRAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Miscellaneous Control
>
> ------------------------------------------------
>
> 00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a3)
>         Subsystem: Fujitsu Siemens Computer GmbH Unknown device 10c6
>         Flags: 66MHz, fast devsel, IRQ 10
>         I/O ports at 88c0 [sized]
>         I/O ports at 8880 [sized]
>         Capabilities: [44] Power Management version 2
>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
