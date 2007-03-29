From: "Ivo Manca" <pinkel@gmail.com>
Date: Thu, 29 Mar 2007 13:20:53 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <003c01c77205$169cb480$0901a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Ed,

First of all, let me give you a quick update.

This morning, we had a meeting with our project supervisor (Hans de Goede) 
and discussed the pro's and con's about using SQLite versus plain text 
files. We've decided to go for the latter, your option. The fact that you've 
already written a parser is a big advantage too.

Anyway, we decided to split the project in three parts for now:

* the sensors-detect program (Ivo Manca)
- Reads dmidecoded and finds a match. Also ability to update local cache.

* the website (Jasper Alias)
- Ability for users to submit their configs, look through configs and 
vote/rank/moderate  them.

* submission of configs (Gijs van der Weg)
- Manual versus automatic? Best for users? Best for maintance?

This way we can all work on the project without slowing eachother down.
I'll mainly focus on the sensors-detect script itself.

Mainly, it means that we will have to modify sensors-detect to:
* add support the looking up of the neccesary dmidecode strings (Done: 
copied a piece of code that Jean submitted a while ago)
* add support for command line parameters (Probing? Dmi? Help? Verbose?)
* add support for finding a match in the files
* applying this config and modprobing, using the functions already available 
in sensors-detect

I think I'll be able to use quite a lot of your code, I'll just need to 
parse it to perl and modify some things ;)

One thing I noticed, looking through your code, was the fact that your 
script is capable of finding multipe matches. I wonder whether or not this 
is something we want to have there?
Giving a random, unique DMI string, there should only be one possible 
configuration, unless the dmistrings are bogus.

It is possible that users want to improve the config, but then he or she 
should just modify the existing and upload it, isn't it?
So I don't really see a point of supporting more matches. Maybe I'm 
overlooking something.

> I have cobbled together new versions of the sensors4mobo tools that only 
> use those six parameters. The web server now does a very basic check for 
> six parameters and the table marks the broken ones (loads more work & 
> sanity checking to be done here). One valid file so far, and I will see 
> about updating the rest when I have the time.

> I have also added a "tags" field in which you can add a fixed set of tags 
> to describe the file: so far I have thought of "broken", "experimental" 
> and "beta". Perhaps this goes some way towards emulating your "unsure" 
> database flag, Ivo? I went for the name "tags" rather than "status" so 
> that other info could be added with minimal api changes. This is more for 
> my sensors overlay work, so feel free to disregard it if it doesn't fit 
> your goals.

Sounds good. Maybe add a final as well?

> Can anyone point me towards a description of the "dynamic chips support" 
> for libsensors that Jean mentioned. (Sorry, my googling failed on this).
>
> For motherboard specific sensors.conf files, would it make sense to use 
> the same fan labels that are used in the manual and on the motherboard 
> itself? (What is the offical naming policy? - grepping  sensors.conf shows 
> a range of names)

I've seen it being mentioned various times, but I don't think I can help you 
out with it.

Ivo 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
