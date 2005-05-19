From: bertrik@zonnet.nl (Bertrik Sikken)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: ASUS A7V333, ASB100(bach) must not be an as99127f
Message-Id: <3E022F96.4080005@zonnet.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1040258701.6614.45.camel@linux.local>
In-Reply-To: <1040258701.6614.45.camel@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:

> * Ed Harrison <ed.tman@verizon.net> [2002-12-18 19:45:01 -0500]:
>
>> I was going to try to hack w83781d.c into something useable, but alas I
>>
>> am too dumb. I offer what I know about this chip in hopes one of you
>> can do it, maybe as a force_asb100=0,0x2d option to w83781d.
>>
>
> <cut, as99127f vs asb100>
>
>> Temp sensor 4: $17 on ASB100 [AMD diode only it seems]
>>
>
> Yes, another a7v333 user mentioned this previously. I thought he might
> eventually submit a patch? In the meantime, let's try to get everything
> else working for you. To start with, make sure you have at least the
> 2.6.5 i2c & sensors packages.
>
That might have been me. I put some info about the ASB100 chip at
http://home.kabelfoon.nl/~bertrik/asb100/asb100.html
but I had not planned to create a patch, but perhaps now is
a good time to start with it.

Regards,
Bertrik

