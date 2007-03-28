From: Ed Lucas <ejl@eberian.com>
Date: Wed, 28 Mar 2007 11:49:27 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <460A5647.6030800@eberian.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Ivo Manca wrote:
> I can't seem to find a way to download your software from the site. Is 
> there simply no link, or am I just too tired to see it? :)
Very sorry - my fault! They were on the download page, but hidden. 
Fixed. Here are direct links:
http://sensors4mobo.eberian.com/files/sensors4mobo-client_0.7.tar.gz
http://sensors4mobo.eberian.com/files/sensors4mobo-server_0.4.tar.gz

> If all can be up-and-running by just using the lm-sensors package, why 
> install anything else?
Quite So! Apart from the overlay, sensors4mobo should be redundant once 
your project is finished.

> The web API itself seems to look quite okay, however, I don't agree 
> with one thing:
>
> As I understand it, when the user wants to find a match, he/she sends 
> the dmi-strings to the website, which might give some privacy issues 
> (tbh: I don't care myself ;p). And, the most important thing: when the 
> client's internetconnection is down, or when the website is down, it 
> can't be used anymore. Correct me if I'm wrong.
No, you are right, but the lookup utility allows for an alternative web 
site or a  local folder to be specified (A basic sensors.conf parser was 
written for both server php and and client python scripts)

Reading through your email thread with Jean, your spec looks more full 
featured.

Good point about the privacy. Paranoid users could always create their 
own mirror or campaign for an https interface.

> Having a database is also backwards compatible ;). The user can still 
> decided whether or not to use the dmi-comparison and everything but 
> the sensors-detect is left untouched.
> About making it less easy to copy/duplicate/update using plaintext 
> files: normally I would agree, however, we are are planning on using 
> SQLite as backend. This way, the database will be a single file, and 
> easily distrubuted.
Really, all I am after is an exchange/dump format so that users can mine 
the database easily without having to learn or install a load of new 
tools. Embedding the data in the file achieves this.

I looked at sqlite when developing sensors4mobo but many ISPs do not 
include it and I did not want to add any dependencies that would limit 
usage or make installation harder.


> Having a flag "unsure" (or something similar) to the configuration, 
> makes it possible for users to upload their expirimental sensors.conf 
> files.
Good idea.

> We were thinking about using the following:
> system-manufacturer
> system-product-name
> system-version
> system-serial-number
> baseboard-manufacturer
> baseboard-product-name
> baseboard-version
>
> It seems like these 6 fields covers all motherboards. Sending/storing 
> the serial number might also be a privacy issue.
Good point.

Do you require an exact match on all 7 parameters or do you cherry-pick 
the minimum that identify a motherboard?

> I totally agree with that. I think the ball gets to roll quicker if 
> it's intergrated though ;).
> Anyway, I do encourage everyone to use your sensors4mobo scripts and 
> give us as much feedback as possible. That way, we can make a best 
> effort as possible.
>
> Oh, and if (in the end) we decide to do it my way, the configs aren't 
> uploaded for nothing either! I think it's quite easy to convert them 
> into our database ;)
Yes, my hope is that our 'ways' will converge and that sensors-detect 
will have a sizeable library for when it gets released.

> I don't feel undermined or anything, don't worry ;). However, at the 
> moment, I think our solution is more deserible.
Agreed! I look forward to the outcome, and hope people will start 
emailing in their sensors.conf + dmidecode data.

Best regards,
    Ed


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
