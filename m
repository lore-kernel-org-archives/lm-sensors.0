From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 21 Sep 2006 06:11:58 +0000
Subject: [lm-sensors] Module(s) ALI15** not loading
Message-Id: <20060921081158.7d0f1bad.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1158188393.9914.5.camel@localhost.localdomain>
In-Reply-To: <1158188393.9914.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alejandro,

> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-ali15x3' for device 0000:00:15.1: Acer Labs 1533/1543
> Use driver `i2c-ali1535' for device 0000:00:15.1: Acer Labs 1535
> 
> We will now try to load each adapter module in turn.
> Module `i2c-ali15x3' already loaded.
> Module `i2c-ali1535' already loaded.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
> 
> To continue, we need module `i2c-dev' to be loaded.
> Do you want to load `i2c-dev' now? (YES/no):
> Module loaded successfully.
> 
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
> 
> Next adapter: NVIDIA I2C Device
> Do you want to scan it? (YES/no/selectively): n
> 
> Next adapter: NVIDIA I2C Device
> Do you want to scan it? (YES/no/selectively):
> Adapter cannot be probed, skipping.
> 
> Next adapter: NVIDIA I2C Device
> Do you want to scan it? (YES/no/selectively):
> Adapter cannot be probed, skipping.
> 
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no):
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> Probing for `Winbond W83627HF' at 0x290...                  No
> Probing for `Silicon Integrated Systems SIS5595'...         No
> Probing for `VIA VT82C686 Integrated Sensors'...            No
> Probing for `VIA VT8231 Integrated Sensors'...              No
> Probing for `AMD K8 thermal sensors'...                     Success!
>     (confidence 9, driver `k8temp')
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
> 
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `ITE'...                                      Yes
> Found unknown chip with ID 0x8863
>     (logical device B has address 0x290, could be sensors)
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       Yes
> Found `Winbond W83627EHF/EHG Super IO Sensors'              Success!
>     (address 0x290, driver `w83627ehf')
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `ITE'...                                      No
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> 
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> 
> Driver `k8temp' (should be inserted):
>   Detects correctly:
>   * ISA bus, undetermined address (Busdriver `i2c-isa')
>     Chip `AMD K8 thermal sensors' (confidence: 9)
> 
> Driver `w83627ehf' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `Winbond W83627EHF/EHG Super IO Sensors' (confidence: 9)

So you can most certainly get hardware monitoring to work on this board
without using the ALi SMBus. You'll need a fairly recent kernel though,
as k8temp is only in -mm for now (will go to 2.6.19) and w83627ehf got
recent improvements as well.

Of course it doesn't explain why the ALi SMBus doesn't work, and it'd
be nice to fix it if possible, but if all you are after is hardware
monitoring, you can do without it.

-- 
Jean Delvare

