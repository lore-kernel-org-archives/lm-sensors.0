From: Philip Edelbrock <phil_edelbrock@edgedesign.us>
Date: Tue, 21 Aug 2007 17:20:37 +0000
Subject: Re: [lm-sensors] lm-sensors history
Message-Id: <161C669C-A843-42EA-B453-EC6B9EB9130F@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <46C9D1B6.3080906@ensmp.fr>
In-Reply-To: <46C9D1B6.3080906@ensmp.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Thanks for the summary Jean, some additions below.

On Aug 20, 2007, at 11:15 AM, Jean Delvare wrote:

> Bonjour Nordine,
>
> On Mon, 20 Aug 2007 19:39:02 +0200, Nordine Benkeltoum wrote:
>> I'm carrying out a study on Open Source Software.
>>
>> I have a question about lm-sensors:
>>
>> Could you tell me who is at the origin of lm-sensors? Is it a firm  
>> or a
>> non-profit community of volunteers?
>>
>> Thank you for your answer.
>
> To the best of my knowledge, the lm-sensors project was originally
> created by Alexander Larsson, Frodo Looijaard and Philip Edelbrock, as
> can be seen in the README file of lm-sensors 1.3.0:
>
> http://dl.lm-sensors.org/lm-sensors/releases/lm_sensors-1.3.0.tgz
>
> The former two were already gone by the time I joined the project,  
> so I
> can't speak for them. Philip is still around (which, now that I  
> come to
> think of it, is quite impressive) so hopefully he can tell you.

Thanks! :')  Although in recent years my participation has been  
limited to doing releases (packaging up the files, signing them, and  
other related chores).  I loosely follow the list  to address  
requests (like this one) which I can help with.

Back in the beginning I just graduated from college with computer  
science and computer engineering degrees.  I had a lot of time and  
energy, not a lot of responsibilities, so it was natural to find an  
interesting outlet.

>
> My understanding is that they were hobbyists working together on the
> project for fun, and there was no company behind it. As you can see,
> the project is quite old, it started in 1998, and I don't think that
> there were many free software projects funded by companies back then.
> This however doesn't mean that the authors weren't using lm-sensors as
> part of their jobs.

If I remember correctly, I emailed the LKML asking if there was  
anyone working on support for the LM78 and LM75 (btw- these two LM  
chips were pretty much the only server sensor chips around at the  
time, so hence we named the project 'lm-sensors').  The answer was  
'no' but that Frodo was willing to partner up with me to start some  
support.  It was mostly out of wanting to have some fun playing with  
the sensor chips and using the drivers we developed to monitor  
servers under our care.

The lm78 was the first driver which we leveraged a lot of good work  
done by Alex.  The LM75 was on an I2C bus, so we had to write a  
driver for the piix4 to access it.  That got our feet wet with I2C  
driver development.

The next big jump was when Frodo took Simon Vogl's modular I2C stack  
and wrote it into lm-sensors.  There was a lot of amazing work done  
by Frodo to do that, and he solved/fixed a lot of issues with Vogl's  
stack (which was already amazing).  Simon was happy to let us take  
over the maintenance for his stack, and it eventually became standard  
in the Linux kernel its self.

Over time the list of drivers grew, more contributors joined on, I  
had less time.  With a fulltime job and more responsibility (and less  
energy), I stepped back and let more talented people with the time  
and energy take over.  I enjoy seeing the project grow and be  
maintained by some very talented and smart people (like Jean and many  
others).

>
> Oh, and I should also add that Philip's company, Netroedge, has been
> hosting our web server and CVS repository for 7 years or so. Not sure
> if this qualifies as a sponsorship but this was sure nice from them :)
> The list of donations we received also mentions the name of the other
> companies which have been helping us:
>
> http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/donations

Yes, I've been very grateful to Edge Design of Oregon (aka  
netroedge.com, and edgedesign.us) for donating some server space,  
related administration, and some company time to work on Lm-sensors  
over the years.  They even threw a small celebration when lm-sensors  
was formally integrated into the mainstream Linux kernel.  The  
company has moved to using OSS almost exclusively for software  
development (mostly web sites with moderately complex backends).


Phil

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
