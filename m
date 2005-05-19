From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <4022B23E.9050506@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>I can't speak for Scylla, as I don't own it's specs.
> 
> Oh, OK. Ignore my question in the other mail then, please.

Well, I could ask my contact person at FSC, but he is on vaccation till mid of 
February. Would you like a copy of the Poseidon spec too?

>>>I don't quite agree with you. They documented the limitation, this
>>>sounds like a piece of advice to driver programers.
>>
>>I don't think so. SystemGuard doesn't even give a warning, when one
>>allows the fans to turn off.
> 
> OK, as you feel then. After all, you're the first user of your driver,
> so I can assume you know what you're doing.

The BIOS sets reasonable values and the default sensors.conf doesn't override 
them. Maybe a "WARNING: read documentation or you may damage your system!" 
might be useful to add to the configuration file, heading the supplied sample 
settings.

>>>>This means renaming the procfs files to pwm, doesn't it?
>>
>>Nonsense! procfs has all information in one file, so there is nothing
>>to rename.
> 
> No. All information *was* in one file. pwm should now be moved to a
> separate file, with a single value.

Now, I've got the point :-))

>>>>I don't think, that it would be good idea to rename every fan_min to
>>>>pwm, as there would then no longer be a relationship to the
>>>>documenation.
>>>
>>>Well, in this case, rewrite the documentation as well. Doesn't sound
>>
>>I ment the specification from FSC. But you are right: I still have to
>>update the documentation for sysfs.
> 
> Ideally, you should first update the doc file as found in our package,
> then submit a modified version (with sysfs information instead of
> procfs) for inclusion into Linux 2.6. I think these have to be two
> different files (although with a common part) since they document two
> different versions of the driver that live in different places.

Ok.

>>If I got anything wrong, please point me to the locations, where I
>>need to make changes.
> 
> All you have to do is split pwm into a different file in the 2.4 driver,
> and update the rest of the driver accordingly. This will require changes
> to be made to libsensors, and possibly sensors too, and I'll do them.
> 
> This may sound like much work for nothing, and I agree we could do
> without it. But since we're at cleaning the driver, let's do it
> completely.

I don't mind to work on this. It was just not clear to me, what I should 
change in 2.4.x. But now it is :-)

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
