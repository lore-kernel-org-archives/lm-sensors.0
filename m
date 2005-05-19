From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Issues with Arima HDAMA Opteron Motherboard
Message-Id: <3F974E46.1000701@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E13FD85@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E13FD85@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I found the source of the problem.

In the backport that created CVS version 1.23 from version 1.22 the 
entire driver got pretty much wacked.  As a result, the entries that 
were added to support the AMD8111 in 2.7.0 (version 1.22) got removed 
along with just about all the rest of the code.

So that explains why 2.7.0 works and 2.8 and following don't.

The PCI device ID for the AMD756 compatible interface in the 8111 chip is:

    0x746b

I'll try and find a few more minutes to work on the patch.

:v)

Jean Delvare wrote:
>>The problem is that the i2c-amd756 driver doesn't have the PCI entries
>>
>>for the AMD8111 in it.  The AMD8111 has *two* SMBus interfaces on it. 
>>One is SMBus 2.0 and the other is the amd756 compatible bus that most 
>>commonly has devices connected to it.
>>
>>(...)
>>
>>So it fails to attach to the chip and you don't have the BUS you need
>>to see the devices.
>>
>>I've been meaning to submit a patch for this, but I haven't had the
>>time to get one together.  The patch is very simple.
> 
> 
> Philip,
> 
> That would be really great if you could find some time to commit that
> patch, especially if it is simple. This isn't the first user complaining
> about that problem.
> 
> Thanks.
> 



-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
