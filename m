From: mds@mds.gotdns.com (Mark Studebaker)
Date: Fri, 03 Mar 2006 19:35:55 +0000
Subject: [lm-sensors] Microchip 24LC256
Message-Id: <44089A9B.4020804@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060227225941.36483.qmail@web31004.mail.mud.yahoo.com>
In-Reply-To: <20060227225941.36483.qmail@web31004.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

it should be at 0x54, not 0x04, right?

Thomas Loos wrote:
> I took a look at the eepromer tools and I will try
> them first before writing a full blown driver.
> 
> We wired up a test board for the 24LC256 part and
> plugged it into an i2c header on our dev board.  The
> part was wired up to be address 0x04.  I would like to
> see i2cdetect find the chip at its address, but did
> not.  Looking at the documentation for i2cdetect tells
> me that this program does not detect all chips. Will
> it work for the 24LC256?  If it doesn't, are there any
> other tools that would get me past the step of seeing
> the chip sitting on the bus at a particular address so
> I can start reading and writing...
> 
> Thanks,
> Tom
>> --- Mark Studebaker <mds at mds.gotdns.com> wrote:
>>
>>> one of the userspace tools in prog/eepromer may be
>>> sufficient for what 
>>> you need. You could do a new chip driver for the
>> big
>>> eeprom but then you 
>>> have to go through /sys files which is awkward for
>>> eeproms;
>>> look hard at doing userspace access through
>>> /dev/i2c-x,
>>> better and you don't have to write a new driver.
>>>
>>> mds
>>>
>>>
>>> Thomas Loos wrote:
>>>> Hello All!
>>>> I need to support three Microchip 24LC256
>> EEPROMs
>>> in a
>>>> project.  We are using a ColdFire 5485,
>> Freescale
>>>> 2.6.10 distribution.  I2C is working and the
>>> i2c-tools
>>>> i2cset, i2cdump, and i2cdetect are compiled in
>> to
>>> the
>>>> kernel.  Is this chip supported already?  If
>> not,
>>> I
>>>> will be writing a driver, to be included
>>>> with the lm_sensors package.  I have spent the
>>> last
>>>> few days reading the documentation, which is
>> good,
>>> but
>>>> will most likely need your help!!!
>>>>
>>>> Cheers!
>>>> Tom
>>>>
>>>>
>> __________________________________________________
>>>> Do You Yahoo!?
>>>> Tired of spam?  Yahoo! Mail has the best spam
>>> protection around 
>>>> http://mail.yahoo.com 
>>>>
>>>> _______________________________________________
>>>> lm-sensors mailing list
>>>> lm-sensors at lm-sensors.org
>>>>
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>>
>> __________________________________________________
>> Do You Yahoo!?
>> Tired of spam?  Yahoo! Mail has the best spam
>> protection around 
>> http://mail.yahoo.com 
>>
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

