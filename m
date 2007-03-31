From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 31 Mar 2007 13:24:47 +0000
Subject: Re: [lm-sensors] ITE IT8718F Super IO Sensors
Message-Id: <20070331152447.081cff4c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <460C6782.7010603@argencasas.com>
In-Reply-To: <460C6782.7010603@argencasas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Aldo,

On Thu, 29 Mar 2007 22:27:30 -0300, Aldo Caruso wrote:
> Hi,
> 
>   I'm running debian on a Penium IV with a P4M800PRO-M motherboard.
>   I run sensors-detect and this is the result :
> 
> //--------------------------------------------------------------
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> 
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus Via Pro adapter at 0400'
>     Busdriver `i2c-viapro', I2C address 0x50
>     Chip `eeprom' (confidence: 6)
> 
>   EEPROMs are *NOT* sensors! They are data storage chips commonly
>   found on memory modules (SPD), in monitors (EDID), or in some
>   laptops, for example.
> 
> Driver `it87' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `ITE IT8718F Super IO Sensors' (confidence: 9)
> 
> I will now generate the commands needed to load the required modules.
> Just press ENTER to continue:
> 
> To make the sensors modules behave correctly, add these lines to
> /etc/modules:
> 
> #----cut here----
> # I2C adapter drivers
> i2c-viapro
> # Chip drivers
> eeprom
> it87
> #----cut here----
> //--------------------------------------------------------------
> 
> I let the program add the former lines to /etc/modules, I reboot, I run 
> sensors and this is the result:
> //--------------------------------------------------------------
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.
> //--------------------------------------------------------------
> 
> Doing lsmod I found all the above modules listed.

Which kernel are you running? If you look at:
  http://www.lm-sensors.org/wiki/Devices
you'll see that support for the ITE IT8718F is only available since
kernel 2.6.19.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
