From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: PCI bus drivers, i2c-dev
Message-Id: <3EDC13D0.1020407@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EDABA1B.9080106@paradyne.com>
In-Reply-To: <3EDABA1B.9080106@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark D. Studebaker wrote:
> Well I'm a little slow :) but I fixed i2c-dev.
> 
> And checked in i2c-viapro backported from 2.5.69.
> I'll try and backport and/or fix more of the PCI bus drivers that are 
> obviously broken:
>     i2c-ali1535
>     i2c-alil15x3
>     i2c-i801

Hey...  If you're in the i2c-i801 pci_device_id table, can you add the 
82801EB (ICH5) with PCI ID 0x24d3?

Thanks,
:v)

>     i2c-i810
>     i2c-piix4
>     i2c-sis5595
> 
> Mark D. Studebaker wrote:
> 
>> Most of the PCI bus drivers don't work. Sigh.
>> Kyosti got them mostly converted to the PCI module style
>> but then didn't fill in the pci_device_id table.
>>
>> I think the best thing to get them working is to backport them from 2.5
>> rather than finish what Kyosti started, let's use what Greg did.
>> The only real problem is the dev_dbg, dev_info, etc.
>> I'm making a kernel/include/i2c_compat.h to define these to make it 
>> easier.
>> Is that OK?
>>
>> I was testing things with i2cdetect and i2cdump but they just oops.
>> Thought it was the PCI driver problem but now I think it's in
>> i2c-dev.c in i2cdev_open(). I think it's
>> __MOD_INC_USE_COUNT(client.>adapter->owner) that is oopsing? (null 
>> pointer).
>>
>> Every time it oopses the refcount on i2c-dev module increments.
>> Is that what it's supposed to do? Or is it the adapter module? Both?
>> Of course when it increments and then oopses I have to reboot to
>> try and fix it.
>>
>> So it's slow going here. Any ideas? Are i2cdump/i2cdetect working for 
>> 2.5?
>>
>>
> 



-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
