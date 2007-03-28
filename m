From: "Ivo Manca" <pinkel@gmail.com>
Date: Wed, 28 Mar 2007 10:56:35 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <010801c77127$c2390b10$0901a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Ed,

I can't seem to find a way to download your software from the site. Is there 
simply no link, or am I just too tired to see it? :)

> Hmm, playing devils advocate here, I don't know if the projects have quite 
> the same goals. If not, it might be just as desirable to find areas of 
> compatibility.
>
> Ah, I have just found Ivo's thread started on the 22nd February, and read 
> the Project Plan (hence the delay in replying - sorry!) . That makes 
> things much clearer. The projects are very similar, but I *think* 
> sensors4mobo is unique in aiming to add local data overlays?

Nah, not trying to play the devil's advocate, just saying what I think is 
the easiest for the users ;). If all can be up-and-running by just using the 
lm-sensors package, why install anything else?

About the overlay: I think it is indeed something completely different than 
our project, so I think I can't say anything about that, sorry.

> I see from your plan that your Secondary Goal is to build a database of 
> sensors.conf files (with a web interface), but that hosting and 
> maintenance are outside your scope. If you don't already have this sorted 
> through lm-sensors.org, I would be happy to offer ongoing hosting and 
> maintenance, and can give you access rights on sensors4mobo.eberian.com.

We haven't had contact about whether or not this project can be hosted on 
lm-senors.org, yet. Imho, I prefer having everything on a same place, so if 
we can actually host it on lm-sensors.org, I will go for that. If not, 
having a link on lm-sensors.org, and hosting it somewhere else, is also 
good. The reason we haven't asked about hosting yet, is mainly because we're 
not sure in what language we want to script the website, but I think it will 
be PHP. Jasper and Gijs (the other two project members) are looking into 
that right now.

Anyway, thanks a lot for the offer!

> Would you be interested in using the sensors4mobo sensors.conf annotation 
> (or a derivative) to add dmidecode and modprobe data to the files?

Actually, I do not really care about how the sensors.conf is interpreted. I 
just looked at yours, and having the modprobes in it seems like a good idea 
to me. However, I am everything but an expert in this field, so again, I 
think i can't be of much help.

Our project only aims at the detection, and that's it. We've already set up 
a (sample) database layout, which will have three tables. One table with the 
dmi-strings, configuration file and a flag whether it's working, not working 
or untested, one table with all the available modules, and one table that 
links the modules to the configuration and can add parameters to it.

This way, it doesn't really matter what kind of configuration will be stored 
within it, as long as they're compatible.

> And/or would you be interested in using the web api (or a derivative) as 
> an interface to the library?

The web API itself seems to look quite okay, however, I don't agree with one 
thing:

As I understand it, when the user wants to find a match, he/she sends the 
dmi-strings to the website, which might give some privacy issues (tbh: I 
don't care myself ;p). And, the most important thing: when the client's 
internetconnection is down, or when the website is down, it can't be used 
anymore. Correct me if I'm wrong.

> http://sensors4mobo.eberian.com/docs/sensors_conf
>
>    I think it is best to embed information in the sensors.conf rather than 
> to use a database. It is backward compatible, and makes each configuration 
> a tidy unit - much easier to copy/duplicate/update than a database. I know 
> it is slower and more limited than a db in terms of querying, but I have 
> just run a test and sensors4mobo.php parsed 1000 files in under 0.8 
> seconds on a 1.3Ghz Sempron. We probably don't need to optimise just yet? 
> I think it is also easier this way if users want to create their own 
> mirror sites with customised/experimental sensors.conf files.

Having a database is also backwards compatible ;). The user can still 
decided whether or not to use the dmi-comparison and everything but the 
sensors-detect is left untouched.
About making it less easy to copy/duplicate/update using plaintext files: 
normally I would agree, however, we are are planning on using SQLite as 
backend. This way, the database will be a single file, and easily 
distrubuted.

http://www.sqlite.org/

Having a flag "unsure" (or something similar) to the configuration, makes it 
possible for users to upload their expirimental sensors.conf files.

>
> http://sensors4mobo.eberian.com/lookup/
>
>    In addition to the query engine itself, this page also has notes on how 
> the REST-ish interface works. It currently takes the 17 tags specified by 
> dmidecode --strings, but of course it could be restricted to the subset 
> your research has focused on.

We were thinking about using the following:
system-manufacturer
system-product-name
system-version
system-serial-number
baseboard-manufacturer
baseboard-product-name
baseboard-version

It seems like these 6 fields covers all motherboards. Sending/storing the 
serial number might also be a privacy issue.

>
> Irrespective of technical factors, and beyond the scope of your project, 
> the broader campaign will stand or fail on whether it can get a critical 
> mass of sensor.conf files. The sooner we can start the ball rolling on 
> this, the better, and the more data-points you will be able to test 
> against. The sensors4mobo scripts (or derivatives!) could provide a way 
> for current users to get involved before your code gets integrated and 
> released.

I totally agree with that. I think the ball gets to roll quicker if it's 
intergrated though ;).
Anyway, I do encourage everyone to use your sensors4mobo scripts and give us 
as much feedback as possible. That way, we can make a best effort as 
possible.

Oh, and if (in the end) we decide to do it my way, the configs aren't 
uploaded for nothing either! I think it's quite easy to convert them into 
our database ;)

> I appreciate that you are doing this as a university project, and I don't 
> want to undermine, impinge, or force an unwanted direction on your work, 
> but I am keen to assist if there is a way to integrate into the bigger 
> picture.

I don't feel undermined or anything, don't worry ;). However, at the moment, 
I think our solution is more deserible.

I don't want to make you feel like you wasted your time on this though or 
like I'm discarding all the work you did as rubbish. I'm just trying to 
share my vision, and hey, I'm not the one in charge ;)
Feel free to fill me in or share your opinion,

Ivo 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
