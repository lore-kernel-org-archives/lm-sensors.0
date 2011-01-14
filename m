From: Jeff Rickman <jrickman@myamigos.us>
Date: Fri, 14 Jan 2011 03:08:33 +0000
Subject: Re: [lm-sensors] Accuracy of "via_cputemp" Module in LM_Sensors
Message-Id: <4D2FBE31.4050201@myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D2C1931.5000301@myamigos.us>
In-Reply-To: <4D2C1931.5000301@myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

On 1/13/2011 10:43 AM, Jean Delvare wrote:
> Hi Jeff,
>
> On Tue, 11 Jan 2011 02:47:45 -0600, Jeff Rickman wrote:
>> I am trying to track down a temperature discrepancy on a Jetway
>> J7F4K1G5D "Versa" motherboard. This board has a VIA C-7 D cpu (25W
>> version). The operating system is Fedora Core 14 i386, kernel
>> 2.6.35.10-74.fc14.i686.PAE. I am running this version of "sensors":
>> sensors version 3.2.0 with libsensors version 3.2.0
>>
>> LM_Sensors loads the following modules:
>> acpitz-virtual-0
>> f71805f-isa-0290 (using acpi_enforce_resources=3Dlax)
>> via_cputemp-isa-0000
>>
>> I understand the risk of using "lax", but there is no ACPI version of
>> the "f71805f" module and Jetway ACPI grabs 0x295-0x296 from the IO range
>> 0x290-0x297.
>
> Yes, I have the same problem on my Jetway K8M8MS, also with a Fintek
> F71805FG. ACPI uses the I/O ports to expose one temperature through the
> thermal zone interface. On my system, the ACPI code is broken and reads
> the wrong register, so the thermal zone interface is useless. At least
> on your system, the reported value matches what the hardware monitoring
> device returns when accessed directly.
>
>> Back to my question....
>>
>> When I boot this machine I can read the System and CPU temperatures from
>> the boot screen. I can also go into the BIOS and read the same values in
>> the "PC Health" screen as seen on the boot screen. The boot values
>> typically show as 12C-16C for CPU temp and 27C-30C for System temp.
>> Others have posted comments elsewhere saying this VIA CPU does not run
>> warm, especially when idle, but that temperature range is approximately
>> the ambient range for the room where that machine is located. I thought
>> pushing electrons through silicon generated some heat?
>>
>> Once FC14 is booted, I can run the "sensors" command and see the
>> following values:
>>
>> [root@XX ~]# sensors
>> acpitz-virtual-0
>> Adapter: Virtual device
>> temp1:       +11.0=B0C  (crit =3D +60.0=B0C)
>>
>> f71805f-isa-0290
>> Adapter: ISA adapter
>> [...voltages and fan info removed...]
>> System Temp: +11.0=B0C  (high =3D +60.0=B0C, hyst =3D +49.0=B0C)  sensor=
 =3D thermal
>> diode
>> CPU Temp:    +27.0=B0C  (high =3D +60.0=B0C, hyst =3D  +0.0=B0C)  sensor=
 =3D thermal
>> diode
>
>
> Note: acpitz and f71805f apparently read the temperature value from the
> same F71805FG device. Access isn't synchronized, so this is dangerous.
> If you boot with acpi_enforce_resources=3Dlax, you should NOT use the
> ACPI "thermal" driver.

How would I disable the ACPI "thermal" driver? I did not see it listed=20
in my "lsmod" output.

>> via_cputemp-isa-0000
>> Adapter: ISA adapter
>> Core 0:      +27.0=B0C
>>
>> I modified my "/etc/sensors.d/local.conf" file to match the outputs
>> shown in "f71805f-isa-0290" to those seen in "via_cputemp-isa-0000" and
>> "acpitz-virtual-0" since there are no corresponding values in my
>> "/etc/sensors3.conf". In this case "temp1" is mapped to "System Temp"
>> and "temp2" is mapped to "CPU Temp" in my "local.conf" file.
>>
>> After studying the code posted on "lm-sensors.org" for the standalone
>> "via_cputemp" module, I think the "via_cputemp" module pulls it's
>> temperature value from a MSR. I did not have the source code handy for
>> my distribution when I did this research, but does one expect
>> differences on what value is being accessed (doubt it)? Perhaps the
>> value being accessed is achieved through a different mechanism? If it
>> matters I will do the research in the FC14 source code.
>
> I don't quite understand your question, sorry. The via-cputemp indeed
> gets its temperature value from an MSR, much like the coretemp driver.
> This is a direct digital temperature reading. The f71805 driver, OTOH,
> relies on external thermal sensors connected to its pins, and converts
> the analog signal to a digital reading.

Jean, your comments here are very helpful. It confirms my thoughts on=20
trusting the "via_cputemp" output for CPU temperature. The labels=20
displayed in "sensors" for the f71805 driver are easily manipulated=20
using a "/etc/sensors.d/local.conf" file in Fedora Core.

>> Every time I run "sensors", the value shown in "via_cputemp" is within
>> +-2C or less of the "CPU Temp" value reported by "f71805f". The same
>> (+-2C or less) can be said for the "acpitz" value and the "System Temp"
>> value from "f71805f". Numbers that are that close on a consistent basis
>> are a coincidence that is too good to be true, which is why I suspect
>> Jetway has what could be a simple "label swap error" in their BIOS.
>
> Yes, I agree with your analysis. And they probably also have a bug in
> their ACPI thermal zone implementation: it should really report the CPU
> temperature and not the system temperature. Well, reporting the system
> temperature isn't bad per se, but it's certainly less useful than
> reporting the CPU temperature, if they decided to return a single value.

I am waiting to hear back from Jetway support. They suggested a BIOS=20
update should fix it, but it did not. Their tech support request form=20
has all the information they need to reproduce the problem that I see.

>> If the MSR value read by "via_cputemp" is correct, and I think it is,
>> then I think Jetway has their BIOS labels (what they display on screen)
>> switched for "CPU temp" and "System Temp". I have posted a message to
>> Jetway tech support asking them about this matter. Hopefully they will
>> respond in a timely manner.
>>
>> Does my logic and understanding of the "via_cputemp" code make sense, or
>> have I gotten myself turned around the wrong way on this issue?
>
> HTH,

Your comments do help.

Can you share a method to disable the ACPI "thermal" driver that does=20
not involve altering source code? A configuration option somewhere? I am=20
willing to test on Fedora Core 14 i386 & x86_64 and report back. I have=20
numerous motherboards with Intel Atom and various AMD CPUs that I can=20
use for testing and comparing results. If the disabling method works,=20
can we post the method to the wiki for all to reference?

Jeff

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
