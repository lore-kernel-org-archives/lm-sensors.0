From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: PCI bus drivers, i2c-dev
Message-Id: <3EDFFB30.8020802@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EDABA1B.9080106@paradyne.com>
In-Reply-To: <3EDABA1B.9080106@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Backport is done but let's wait until somebody tests your patch or looks at
the datasheet to add ICH5.

Philip Pokorny wrote:
> Mark D. Studebaker wrote:
> 
>> Well I'm a little slow :) but I fixed i2c-dev.
>>
>> And checked in i2c-viapro backported from 2.5.69.
>> I'll try and backport and/or fix more of the PCI bus drivers that are 
>> obviously broken:
>>     i2c-ali1535
>>     i2c-alil15x3
>>     i2c-i801
> 
> 
> Hey...  If you're in the i2c-i801 pci_device_id table, can you add the 
> 82801EB (ICH5) with PCI ID 0x24d3?
> 
