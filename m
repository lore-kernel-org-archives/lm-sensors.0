From: no tellin <no.tellin@gmail.com>
Date: Tue, 23 Nov 2010 00:17:27 +0000
Subject: Re: [lm-sensors] lm-sensors config file for Asus K8N-DL motherboard
Message-Id: <AANLkTin6LM=4op8VjG1u6rpX4HxWX+J3qejEP80U3xkc@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTinYEMqSH_PMmVOqV4bn1a9qFoagtVo4AHpG=57H@mail.gmail.com>
In-Reply-To: <AANLkTinYEMqSH_PMmVOqV4bn1a9qFoagtVo4AHpG=57H@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 22, 2010 at 2:26 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> Hmm, it finds an isa winbond chip, but you're using a winbond chip
> through i2c. Did it ask if you also wanted to probe i2c ? Can you
> please re-run sensors-detect and let it probe i2c busses too ?
>

I probably should have included a little more of the sensors-detect
script/output:

# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
# System: System manufacturer System Product Name
# Board: ASUSTek Computer INC. K8N-DL

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   Success!
    (driver `k8temp')
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel Atom thermal sensor...                                No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found `Winbond W83627THF/THG Super IO Sensors'              Success!
    (address 0x290, driver `w83627hf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No


{interjection}
I don't usually let it probe the 'isa' bus and I hadn't in this case.  I had two
reasons for not probing the 'isa' bus. 1) All the official Asus material
references the 'Super IO' bus. 2) The default in the sensors-detect script
for probing 'isa' is 'no'. Generally speaking, I get good results with the
default.

In the interest of testing _just_ for you, I overrode the default 'no'
with 'YES'
and got these results:
{/interjection}

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): YES
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-nforce2' for device 0000:00:01.1: nVidia Corporation
nForce4 SMBus (MCP)
FATAL: Error inserting i2c_dev
(/lib/modules/2.6.35.4/kernel/drivers/i2c/i2c-dev.ko): Invalid module
format
Failed to load module i2c-dev.

Next adapter: SMBus nForce2 adapter at 1d00 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Can't open /dev/i2c-0
Next adapter: SMBus nForce2 adapter at 1e00 (i2c-1)
Do you want to scan it? (YES/no/selectively):
Can't open /dev/i2c-1
Now follows a summary of the probes I have just done.
Just press ENTER to continue:

{end of sensors-detect}

I'm not certain what happened after the probe of the 'isa' bus. The
noted modules
were already loaded{

# lsmod
Module                  Size  Used by
w83792d                21073  0
dm_mod                 58636  0
tg3                   123836  0
libphy                 16018  1 tg3
sata_sil                8044  6
snd_intel8x0           26519  3
k8temp                  3291  0
hwmon                   1417  2 w83792d,k8temp
i2c_nforce2             5328  0
sata_nv                21295  0
snd_ac97_codec        107756  1 snd_intel8x0
ac97_bus                1158  1 snd_ac97_codec

>
> Ah, it could indeed be then that it does not support aus_atk0110.
>

As it happens, I'll be testing 2.6.37_rc2 soon. I'll build the asus_atk0110
module and see if it loads. In the meantime, I'm perfectly happy with the
current arrangement. It exactly matches what's reported in the BIOS.

Best regards,

Guy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
