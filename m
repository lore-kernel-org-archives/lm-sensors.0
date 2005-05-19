From: hunold-ml@web.de (Michael Hunold)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: [PATCH][2.6] Add command function to struct i2c_adapter
Message-Id: <415481B4.10804@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <414F111C.9030809@linuxtv.org>	<20040921154111.GA13028@kroah.com>	<41545421.5080408@web.de> <20040924200503.652ccf8e.khali@linux-fr.org>
In-Reply-To: <20040924200503.652ccf8e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: Greg KH <greg@kroah.com>

Hi,

On 24.09.2004 20:05, Jean Delvare wrote:
>>We like to have an completly isolated i2c adapter, where the device 
>>driver can invite i2c drivers to connect an i2c client to. When the 
>>connection is made, an "interface" pointer with client-specific data
>>or function pointers can be provided.
>>(...)
>>- add a new NO_PROBE flag to struct i2c_adapter, so a particular
>>adapter is never probed by anyone

> I don't get it. If the adapter is isolated, there is no way the i2c-core
> will probe it anyway. As Adrian Cox underlined, it should be far easier
> and more efficient to separate these adapters from the main i2c adapters
> list from the beginning than leaving them in the main list and then try
> and prevent future probings using a flag.

There a two scenarios, where you don't have full control over the i2c 
adapter or you don't want to fully isolate the bus:

1) Some dvb drivers are bttv-sub-drivers, ie. bttv does the pci and i2c 
handling by itself. You have the struct i2c_adapter pointer, but it has 
been registered by bttv, most likely as an analog and/or digital tv i2c bus.

2) Embedded platforms have usually a system-wide i2c bus, so you cannot 
isolate the bus here.

It's useful to register both adapters and drivers to the i2c-core, so 
you keep the door open.

> Also, how does this proposal interact with the work on the i2c classes?
> Although the classes carry more information than a simple flag or a
> complete separation, both were/may be introduced to achieve the same
> goal, isn't it?

Partly, yes.

The .class approach is necessary to have a finer grained access control 
by the i2c-core regarding bus classes, ie. not the client drivers have 
to check if the bus should be probed (for example dcc drivers on a dvb 
bus). This is useful in general.

If we have a PCI card where we exactly know what we are doing, we can 
use the NO_PROBE flag to effectively block any probing and can use the 
proposed interface to manually connect the clients.

> Thanks,

CU
Michael.
