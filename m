From: devsku@gmail.com (Sunil Kumar)
Date: Fri, 01 Sep 2006 18:06:53 +0000
Subject: [lm-sensors] Is the Intel i945G supported/planned?
Message-Id: <ce9ef0d90609011106t40713827mbcff462fa70275e6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90608291525r42520432gd67005073da32057@mail.gmail.com>
In-Reply-To: <ce9ef0d90608291525r42520432gd67005073da32057@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ok, here it is, from the newer script:

-----------------------------------------------------------------------------
# sensors-detect revision $Revision$

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel ICH7
Probe successfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at e8a0
Do you want to scan it? (YES/no/selectively): YES
Client found at address 0x08
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x50
Handled by driver `eeprom' (already loaded), chip type `eeprom'
Client found at address 0x52
Handled by driver `eeprom' (already loaded), chip type `eeprom'
Client found at address 0x69

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): YES
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Winbond W83627HF' at 0x290...                  No
Probing for `Winbond W83627EHF' at 0x290...                 No
Probing for `Winbond W83627DHG' at 0x290...                 No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `AMD K8 thermal sensors'...                     No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): YES
Probing for Super-I/O at 0x2e/0x2f
Probing for `ITE IT8702F Sensors'...                        No (0x7901)
Probing for `ITE IT8705F Sensors'...                        No (0x7901)
Probing for `ITE IT8712F Sensors'...                        No (0x7901)
Probing for `ITE IT8716F Sensors'...                        No (0x7901)
Probing for `ITE IT8718F Sensors'...                        No (0x7901)
Probing for `Nat. Semi. PC87351 Fan Sensors'...             No (0x79)
Probing for `Nat. Semi. PC87360 Fan Sensors'...             No (0x79)
Probing for `Nat. Semi. PC87363 Fan Sensors'...             No (0x79)
Probing for `Nat. Semi. PC87364 Fan Sensors'...             No (0x79)
Probing for `Nat. Semi. PC87365 Fan Sensors'...             No (0x79)
Probing for `Nat. Semi. PC87365 Voltage Sensors'...         No (0x79)
Probing for `Nat. Semi. PC87365 Thermal Sensors'...         No (0x79)
Probing for `Nat. Semi. PC87366 Fan Sensors'...             No (0x79)
Probing for `Nat. Semi. PC87366 Voltage Sensors'...         No (0x79)
Probing for `Nat. Semi. PC87366 Thermal Sensors'...         No (0x79)
Probing for `Nat. Semi. PC87372 Fan Sensors'...             No (0x79)
Probing for `Nat. Semi. PC87373 Fan Sensors'...             No (0x79)
Probing for `Nat. Semi. PC87591'...                         No (0x79)
Probing for `Nat. Semi. PC87371'...                         No (0x79)
Probing for `Nat. Semi. PC97371'...                         No (0x79)
Probing for `Nat. Semi. PC8739x'...                         No (0x79)
Probing for `Nat. Semi. PC8741x'...                         No (0x79)
Probing for `Nat. Semi. PC87427 Fan Sensors'...             No (0x79)
Probing for `Nat. Semi. PC87427 Health Sensors'...          No (0x79)
Probing for `SMSC LPC47B27x Fan Sensors'...                 No (0x79)
Probing for `SMSC LPC47M10x/13x Fan Sensors'...             No (0x79)
Probing for `SMSC LPC47M14x Fan Sensors'...                 No (0x79)
Probing for `SMSC LPC47M15x/192/997 Fan Sensors'...         No (0x79)
Probing for `SMSC LPC47S42x Fan Sensors'...                 No (0x79)
Probing for `SMSC LPC47S45x Fan Sensors'...                 No (0x79)
Probing for `SMSC LPC47M172'...                             No (0x79)
Probing for `SMSC LPC47B397-NC'...                          No (0x79)
Probing for `SMSC SCH5307-NS'...                            No (0x79)
Probing for `SMSC LPC47M584-NC'...                          No (0x79)
Probing for `VIA VT1211 Sensors'...                         No
Probing for `Winbond W83627EHF/EHG Sensors'...              No
Probing for Super-I/O at 0x4e/0x4f
Probing for `ITE IT8702F Sensors'...                        No
Probing for `Nat. Semi. PC87351 Fan Sensors'...             No
Probing for `SMSC LPC47B27x Fan Sensors'...                 No
Probing for `VIA VT1211 Sensors'...                         No
Probing for `Winbond W83627EHF/EHG Sensors'...              No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at e8a0'
    Busdriver `i2c-i801', I2C address 0x50
    Chip `eeprom' (confidence: 6)
  * Bus `SMBus I801 adapter at e8a0'
    Busdriver `i2c-i801', I2C address 0x52
    Chip `eeprom' (confidence: 6)

  EEPROMs are *NOT* sensors! They are data storage chips commonly
  found on memory modules (SPD), in monitors (EDID), or in some
  laptops, for example.

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
# Chip drivers
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.

Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO): NO

----------------------------------------------------------------------------------
That's exactly what I had from the first ever run. I am not sure why
subsequent runs refused to find any chip (A bug in older sensors-detect) but
this is what it found the very first time and I had set it  up with these in
/etc/conf.d/lm_sensors (gentoo diversion, /etc/init.d/lm_sensors reads it, I
think) and /etc/modules.conf. Obviously, 'sensors' still comes out with 'No
sensors found!' even when all the modules are loaded properly.

-Sunil


On 9/1/06, Sunil Kumar <devsku at gmail.com> wrote:
>
> sure, I will give the new one a try.
>
> BIOS doesn't have any hardwar monitoring information. its a dell, what do
> ya expect...;-)
>
>
> On 9/1/06, Jean Delvare <khali at linux-fr.org> wrote:
> >
> > Sunil,
> >
> > > yeah, I messed up a bit. i2c-dev is indeed a module and I didn't
> > modprobe it
> > > before I ran sensors-detect.
> > >
> > > But doesn't make much difference. I re-ran the sensors-detect and this
> > time
> > > I asked it to load the i2c-dev. Didn't find any chip this time either.
> >
> >
> > It may not make much difference for your old sensors-detect and for
> > you, but it may make for us especially if you use the latest version of
> > sensors-detect:
> >
> > http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
> >
> > So please give it a try and report the full output. Maybe it won't find
> > anything, maybe you just don't have sensors on that system, but at
> > least we'll be sure.
> >
> > Is there any hardware monitoring information reported by the BIOS?
> >
> > --
> > Jean Delvare
> >
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060901/68da0c14/attachment-0001.html 
