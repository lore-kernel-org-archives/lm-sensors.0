From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 22 Jul 2007 18:03:36 +0000
Subject: Re: [lm-sensors] Proposal: remove watchdog support from fscher and
Message-Id: <46A39BF8.10409@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <469F83FA.1020409@hhs.nl>
In-Reply-To: <469F83FA.1020409@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Thu, 19 Jul 2007 17:32:10 +0200, Hans de Goede wrote:
>> As you all know I've been working lately on moving the fscher driver to 
>> individual alarm files and on merging the fscpos driver into the fscher driver.
>>
>> While typing a reply to Jean's review of the fscpos support for the fscher 
>> driver, I came to the conclusion that it might be best to remove the watchdog 
>> supporting sysfs attr from these 2 drivers, These sysfs attr are nothing more 
>> then a raw export of the watchdog registers. If people want raw access they can 
>> and should use i2c-dev. Thus I think it would best to just remove the watchdog 
>> sysfs attr, reducing the driver size and complexity.
> 
> (Repeating what I wrote in another thread, as this new thread is a
> better place:)
> 

Yes, I saw your reply there too, but this whole discussion has got kinda 
obsoleted by the fscscy driver also getting into the picture.

> I agree that the current watchdog implementation is poor, but you can't
> rip it away right now without offering a replacement. Either deprecate
> it and plan it for removal at a later point in time, or replace it with
> a proper implementation (or both.)
> 

I understand that compatibility is important. Since with some bad sysfs api 
decisions were made in the whole fscxxx series, my plan is now to do a new 
driver called fscxxx without any of the baggage, and once that is reviewed an 
in the kernel mark the entire fscher and fscpos driver as obsolete.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
