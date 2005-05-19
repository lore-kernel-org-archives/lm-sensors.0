From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: Eeprom driver optimization
Message-Id: <3F426F77.5040304@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030816141351.76899190.khali@linux-fr.org>
In-Reply-To: <20030816141351.76899190.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The refresh time is 5 minutes now.

As I've said before, I consider the eeprom driver a "demonstration" rather than
something with a whole lot of value.

Therefore I don't feel that inefficiency is a big concern.
But if there's some generic method to reduce the number of accesses
that could be added, that may be interesting.

I'm not in favor of more Vaio- or EDID-specific stuff
("subsets") in eeprom.c.

mds





Philip Pokorny wrote:
> I would suggest that the chance of eeprom contents changing during 
> normal running is *very* small.
> 
> Therefore, you could set the refresh time to be *very* long by default 
> (and make it configurable if the VAIO BIOS is changing the eeprom 
> underneath us. Gosh I hope not...)  Say 10 minutes or more.  Then read 
> the contents once, and cache the results.
> 
> An alternative would be to just divide the eeprom into 16-byte subsets 
> and assign a refresh timer to each.  This matches the /proc organization 
> pretty well. (16 bytes per file)
> 
> But since sysfs is coming soon and Greg KH's proposal is a single binary 
> file for eeprom's, I think my first suggestion is better for the future...
> 
> :v)
> 
> Jean Delvare wrote:
> 
>> Hi all,
>>
>> As I was working on the eeprom driver, one thing came to my mind. If
>> should be possible to significantly speed the eeprom module up. As it is
>> now, requesting one single byte from the eeprom cause the whole eeprom
>> (256 bytes) to be read. Of course, we don't want to refresh bytes
>> one-by-one, it would be too complex. But maybe we could define subsets
>> of bytes that should be refreshed at once. In a way, this joins a
>> previous discussion about driver design
>> (http://archives.andrew.net.au/lm-sensors/msg03657.html). Philip Pokorny
>> already did something similar in the adm1026 driver, introducing a
>> second refresh frequency for limits, as opposed to measured values.
>> Still there is a single update function in the adm1026 driver, and this
>> too could be discussed. And a general discussion about these policies
>> would be welcome for sensor drivers.
>>
>> But let's stick to the eeprom module for now (my train leaves in less
>> than 3 hours now so I'm a bit short in time).
>>
>> When sensors is called for regular memory eeproms, the rows that will be
>> accessed (to return the memory type and the memory size) are 1 and 2
>> (counting rows from 1 to 16). When called for a Sony Vaio EEPROM, it
>> will read rows 9, 13 and 14. For an EDID it will read rows 1 and 9 (but
>> this could be changed to row 1 only). Likewise, running the
>> decode-eeprom, decode-vaio and decode-edid scripts will only access
>> subsets of the eeprom. At the very least, I believe we should divide the
>> eeprom in two subsets: rows 1-2 and rows 3-16. That would make sensors
>> far faster on memory eeproms. Additionally, I think I remember these
>> eeproms are usually 64-byte or 128-byte long (EDIDs are), only the
>> Vaio's are 256-byte long. So we could define 4 subsets instead: rows
>> 1-2, rows 3-4, rows 5-8 and rows 9-16. I believe that this would speed
>> up sensors and scripts much. This would require to add separated refresh
>> timers, but I think it's worth it.
>>
>> I don't know if it's worth it defining more complex subsets. For example
>> we could define a subset for the 5 bytes used by sensors for memory
>> eeproms. This would make things even faster, but OTOH too many subsets
>> will be difficult to optimize, especially if more and more eeprom types
>> appear (I think I remember see many unknown eeproms in user reports
>> these last months).
>>
>> I'll try this while in the train, but I still would like to hear
>> opinions about this.
>>
>>
> 
> 
