From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 27 May 2015 09:16:59 +0000
Subject: Re: [lm-sensors] sensors-detect and my monitor
Message-Id: <20150527111659.1b751c45@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20150516T211122-274@post.gmane.org>
In-Reply-To: <loom.20150516T211122-274@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chris,

Sorry for the later answer.

On Sat, 16 May 2015 19:30:38 +0000 (UTC), Chris Godbout wrote:
> I have a Lenovo g50-80 laptop with Arch linux installed. I went to get
> lm-sensors working since I couldn't get the temperature with acpi -t on this
> laptop. Anyway, I started by doing sensors-detect, which I've done on
> computers in the past.

For the record, sensors-detect is useless on most laptops anyway.

> I know I should have stuck with the defaults, but I
> didn't. Instead, I hit yes for everything which hasn't been a problem before.

There's a reason for these defaults...

> Everything was fine until I probed DPDDC-A (i2c-6). It went through a list
> of sensors and part way through it my screen flickered. Afterwards, my
> monitor got really bright and the colors were all washed out. Unfortunately,
> I'm colorblind and have a hard time describing it more than that.
> Additionally, in large blocks of the same color it's almost as if I can see
> the individual pixels and some of them are actually black. This may be an
> optical illusion, but when I look closely, it's almost as if they're moving.

Do I understand correctly that you are speaking of the internal laptop
display and not an external display?

> The output of my sensors-detect is here:http://pastebin.com/zw1hy66h

Next time please include it in the message. Nothing is more frustrating
when investigating an issue several months later than dead links to
capital information. So I'm copying it below:

# sensors-detect revision 6209 (2014-01-14 22:51:58 +0100)
# System: LENOVO 80E5 [Lenovo G50-80] (laptop)
# Board: LENOVO Lenovo G50-80

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Module cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           No
AMD Family 15h power sensors...                             No
AMD Family 16h power sensors...                             No
Intel digital thermal sensor...                             Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               Yes
Found unknown chip with ID 0x8586

--> Could be an ITE IT8586E... No datasheet.

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Found unknown SMBus adapter 8086:9ca2 at 0000:00:1f.3.
Sorry, no supported PCI bus adapters found.
Module i2c-dev loaded successfully.

Next adapter: i915 gmbus ssc (i2c-0)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus vga (i2c-1)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus panel (i2c-2)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus dpc (i2c-3)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus dpb (i2c-4)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus dpd (i2c-5)
Do you want to scan it? (yes/NO/selectively):

Next adapter: DPDDC-A (i2c-6)
Do you want to scan it? (yes/NO/selectively): yes
Client found at address 0x2c
Probing for `Myson MTP008'...                               No
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `National Semiconductor LM96080'...             No
Probing for `National Semiconductor LM85'...                No
Probing for `National Semiconductor LM96000 or PC8374L'...  No
Probing for `Analog Devices ADM1027'...                     No
Probing for `Analog Devices ADT7460 or ADT7463'...          No
Probing for `SMSC EMC6D100 or EMC6D101'...                  No
Probing for `SMSC EMC6D102'...                              No
Probing for `SMSC EMC6D103'...                              No
Probing for `SMSC EMC6D103S or EMC2300'...                  No
Probing for `SMSC EMC6W201'...                              No
Probing for `Winbond WPCD377I'...                           No
Probing for `Analog Devices ADT7470'...                     No
Probing for `Analog Devices ADT7473'...                     No
Probing for `Analog Devices ADT7476'...                     No
Probing for `Analog Devices ADT7490'...                     No
Probing for `Andigilog aSC7611'...                          No
Probing for `Andigilog aSC7621'...                          No
Probing for `National Semiconductor LM87'...                No
Probing for `Analog Devices ADM1024'...                     No
Probing for `National Semiconductor LM93'...                No
Probing for `National Semiconductor LM94 or LM96194'...     No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83791D'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          No
Probing for `Nuvoton W83795G/ADG'...                        No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG/W83667HG/W83677HG'...        No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Genesys Logic GL518SM'...                      No
Probing for `Genesys Logic GL520SM'...                      No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1026'...                     No
Probing for `Analog Devices ADM1025'...                     No
Probing for `Philips NE1619'...                             No
Probing for `Maxim MAX6639'...                              No
Probing for `Texas Instruments AMC6821'...                  No
Probing for `Analog Devices ADM1029'...                     No
Probing for `Analog Devices ADM1030'...                     No
Probing for `Analog Devices ADM1031'...                     No
Probing for `Analog Devices ADM1022'...                     No
Probing for `Texas Instruments THMC50'...                   No
Probing for `ITE IT8712F'...                                No
Probing for `ALi M5879'...                                  No
Probing for `SMSC LPC47M15x/192/292/997'...                 No
Probing for `SMSC DME1737'...                               No
Probing for `SMSC SCH5027D-NW'...                           No
Probing for `Winbond W83791SD'...                           No
Client found at address 0x4f
Probing for `National Semiconductor LM75'...                No
Probing for `National Semiconductor LM75A'...               No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `Maxim MAX6642'...                              No
Probing for `Texas Instruments TMP421'...                   No
Probing for `Texas Instruments TMP422'...                   No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `NXP/Philips SA56004'...                        No

--> So two I2C addresses were responsive on that DDC channel, 0x2c and
0x4f, probably corresponding to two devices. No device was recognized
by sensors-detect. Most likely one of these devices controls the
display somehow, and did not like the probing sequences. More on that
below.


Next adapter: DPDDC-C (i2c-7)
Do you want to scan it? (yes/NO/selectively):


Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp':
  * Chip `Intel digital thermal sensor' (confidence: 9)


> I don't know where, exactly, the flicker happened. I know it was near the
> end. The flicker happens whenever it probes everything under DPDDC-A. Also,
> there's no change in my xorg log.

I'm a bit surprised by the two addresses. I expected the problem to
come from address 0x37 (the standard DDC/CI interface address) or 0x50
(EDID EEPROM.) Unfortunately as long as we have no idea what the chips
at 0x2c and 0x4f are, it's impossible to tell which address and device
caused problem, nor what happened exactly, nor how to fix it.

The sensors-detect script accesses the DDC channel directly
through /dev/i2c-* device nodes so I am not surprised that you see no
trace of it in the xorg log.

> Any suggestions, even if it's where else to look for help? Any other logs
> you need?

Did you try try cold booting the laptop? This means: powering it down,
unplugging the AC adapter, removing the battery, waiting for several
minutes, then plugging everything back and starting the laptop.

Also if you also have Windows installed on the laptop, you may try
booting it, maybe Lenovo's utilities can fix the problem.

If that doesn't help, I'm afraid I can't offer any help as long as I
don't know what the two I2C chips are. Providing register dumps (using
i2cdump from the i2c-tools package) may help, but it may also make
things worse, so it's up to you if you want to give it a try.
Alternatively you may try contacting Lenovo's support and asking them
for the information, but chances that they actually reply with useful
data seems thin.

I can also offer to create a ticket in our bug tracking tool, to record
the issue in case other users are affected, and tweak sensors-detect to
be even safer even when the user explicitly asks for DDC channels to be
probed.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
