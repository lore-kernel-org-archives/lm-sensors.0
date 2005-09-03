From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 03 Sep 2005 21:21:12 +0000
Subject: [lm-sensors] Motherboard data collection
Message-Id: <20050903212101.48c95a71.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200505190141.07306.holger.oehm@holger-oehm.de>
In-Reply-To: <200505190141.07306.holger.oehm@holger-oehm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Holger,

Please forgive me for the delay (hum hum...)

> Well, I invested some energy and time, and here is a URL:
> 
> http://sites.inka.de/penti/cgi-bin/lmsensor.pl

As someone asked to me today if such a system existed and it took me 15
minutes to find the URL back, I have been adding a section for
motherboard configuration file databases in our "useful addresses"
document.

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/useful_addresses.html#sensorsconfdb

> It is still a prototype and regrettably uploading sensor.confs does
> not work on that webserver. (It did work at home, I suspect that the
> CGI.pm and/or perl are too old on that machine).

I just tried and actually it failed. I was able to create an entry for
my motherboard maker, my motherboard model, but the configuration file
upload failed. This definitely needs fixing (or at least a workaround),
else this database is useless. Can't you upgrade CGI.pm or perl or fix
whatever is causing the problem?

You could easily do without the upload, BTW. Just add a large text area
on the page, and let the user copy/paste in it. It might be less
convenient than upload, but better than a non-working upload.

> The stuff is just one perl script using CGI.pm and a C executable I
> compiled with some internals of the latest sensors lib (I wanted to
> make sure configs are valid when I store them).

It's probably overkill to use C and stuff from libsensors to do this. I
understand that some check of the file is needed so as to make sure that
people don't upload crap, but that should be very easy to do something
simple in perl.

> It stores uploaded files striped down (only valid tags, no comments)
> and compressed.

Stripping the comments is a very bad idea if you want my opinion.
Comments in sensors.conf files are very useful, you are removing most of
the added value if you remove them. Take a look at the configuration
file I published for my motherboard:

http://khali.linux-fr.org/devel/lm-sensors/sensors-Gigabyte-K8V-Ultra-939.conf

You'll see it has pretty useful comments. Strip them down, and the file
is not even worth being left online. Also, even with all the comments,
not compressed, the file is less than 4 kB in size. I wouldn't expect
such a database to grow larger than 2000 files (and I am being very
optimistic), this would be around 8 MB of data. By today's standards it
is not much, and at any rate not enough to justify stripping, and
possibly not even compression.

> I am thinking about how to add the possibility to sign configurations
> (like someone who uses one of the configs and it works for him, he
> could sign it somehow (pgp?)).

Overkill IMHO. All we need is a place where people can upload
configurations and others can download them. We don't need this to be
official or anything.

> Could you spare the time to have a look at it? I would appreciate your
> feedback very much! 

Well, I just gave it a try, and found that the process to add a
configuration file was rather long, due to the fact that the addition of
the manufacturer and the model are separate steps. You should be able to
do it all in one flow:

1* Select motherboard maker OR add it if it doesn't exist.

2* Select motherboard model OR add it if it doesn't exist.

3* Upload the configuration file.

Also, you should have comments on what fields are used for what. It
looks to me like only the "long" motherboard maker and product names are
used. What are the short ones for? Internal use? Can't they be filled in
automatically from the long names?

Put in short, you have to consider the interface from the eyes of the
random user who wants to upload a configuration file. He/she must not
have to wonder what is what, and the operation must be as
straightforward as possible, that is, fill in fields and click OK a
couple of times, and that's all. Else, nobody will add data and the base
will be useless.

Thanks,
-- 
Jean Delvare
