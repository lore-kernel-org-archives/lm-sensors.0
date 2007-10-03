From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 03 Oct 2007 04:29:14 +0000
Subject: Re: [lm-sensors] lm-sensors with VIA vt82c596b
Message-Id: <191fb4ca0710022129xa05c9b4ha44144acd2602c0a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070929033210.GA30044@cyberspace>
In-Reply-To: <20070929033210.GA30044@cyberspace>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dmitry,

On 10/2/07, Dmitry <admin@incred.org> wrote:
> In letter Mon, 01 Oct 2007 10:06:58 -0700, Juerg Haefliger wrote:
>
>
> > Can you please post the full output of sensors-detect?
> >
> > ...juerg
> >
> yes, i can...
>
> ##################################
> $ sudo sensors-detect
> Password:
> # sensors-detect revision 4171 (2006-09-24 03:37:01 -0700)
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no): yes
> Probing for PCI bus adapters...
> Use driver `i2c-viapro' for device 0000:00:07.3: VIA Technologies
> VT82C596 Apollo ACPI
>
> We will now try to load each adapter module in turn.
> Module `i2c-viapro' already loaded.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
>
> To continue, we need module `i2c-dev' to be loaded.
> Do you want to load `i2c-dev' now? (YES/no): yes
> Module loaded successfully.
>
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
>
> Next adapter: SMBus Via Pro adapter at 5000
> Do you want to scan it? (YES/no/selectively): yes
> Client found at address 0x51
> Handled by driver `eeprom' (already loaded), chip type `eeprom'
> Client found at address 0x69
>
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no): yes
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> Probing for `Winbond W83627HF' at 0x290...                  No
> Probing for `Silicon Integrated Systems SIS5595'...         No
> Probing for `VIA VT82C686 Integrated Sensors'...            No
> Probing for `VIA VT8231 Integrated Sensors'...              No
> Probing for `AMD K8 thermal sensors'...                     No
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): yes
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `ITE'...                                      No
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `ITE'...                                      No
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
>
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus Via Pro adapter at 5000'
>     Busdriver `i2c-viapro', I2C address 0x51
>     Chip `eeprom' (confidence: 6)
>
>   EEPROMs are *NOT* sensors! They are data storage chips commonly
>   found on memory modules (SPD), in monitors (EDID), or in some
>   laptops, for example.
>
> I will now generate the commands needed to load the required modules.
> Just press ENTER to continue:
>
>
> If you want to load the modules at startup, generate a config file
> below and make sure lm_sensors gets started at boot time; e.g
> $ rc-update add lm_sensors default
> To make the sensors modules behave correctly, add these lines to
> /etc/modules.d/lm_sensors and run modules-update:
>
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
>
> If you have some drivers built into your kernel, the list above will
> contain too many modules. Skip the appropriate ones! You really
> should try these commands right now to make sure everything is
> working properly. Monitoring programs won't work until the needed
> modules are loaded.
>
> To load everything that is needed, execute the commands below...
>
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-viapro
> # Chip drivers
> modprobe eeprom
> # sleep 2 # optional
> /usr/bin/sensors -s # recommended
> #----end cut here----
>
> Do you want to overwrite /etc/conf.d/lm_sensors? Enter s to specify other
> file name?
>   (yes/NO/s):
> ###########################
>

Sensors-detect didn't find anything. What makes you think you have a
HW-monitoring chip? Does the BIOS show any voltages/temps? Have you
tried the latest version of sensors-detect (2.10.4)? What's your mobo
model?

...juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
