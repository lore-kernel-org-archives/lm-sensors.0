From: frank.beesley@aeroflex.com (Frank Beesley)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH 2.6] Add class definition to the elektor bus driver
Message-Id: <421FAD94.5000707@aeroflex.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050225211155.0d258af2.khali@linux-fr.org>
In-Reply-To: <20050225211155.0d258af2.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Frank,
>
>  
>
>>The patch works BUT...
>>The PCF8584 device is a bridge, not a hardware monitor. One of the
>>other  I2C device types could very well be behind it such as a sound
>>chip.  Maybe we could add a BRIDGE type or have it as a I2C_CLASS_ALL
>>device.  This is just a suggestion - like I said, the patch works for
>>me.
>>    
>>
>
>The PCF8584 is an I2C master, as I understand it. It's as much of a
>bridge as every other I2C or SMBus master is. The idea of a bridge class
>doesn't make any sense to me. A class is meant to isolate chip drivers
>from bus drivers. As such, class definitions are carried by bus drivers
>and checked by chip drivers. This doesn't leave any room for a bridge
>class unless I'm missing something obvious.
>
>Setting class to I2C_CLASS_ALL would somehow defeat our attempt to
>isolate different types of I2C busses. It's better to add classes when
>it is found that we actually need them.
>
>That being said, I don't know exactly where the PCF8584 is found and
>what the Elektor is. Care to tell me what kind of hardware your are
>playing with?
>
>Thanks,
>  
>
In my application the PCF8584 is located on the ISA bus from the cpu's 
south bridge. I have a Cypress CPLD doing the ISA address decoding and 
chip selects. From the list I sent earlier, you can see that I chain 
several sensors on this I2C bus. The one part I didn't include in my 
list earlier is a X24165 EEPROM device (going obsolete and being 
replaced by X4165) of which I have four installed. I have a driver for 
this part but it is not completely tested so I have not submitted it for 
consideration. FYI - I don't know where the elektor name came from.

I understand and agree with your comments about isolating chip drivers 
from bus drivers. My point is since the Elektor is just a bus master, it 
does not know what class of chips might be placed on its bus just that 
they are I2C. The only analogy I can think of is saying a PCI 
Bridge/Master chip is of class "video" because there is a video device 
on its bus. There may also be an ethernet device, sound device, etc. 
This is where my comment comes from that the use of the Elektor 
driver/module does not define that only hardware monitor chips/devices 
are located on the bus. Yes is capable of communicating with hardware 
monitor chips but it can also communicate with other classes such as 
eeprom and sound.

Thanks


