From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 24 Mar 2012 09:26:55 +0000
Subject: Re: [lm-sensors] bus names and multiple adapters of the same kind
Message-Id: <20120324102655.20b062cd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201203240103.34050.michael@walle.cc>
In-Reply-To: <201203240103.34050.michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

On Sat, 24 Mar 2012 01:03:34 +0100, Michael Walle wrote:
> the busses for the chip statements seems to be compared by their names. Eg. i 
> do have two I2C busses, both uses the same driver. A sensors --bus-list give 
> me:
> 
> bus "i2c-0" "IBM IIC"
> bus "i2c-1" "IBM IIC"
> 
> If i have two i2c sensors at the same i2c address on these two busses, the 
> chip statements always match the first one:
> 
> 
> chip "adt7411-i2c-0-48"
> 
>     label in0 "Test"
>     
> chip "adt7411-i2c-1-48"
> 
>     label in1 "Foobar"
> 
> 
> sensors now only replaces the labels of adt7411-i2c-0-48, but for both in0 and 
> in1. Eg:
> 
> # sensors
> adt7411-i2c-0-48
> Adapter: IBM IIC
> Test:         +3.33 V  
> Foobar:       +0.31 V  
> in2:          +0.00 V
> [..]
> 
> adt7411-i2c-1-48
> Adapter: IBM IIC
> in0:          +3.33 V  
> in1:          +1.92 V  
> in2:          +2.13 V  
> [..]
> 
> 
> The manpage states the following
>   A bus statement binds the description of an I2C or SMBus adapter to a bus
>   number. This makes it possible to refer to an adapter in the configuration
>   file, independent of the actual correspondence of bus numbers and actual
>   adapters (which may change from moment to moment).
> 
> 
> Unfortunately, this doesn't work if there are two adapters with the same name 
> as on most SoCs :(

This is an I2C bus driver bug, they shouldn't use the exact same name
for two adapters. Usually good drivers include something specific in
each bus name, either an address or an ID. For example I have:

# i2cdetect -l
i2c-0	i2c       	Radeon i2c bit bus 0x90         	I2C adapter
i2c-1	i2c       	Radeon i2c bit bus 0x91         	I2C adapter
i2c-2	i2c       	Radeon i2c bit bus 0x92         	I2C adapter
i2c-3	i2c       	Radeon i2c bit bus 0x93         	I2C adapter
i2c-4	i2c       	Radeon i2c bit bus 0x94         	I2C adapter
i2c-5	i2c       	Radeon i2c bit bus 0x95         	I2C adapter
i2c-6	i2c       	Radeon i2c bit bus 0x96         	I2C adapter
i2c-7	i2c       	Radeon i2c bit bus 0x97         	I2C adapter
i2c-8	smbus     	SMBus I801 adapter at 0400      	SMBus adapter
i2c-9	i2c       	Hauppauge Nova-T 500 Dual DVB-T 	I2C adapter
i2c-10	i2c       	DiBX000 tuner I2C bus           	I2C adapter
i2c-11	i2c       	DiBX000 master GPIO12 I2C bus   	I2C adapter
i2c-12	i2c       	DiBX000 master GPIO34 I2C bus   	I2C adapter
i2c-13	i2c       	DiBX000 master GPIO67 I2C bus   	I2C adapter
i2c-14	i2c       	DiBX000 tuner I2C bus           	I2C adapter
i2c-15	i2c       	DiBX000 master GPIO12 I2C bus   	I2C adapter
i2c-16	i2c       	DiBX000 master GPIO34 I2C bus   	I2C adapter
i2c-17	i2c       	DiBX000 master GPIO67 I2C bus   	I2C adapter

As you can see the radeon and i2c-i801 drivers are good citizens. The
dvb-usb-dib0700 driver is not - not that it matters to lm-sensors.

So please report the problem to the upstream maintainer of your i2c bus
driver (i2c-ibm_iic.) I'd help but this is an open-firmware-based
driver and I am not familiar with these, sorry.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
