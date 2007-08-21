From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 21 Aug 2007 12:53:31 +0000
Subject: Re: [lm-sensors] Submitting motherboard-specific support?
Message-Id: <46CAE04B.9010107@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Axel Thimm wrote:
> On Tue, Aug 21, 2007 at 10:45:10AM +0200, Jean Delvare wrote:
>>> I do have a friend who is a php guru who is willing to write a php driven site 
>>> for us if we can provide him with proper specs.
>>>
>>> I can start writing a spec for the website as time permits, then discuss it 
>>> here, and once approved ask him to write it (under an OSS license of course).
>> Writing it is one thing, hosting it is another. Axel, maybe I already
>> asked, can't remember: can we host a PHP app on lm-sensors.org?
> 
> Sure, as long as someone manages the app and any involved security
> issues. PHP is rather tricky and needs good care security-wise.
> 

I know, and I know that friend well (for 15 years now) and I believe he will 
stick around to maintain it, but as discussed below, maybe it would be better 
(and a whole lot quicker to get setup / started) to start with using the wiki 
for now. If that turns out to not scale we can always switch.

>>> Another option would be to stay with the wiki, add some special
>>> markup comments for the dmi strings and write a script to generate
>>> a tarbal / "database" for the dmi based detect code. For me
>>> putting the info in the wiki works well, its not like we are
>>> getting multiple motherboard configs per day, and the wiki keeps
>>> history which can be benifitial (a sufficiently advanced website
>>> could do this too).
>> I'd prefer a dedicated interface where anyone can contribute its
>> configuration. The target configuration count is in hundreds if not
>> thousands, that's not something we want to handle manually.
>>
>> That being said, if someone _else_ is going to take care, it doesn't
>> matter that much to me ;) The usual open development rule applies:
>> whoever does the job decides how it should be done. I simply haven't
>> looked enough into it all yet, for now I'm focusing on getting
>> libsensors4 ready so that we can release it before the end of the
>> year.
> 
> I would also tend to recommend a wiki. The stumbing block is the spam
> issue, and I think if we write a simple mailman like registration
> module (for example in PHP :) we could have people register once and
> then use wiki/trac/tickets/svn etc. as you like (not as flat as it
> sounds, but with some lm-sensors heads elevating permissions as
> needed, e.g. self-registration allows wiki/ticket editing, and svn
> write access needs a bit flip by an lm-sensors leader etc)
> 
> Hans, maybe your PHP friend expert (is that Romain copied in the Cc?)
> would be interested in this general purpose registration module
> stealing some methods from mailman?
> 

As Romain already answered he is not the one I'm talking about. I'll ask him if 
he doesn't mind his mail address getting used on mailing lists and then put him 
in the CC.

Let me check if I understand you correctly, you want to have a registration 
module, for users to register themselves as trac user, which has some spam bot 
prevention methods, like sending a confirmation mail and maybe also such a 
picture with bad readable text? (which has a name I know, but not right now :)

But wouldn't it be better to write such a thing in python and submit it for 
upstream trac inclusion? Has anyone already searched the web to see if such a 
thing exists?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
