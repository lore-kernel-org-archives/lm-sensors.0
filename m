From: jcromie@divsol.com (Jim Cromie)
Date: Mon, 27 Jun 2005 15:37:29 +0000
Subject: [lm-sensors] code question on pc87360 module
Message-Id: <42C000FF.7060800@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42BDF4E6.1010303@divsol.com>
In-Reply-To: <42BDF4E6.1010303@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Jim,
>
>  
>
>>soekris:~# more /proc/ioports |grep pc87360
>>6620-662f : pc87360
>>6640-664f : pc87360
>>
>>the last 2 lines arent there until modprobed, but I cant find
>>where/how they're inserted - I grepped all i2c code for an
>>ioremap, they're all in i2c/busses/, none of which appear to
>>match these modules, or the objects which comprise them.
>>
>>i2c_sensor              4480  1 pc87360
>>i2c_isa                 2304  0
>>i2c_core               23696  3 pc87360,i2c_sensor,i2c_isa
>>
>>anybody got a clue for the needy ?
>>    
>>
>
>Search for request_region()/release_region() in pc87360.c.
>
>  
>
thanks.

Got it working. Now writes pins (problem was not reservation related)
Patch-set attached, comments welcome.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: gpio-patches-E.tgz
Type: application/x-gzip
Size: 8563 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050627/38f2b32d/gpio-patches-E.tgz
