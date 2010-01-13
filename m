From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Jan 2010 15:20:34 +0000
Subject: Re: [lm-sensors] Found unknown SMBus adapter 10de:0aa2 at
Message-Id: <20100113162034.2d3c2c7b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100113153747.1dab14c5@hyperion.delvare>
In-Reply-To: <20100113153747.1dab14c5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 13 Jan 2010 15:49:35 +0100, Manuel Lamotte-Schubert wrote:
> In fact, actually some minutes before your repsonse I've already run the most recent version of sensors-detect as you suggested.
> 
> Here's the output:
> ...
> Intel Atom thermal sensor...                                Success!
>     (driver `coretemp')
> ...
> Using driver `i2c-nforce2' for device 0000:00:03.2: nVidia Corporation nForce SMBus (MCP79)
> ...
> Next adapter: SMBus nForce2 adapter at 4d00 (i2c-0)
> Probing for `Winbond W83L771AWG/ASG'...                     Success!
>     (confidence 6, driver `to-be-written')
> ...
> Driver `to-be-written':
>   * Bus `SMBus nForce2 adapter at 4d00'
>     Busdriver `i2c_nforce2', I2C address 0x4c
>     Chip `Winbond W83L771AWG/ASG' (confidence: 6)
> 
> Driver `coretemp':
>   * Chip `Intel Atom thermal sensor' (confidence: 9)
> 
> Note: there is no driver for Winbond W83L771AWG/ASG yet.
> Check http://www.lm-sensors.org/wiki/Devices for updates.
> 
> 
> This means that the sensor could be detected but there is no driver for using it?

Yes. For the Atom CPU, support is in coretemp since kernel 2.6.32, so
you should have it already. For the W83L771AWG/ASG, support can
probably be added to the lm90 driver. I hoped that someone would send
me a board with this chip, so that I could work on it, but it did not
happen. If you send me a dump of your chip, I can give it a try.

Install i2c-tools, then as root:
# modprobe i2c-dev
# i2cdump 0 0x4c b

And send me the output.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
