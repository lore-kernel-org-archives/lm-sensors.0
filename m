From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 Jan 2009 16:46:38 +0000
Subject: Re: [lm-sensors] Support for Intel DG33FB main board?
Message-Id: <20090108174638.1aa0d060@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <495C30EF.3090708@earthlink.net>
In-Reply-To: <495C30EF.3090708@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 08 Jan 2009 11:42:27 -0500, Stephen Clark wrote:
> Thanks for the reply, here is the complete output of sensors-detect:
> 
> # sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)
> 
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
> 
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 0000:00:1f.3: Intel ICH9
> 
> We will now try to load each adapter module in turn.
> Module `i2c-i801' already loaded.
> If you have undetectable or unsupported I2C/SMBus adapters, you can have
> them scanned by manually loading the modules before running this script.
> 
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
> 
> Next adapter: SMBus I801 adapter at 3000 (i2c-0)
> Do you want to scan it? (YES/no/selectively):

SMBus adapter found, but...

> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>      (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x51
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>      (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x52
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>      (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x53
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>      (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No

... nothing on the SMBus that remotely looks like a hardware monitoring
chip. This suggests the hardware monitoring is done by the ICH9,
meaning you're out of luck, sorry.

Maybe you can check the motherboard documentation (Intel make good
ones) for confirmation.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
