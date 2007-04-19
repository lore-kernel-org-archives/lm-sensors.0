From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 19 Apr 2007 11:45:55 +0000
Subject: Re: [lm-sensors] no sensors found
Message-Id: <20070419134555.543ad965@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c43068$c801a6e0$0100000a@volcano>
In-Reply-To: <000801c43068$c801a6e0$0100000a@volcano>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mike,

On Mon, 16 Apr 2007 10:30:04 +0200, Mike Cornelison wrote:
> I hope this is the right place for this.
> Kindly give me some guidance if not.
> 
> I am unable to get lm-sensors to work with a new MSI mainboard.
> 
> mainboard:  MSI P6N SLI
> chipset:  nForce 650i SLI C55  +  nForce 430i MCP51
> Linux: Ubuntu 7.04 (beta) with kernel 2.6.20-15
> lm-sensors package: 2.10.1
> 
> sensors-detect outputs:
> 
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `NVIDIA i2c adapter 0 at 1:00.0'
>     Busdriver `UNKNOWN', I2C address 0x50 (and 0x51 0x52 0x53 0x54 0x55 
> 0x56 0x57)
>     Chip `EDID EEPROM' (confidence: 8)
>   * Bus `SMBus nForce2 adapter at 5000'
>     Busdriver `i2c-nforce2', I2C address 0x50
>     Chip `SPD EEPROM' (confidence: 8)
>   * Bus `SMBus nForce2 adapter at 5000'
>     Busdriver `i2c-nforce2', I2C address 0x51
>     Chip `SPD EEPROM' (confidence: 8)
> ...

These are EEPROMs on your memory modules, not sensors, so it's expected
they don't show in the "sensors" output. Use the decode-dimms.pl script
if you want to decode the contents of the EEPROMs.

> 
> Driver `lm92' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus nForce2 adapter at 6000'
>     Busdriver `i2c-nforce2', I2C address 0x46
>     Chip `Maxim MAX6633/MAX6634/MAX6635' (confidence: 2)
> ...

This is a rather rare chip, and easily misdetected (see the low
confidence value). So I don't think you actually have this chip, and
you shouldn't load the lm92 driver.

> 
> #----cut here----
> # I2C adapter drivers
> # modprobe unknown adapter NVIDIA i2c adapter 0 at 1:00.0
> # modprobe unknown adapter NVIDIA i2c adapter 1 at 1:00.0
> # modprobe unknown adapter NVIDIA i2c adapter 2 at 1:00.0
> i2c-nforce2
> # Chip drivers
> eeprom
> lm92
> #----cut here----
> 
> Do you want to add these lines to /etc/modules automatically? (yes/NO)y
> 
> root@mico2:/home/mico# modprobe eeprom
> root@mico2:/home/mico# modprobe lm92
> root@mico2:/home/mico# sensors
> No sensors found!
> ...
> root@mico2:/home/mico# modprobe i2c-nforce2
> root@mico2:/home/mico# sensors
> No sensors found!
> 
> 
> Is this mainboard not supported or should I try something else?

Please provide the full output of sensors-detect from lm-sensors
2.10.3. Most likely the sensor chip is too recent for the (relatively)
old version of sensors-detect that you used, so it didn't find it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
