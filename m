From: burkart.lingner@gmx.de (Burkart Lingner)
Date: Thu, 16 Jun 2005 16:07:44 +0000
Subject: [lm-sensors] Added sysfs support for decode-dimms.pl
Message-Id: <000301c5727c$ad6425e0$4d01a8c0@BURKART>
List-Id: <lm-sensors.vger.kernel.org>
References: <000201c571f9$ac2fb410$4d01a8c0@BURKART>
In-Reply-To: <000201c571f9$ac2fb410$4d01a8c0@BURKART>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, Jean!

> On 2005-06-15, Burkart Lingner:
> > I needed to take a closer look at my RAM's SPD-EEPROMs today. Too bad
> > the sysfs of Kernel 2.6 wasn't supported by decode-dimms.pl, so I had
> > to add support for that myself. [...]
>
> I just took a look at your script. It's not bad but I would like the
> sysfs support to be added in a cleaner manner if possible. Rather than
> having a if(sysfs) test on each read, we could have a single function
> returning the wanted bytes, and all the checks would be in there. The
> advantage is that it would avoid code duplication, would make the code
> easier to read, and would allow for yet others access methods to be
> added more easily in the future (e.g. reading from a dump file). Could
> you try to modify your script to do that? You're probably not that far.
> You may check how I did this in decode-vaio.pl, although you should be
> able to do something more simple.

Very good idea, thanks for the hint. For my excuse I have to say that my 
previous modification was just a quick'n'dirty one to get me access to the 
SPD data I needed. Yet I understand that for a release, the code should be 
nicer and so I'll implement it somewhat in the way you suggested.

> Other comments on the code itself:
>
> 1* Your sysfs version doesn't print the guessed bank number anymore?

Honestly I was just too lazy to decode the regular expression in the first 
place. Also I don't know the naming conventions for the EEPROMs on a Kernel 
2.4 system. Could you fill me in on the details about that? That would help 
me a lot on adapting this code fragment to the sysfs.

> 2* Your sysfs version reads the whole EEPROM contents while only the
> lower half is used. This will make the script twice as slow, so it
> should be avoided if possible. Maybe the read method I implemented in
> decode-vaio.pl may help (or use head -c, but I'm not sure it's
> portable).

You're right and this could of course be done better using binary file 
access via read(). On the other hand it sure wouldn't hurt too much to read 
128 bytes in vain. However I do suppose that in implementing a sub routine 
for reading the EEPROM I'd switch to read() and thereby to reading only the 
necessary 128 bytes.

> So it would be great if you could work on this. If you come up with a new
> version, I'll test it on my systems (both 2.4 and 2.6 kernels).

Sure. Actually I'm quite honored to work on an open source project. Never 
done that before.

Please give me a couple of days, though. There's a couple of other things I 
ought to work out right now, so it might not be before the weekend until I 
apply the abovementioned changes.

> Last point, when submitting changes, the best method is to provide the
> output of diff -u between the original and modified file. This is way
> easier than looking at "ADDED" and "MODIFIED" tags, and can be
> applied to CVS directly.

Alright, thanks.

Bye, Burkart 

