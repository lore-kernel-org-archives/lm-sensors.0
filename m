From: "Ivo Manca" <pinkel@gmail.com>
Date: Wed, 28 Mar 2007 12:07:18 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <012b01c77131$a316dff0$0901a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Ed,

> Very sorry - my fault! They were on the download page, but hidden. Fixed. 
> Here are direct links:
> http://sensors4mobo.eberian.com/files/sensors4mobo-client_0.7.tar.gz
> http://sensors4mobo.eberian.com/files/sensors4mobo-server_0.4.tar.gz

Ok, I'll look into them and discuss them with my project members tomorrow.

> Quite So! Apart from the overlay, sensors4mobo should be redundant once 
> your project is finished.
Ok.

> No, you are right, but the lookup utility allows for an alternative web 
> site or a  local folder to be specified (A basic sensors.conf parser was 
> written for both server php and and client python scripts)

That's true. Anyway, when our website is finnished, we will also distribute 
the source of it, so anyone is free to set up their own copy. Since the 
local cache can be easily overwritten by a custom one, I don't think this 
should be a problem. We might also make an optional "location" parameter to 
the sensors-detect script, when the user wants to update.

> Reading through your email thread with Jean, your spec looks more full 
> featured.
>
> Good point about the privacy. Paranoid users could always create their own 
> mirror or campaign for an https interface.
>

> Really, all I am after is an exchange/dump format so that users can mine 
> the database easily without having to learn or install a load of new 
> tools. Embedding the data in the file achieves this.
>
> I looked at sqlite when developing sensors4mobo but many ISPs do not 
> include it and I did not want to add any dependencies that would limit 
> usage or make installation harder.

Hm, let me eleborate a bit.
The user will have a local cache, which is a SQLite database. This can not 
be easily viewed, I agree with that. When a match is found, it will be 
extracted, so the user can make modifications to his/her config.

We are thinking about making the host a website with a MySQL backend. This 
should be easy to realise (since mosts hosts come with it anyway). When the 
config is downloaded, a sqlite file will be extracted from the mysql 
database. How to do this, is not yet defined, but should not be much of a 
trouble. We'll have to look into it.

The website should also allow the users to browse through the available 
config files. This way, the user can easily see how other configs works, if 
he wants to.

It is true that sqlite needs to be installed on the client's pc in order to 
make it run, adding an extra dependency. However, we don't see this is a big 
drawback, since most distributions come with it anyway. As far as I can see 
on my machine:

        libsqlite3.so.0 is needed by (installed) rpm-libs-4.4.2-32.i386
        libsqlite3.so.0 is needed by (installed) rpm-4.4.2-32.i386
        libsqlite3.so.0 is needed by (installed) 
python-sqlite-1.1.7-1.2.1.i386
        libsqlite3.so.0 is needed by (installed) 
yum-metadata-parser-1.0.3-1.fc6.i386
        libsqlite3.so.0 is needed by (installed) apr-util-1.2.8-1.fc6.i386
        sqlite is needed by (installed) mono-data-sqlite-1.1.17.1-4.fc6.i386
        sqlite >= 3.3.1 is needed by (installed) beagle-0.2.13-1.fc6.i386

So it seems like both rpm and yum already use it, which covers most 
distributions, doesn't it?

> Good idea.

>> We were thinking about using the following:
>> system-manufacturer
>> system-product-name
>> system-version
>> system-serial-number
>> baseboard-manufacturer
>> baseboard-product-name
>> baseboard-version
>>
>> It seems like these 6 fields covers all motherboards. Sending/storing the 
>> serial number might also be a privacy issue.

> Good point.
>
> Do you require an exact match on all 7 parameters or do you cherry-pick 
> the minimum that identify a motherboard?

Oops, system-serial-number didn't need to be in that list, making it 6 
fields instead of 7. I was just copy/pasting ;)
Anyway, we do need all the 6 to match. It might be true that some fields 
contain bogus "To-be-filled-in", but if others don't, the combination still 
makes it unique. Stripping it might save some disk space for the database, 
but might also give some complications.
Motherboard manufacturers just seem to randomly fill in either the "system" 
or "baseboard" fields, and sometimes both..

> Yes, my hope is that our 'ways' will converge and that sensors-detect will 
> have a sizeable library for when it gets released.

I hope so too. We won't be able to add a lot more than 5 different 
configurations ourselves, I think, but let's hope people will volenteer soon 
;)

> Agreed! I look forward to the outcome, and hope people will start emailing 
> in their sensors.conf + dmidecode data.

Let's hope so!

Kind regards,

Ivo 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
