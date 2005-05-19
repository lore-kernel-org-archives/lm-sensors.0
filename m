From: frank.beesley@aeroflex.com (Frank Beesley)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: One Wire
Message-Id: <41FE65B0.5020004@aeroflex.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <41FE57FB.9080608@aeroflex.com>
In-Reply-To: <41FE57FB.9080608@aeroflex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Evgeniy Polyakov wrote:

>On Mon, 31 Jan 2005 17:11:06 +0100 (CET)
>"Jean Delvare" <khali@linux-fr.org> wrote:
>
>  
>
>>Hi Frank,
>>
>>    
>>
>>>I am now looking at the one-wire drivers and see some issues coming up
>>>already. Our one-wire devices (DS2401s and DS18B20s) are connected
>>>through a CPLD at ISA port 0x304. I am looking at the matrox driver
>>>since it has a port to access through. Under the linux documentation
>>>(Linux 2.6.9) I can't find anything on one-wire devices. Is there some
>>>docs somewhere that discusses how to use these w1 modules. I believe I
>>>need w1 and w1_therm to start with but I don't see how everything needs
>>>to tie together.
>>>      
>>>
>>I as said, Evgeniy Polyakov (CC'd) is the right person for that kind of
>>questions. My personal knowledge about one-wire is void.
>>    
>>
>
>Hello, Frank, Jean.
>
>ds2401 and ds18*20 are supported by w1_smem and w1_therm drivers.
>So you need to create so called w1 bus master device - it is a driver
>that drives the actual physicall bus and reports to the w1 core
>about this process. Actually it is w1 core that drives the bus using
>callbaks provided by w1 bus master driver.
>
>Since you use ISA port based access then the easiest way is to implement
>only bit operations and register bus master with the w1 core.
>
>You can use matrox_w1 driver and recently included sc_w1 driver(w1 over SuperIO GPIO)
>driver as examples.
>
>Documenting all created cruft has a very high priority for me, bits of
>generic information about w1 already exist in Documentation/w1.
>
>I wish you success in this implementation.
>
>  
>
Ok, now I feel stupid or blind but I can't find a directory under 
Documentation called w1 and a "find" does not find sc_w1.c or sw_gpio.c. 
I currently have kernel 2.6.9 but also looked at the standard 2.6.10 
download. Is the superio and documentation in an individuals patch set 
or am I missing something.

Thanks again.
