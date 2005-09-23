From: junpingfeng@yahoo.com.cn (junping feng)
Date: Fri, 23 Sep 2005 04:17:40 +0000
Subject: =?gb2312?q?=BB=D8=B8=B4=A3=BA=20Re:=20=BB=D8=B8=B4=A3=BA=20Re:=20[lm-sens?=
Message-Id: <20050923021631.8976.qmail@web15704.mail.cnb.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you!
But I have another problem that how can I achieve writes function in the module eeprom.c(in the lm-sensors package) .Can you help me and give me the scource codes?

Mark Studebaker <mds@mds.gotdns.com> ???
see the userspace programs and documents in prog/eepromer
in the lm-sensors package.

the kernel module does not support writes.

junping feng wrote:
> I am sorry for my fault of the eeprom. My eeprom is
> AT24C01A,and its size is 1Kbits(128Bytes).
> In the ile /lm_sensors-2.5.0/kernel/chips/eeprom.c,
> how can I complete the function of writing to the
> chip?
> please help me !
> Can you give me the source codes?
> Thanks!
> 
> 
> --- Ben Dooks ??:
> 
> 
>>On Tue, Sep 20, 2005 at 05:52:54PM +0800, junping
>>feng wrote:
>>
>>>Hi,
>>> My cpu is PowerPC8250.I2C device is eeprom
>>
>>AT24C01.
>>
>>>I want to access the eeprom,read from the eeprom
>>
>>and
>>
>>>write to it.
>>> I have read the file
>>>/lm_sensors-2.5.0/kernel/chips/eeprom.c,but this
>>
>>file
>>
>>>can't achieve writing function and only can read
>>
>>128
>>
>>>bytes.
>>> How can i complete the writing functions and
>>
>>read
>>
>>>total the chip (1024 bytes).
>>
>>The chip is only 128 bytes big. You are confusing
>>the
>>_bit_ size (which is 1024bits).
>>
>>I have no actual experience of this chip, but the
>>data-sheet implies it is only capable of page-write
>>of 4 bytes at a time, so it could be the eeprom
>>driver is trying to write too much data in one go.
>>
>>-- 
>>Ben (ben@fluff.org, http://www.fluff.org/)
>>
>> 'a smiley only costs 4 bytes'
>>
> 
> 
> 
> 
> 
> ___________________________________________________________ 
> ???????????2G?????pop3?????????? 
> http://cn.mail.yahoo.com
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

		
---------------------------------
 ????G???????????????????
 ??????????????  
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050923/0fa297d0/attachment-0001.html
