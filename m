From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c-amd756 and dual opteron sensors not foun
Message-Id: <4044ED18.8070801@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
In-Reply-To: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Quoting Philip Pokorny <ppokorny@penguincomputing.com>:
> 
> 
>>The ADM1027 is a monitoring chip.  There is a driver written for it.
>>"adm1027"
>>(...)
> 
> 
> Aha :) Philip, now I'm sure you have a filter on "lm85" ;)

No, I'm just incredibly busy at work right now.  No time for "fun".

> FYI, the problem is not with the ADM1027 itself (if that's what it is)
> but with activating the AMD-8111 bus it is supposed to be connected
> to.

In the past, the motherboards I have worked with have put the sensors on 
the i2c bus, not on the SMBus.  But we're sure this motherboard is 
different?

> This much ressembles the hidden SMBus problem seen on ICH2 and ICH4
> chips, as well as some ALi chips if I remember correctly. But we've
> never seen it on AMD's so far, and I don't know how we can get
> information about it.
>
> If you know anything about how we could activate that hidden 8111 bus,
> please let us know!

The bits to enable or disable the SMBus should be documented in AMD's 
8111 chip documentation.

Those documents are available at www.amd.com.  Try here and download the 
8111 I/O Hub documents:

http://www.amd.com/us-en/Processors/TechnicalResources/0,,30_182_739_9004,00.html

:v)

-- 
Philip Pokorny, Director of Engineering
Tel: 415-954-2823   Fax: 415-954-2899   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
