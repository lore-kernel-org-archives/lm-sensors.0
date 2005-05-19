From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: Any one using i2c-voodoo3 module on the 2.6 kernel?
Message-Id: <40A630EE.9060406@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <40A424D3.7060006@gilfillan.org>
In-Reply-To: <40A424D3.7060006@gilfillan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Perry Gilfillan wrote:
> Mark Studebaker wrote:
> 
>> It's definitely a PCI registration conflict.
> 
> 
> Then there are three drivers wanting access to the Voodoo3 PCI 
> registers: tdfxfb, i2c-voodoo3, and v3tv.
> 
> It's posible that v3tv and tdfxfb will touch the same registers and 
> break each others functions.  I've thought about merging them, but don't 
> know that I've got the ability to do it right.
> 
> As Jean indicates that the matroxfb and radeonfb drivers have the DDC 
> adapter merged, I take it merging i2c and posibly v3tv into tdfxfb might 
> be acceptable?
> 
> 

I guess it's the only way to do it, right? Don't know what the v3tv people think.

>> I have a modified driver that doesn't do PCI registration, and it works,
>> and even more interesting, when I load the driver I get:
>>
>> i2c-voodoo3.o version mds (mds)
>> i2c-voodoo3.o found device
>> tdfxfb 0000:01:05.0: Using Banshee/Voodoo3 I2C device at cb870000
>>
>> I'll add a note on the 2.6 kernel info page about voodoo.
> 
> 
> Did you do anything more than copy the pci_for_each_dev macro?
> 

correct. You can look at 2.4 kernel version of i2c-voodoo3 in lm_sensors to see.
I just ported that over to 2.6 to test it.

>>
>> Jean Delvare wrote:
>>
>>> I suspect that you have another driver requesting the card, such has a
>>> framebuffer driver. The 2.4 driver doesn't request the device so no
>>> conflict happens. The 2.6 driver does request it, because it is
>>> considered Bad (TM) to use a device without requesting it. This probably
>>> means that the i2c-voodoo3 driver should me merged into the framebuffer
>>> driver, much like it was done for matroxfb and radeonfb. This also makes
>>> sense because the framebuffer driver can use the DDC channel (which is
>>> no more than I2C, renamed) to retrieve information about the monitor and
>>> adapt its output. But this also raises the problem that people may want
>>> to access the i2c busses without loading the full framebuffer driver...
> 
> 
> 
> Thanks,
> 
> Perry
> ------
> Gilfillan Family: http://www.gilfillan.org/
> 
> Projects:
>   V3TV:        http://www.gilfillan.org/v3tv/
>   VPX3224:    http://www.gilfillan.org/vpx3224/
>   V3TV-radio:    http://www.gilfillan.org/v3tv-v4l2/
>   snd-tvmixer:    http://www.gilfillan.org/ALSA/
> 
> 
> 
