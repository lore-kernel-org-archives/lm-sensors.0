From: stevenkaratnyk@rogers.com (Steven Karatnyk)
Date: Mon, 16 Jan 2006 20:11:03 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <43CBFDD7.9010800@rogers.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Steven,
>
>   
>>> OK, great :) The /usr/local variants should always be before the /usr
>>> variants in $PATH, but depending on the distribution and/or the user,
>>> it might not actually be the case.
>>>       
>> Suse 10.0 in my case
>>     
>
> I just installed Suse 10.0 on one of my systems yesterday, and I do
> have /usr/local/bin before /usr/bin as expected. Maybe you have some
> custom configuration on your own account.
>   
Not that I know of. Given I'm still very much a rookie when it comes to 
Linux, its most likely that the problem existed behind my keyboard.

> That being said, there still is a problem when you have the same
> library installed under /usr/lib and /usr/local/lib, regardless of
> $PATH.
>   

Looking in /usr/lib I notice only one library: libsensors.a (which is 
from Sept 12th/05 ... marking it as being from v2.9.1)

Looking in /usr/local/lib reveals 4 files (all of which dated Jan 9th/06):
libsensors.a
libsensors.so ... which is a link to libsensors.so.3
libsensors.so.3 .... which is a link to libsensors.so.3.0.9
libsensors.so.3.0.9

Should I just copy the libsensors.a and libsensors.so.3.0.9 into /usr/lib ?

Any potential for error if the the wrong library is being read?

Thanks, Steven

