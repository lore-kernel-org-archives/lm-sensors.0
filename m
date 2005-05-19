From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: mkpatch testing...
Message-Id: <3DFA8760.3070307@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3DFA6C5A.3050403@paradyne.com>
In-Reply-To: <3DFA6C5A.3050403@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



I would recommend that I2C_HEADERS be set to LINUX_HEADERS by default. 
 (basicly just swap the comment hash between the two lines in the 
Makefile.)  I think it is odd to have it defaulted to /usr/local/include 
since that isn't the normal or usual place for it any more.  Now, 
kernels have for some time had the i2c headers in them, so if you define 
the include search paths as including both kernel headers and 
/usr/local/include, there is a significant risk of having two seperate 
sets of i2c headers of different versions being referenced 
similtaniously.  Right?

We could get fancy by checking if the kernel's i2c is compiled and used, 
and make that set of i2c headers the default if so?  Probably not 
needed, though.


Phil

Mark Studebaker wrote:

> I just found and fixed a couple of things but nothing major.
> Khali did you have anything you wanted to test?
>
> Also, Phil & Khali, any proposal on I2C_HEADERS?
>
> Philip Edelbrock wrote:
>
>>
>>
>> That's how I did it (mkpatch'ed i2c against my kernel), although my 
>> sensors bin is segfaulting... ;')  Keep in mind that the I2C header 
>> variable in the lm_sensors makefile is hardcoded to 
>> /usr/local/include, which is not great imho.
>>
>>
>> Phil
>>
>>
>> Mark Studebaker wrote:
>>
>>> did anybody test mkpatched kernels?
>>> here's one ticket...
>>> perhaps we should do some mkpatch testing before putting the 
>>> announcement on freshmeat?
>>>
>>> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket87
>>>
>>
>
>
