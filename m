From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 19 Oct 2007 06:57:18 +0000
Subject: Re: [lm-sensors] Dell Poweredge SC430
Message-Id: <4718554E.3000800@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <024001c8116e$a9623700$9020a8c0@dbrt.hu>
In-Reply-To: <024001c8116e$a9623700$9020a8c0@dbrt.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Igaz Tibor wrote:
> Sorry, here are the missing informations.
> If I can any more information give you, just let me know.
> 
> OS: Linux (openSUSE 10.3)
> sensors: sensors-2.10.4-23 (OS package)
> 
> ----------------------------------------------------------------------------
> --------------
> sensors-detect output (without the uninportant parts):
> 
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
> 
> We will now try to load each adapter module in turn.
> Module `i2c-i801' already loaded.
> ...
> To continue, we need module `i2c-dev' to be loaded.
> Do you want to load `i2c-dev' now? (YES/no):
> Module loaded successfully.
> ...
> Next adapter: SMBus I801 adapter at ece0 (i2c-0)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x44
> Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x52
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
> ...
> Do you want to scan the ISA I/O ports? (YES/no):
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> Probing for `Silicon Integrated Systems SIS5595'...         No
> Probing for `VIA VT82C686 Integrated Sensors'...            No
> Probing for `VIA VT8231 Integrated Sensors'...              No
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
> ...
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found `SMSC SCH5504-NS Super IO'
>     (no hardware monitoring capabilities)
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No
> ...
> Do you want to scan for them? (YES/no):
> AMD K8 thermal sensors...                                   No
> Intel Core family thermal sensor...                         No
> Intel AMB FB-DIMM thermal sensor...                         No
> ...
> Sorry, no sensors were detected.
> Either your sensors are not supported, or they are connected to an
> I2C or SMBus adapter that is not supported. :(
> ----------------------------------------------------------------------------
> ----------------------------
> 

Hmm,

Not really helpfull I'm afraid, maybe the smbus is multiplexed, or who knows 
what other trickery is going on. I've contacted someone at Dell who I know and 
who does Linux things there for some info.

Regards,

Hans



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
