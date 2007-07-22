From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 22 Jul 2007 09:27:55 +0000
Subject: Re: [lm-sensors] Fujitsu-Siemens Scylla (fscscy)
Message-Id: <46A3231B.1020506@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46933578.3010701@miloi.de>
In-Reply-To: <46933578.3010701@miloi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Titus,
> 
> On Tue, 10 Jul 2007 09:30:00 +0200, Titus wrote:
>> I'm new to this mailing list and I have some questions to the fscscy 
>> module. I have searchted the archives and this subject does not seem to 
>> have been posted already, so I hope I don't bother you with issues 
>> already discussed.
>>
>> - I did not manage to load the fscscy kernel module into kernel 2.6.18 
>> (Debian Etch) and 2.6.21 (current kernel from kernel.org). Although all 
>> seems to be compiled correctly, this kernel module was not built. Is 
>> there any way to fix that?
> 
> The fscscy driver was not ported to Linux 2.6 yet. There was a first
> request one year and a half ago:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-February/015319.html
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015489.html
> 
> Nobody volunteered yet to do the work. I've added your request on our
> wiki/Devices page, but don't hold your breath. The FSC Scylla is an old
> and rare chip, it's unlikely that anyone will volunteer to port it for
> free.
> 

Well actually, I would like to volunteer, as it fits within my current fscher / 
fscpos driver activities. I've done some checking and the fscscy is very much 
like the fscher / fscpos, and it has the tempX_limit registers right were my 
reverse engineering found them in the fscher :) As always if anyone has a 
datasheet for the fscscy, that would be very welcome.

With the possibility to add fscscy support to the driver and with my wish to 
rip out the watchdog support (for now, I might redo it with the official kernel 
api later, esp. if there are requests for it) + the possibility for many other 
cleanups, I'm starting to think that it would be (much) easier to add a new 
fscxxx driver to the kernel, based on my current fscher work, with added fscscy 
support and cleanups.

Jean & Mark, were do you stand with regards to this., I see 2 options:

1) * Many smaller patches with incremental improvements to the fscher
    * essentially making it an fscxxx driver
    * with the current pseudo watchdog support left in for compatibility
    * with other uglies like raw export of status registers left in for
      compatibility, while also exporting the exact same info with _alarm and
      _fault files

2) A new fscxxx driver tackling all the issues at once, based on my current
    fscher work, with some major cleanup and added fscscy support

As I type this, and also remind myself that the current driver has to keep 
carying the tempX_status ugliness, my vote strongly goes to the new driver 
approach. Then we can mark the fscpos and fscher drivers as obsolete for a 
while and remove them eventually.

Titus, would you be willing to test fscscy support for us?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
