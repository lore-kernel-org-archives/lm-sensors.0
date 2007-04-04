From: "Ivo Manca" <pinkel@gmail.com>
Date: Wed, 04 Apr 2007 09:34:37 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <003101c7769c$7bb73b10$0901a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Jean,

Thanks for pointing out Slackware :), but we won't be using a DBMS anymore 
(for the clientside).

> For the local data, I'd go for text files. Each motherboard being
> uniquely identified by a finite number of DMI strings, we can
> combine them to form a unique identifier and use that in the
> configuration file name. Ideally this should be something like
> sensors-$manufacturer-$model-$version.conf, but we'll see how it goes
> in practice. With this naming convention, lookups are in O(1), which is
> perfect.
>
> Now, it might still be good to have a database as the backend of the
> website, that's a different story. It should be easy enough to generate
> all the text files from the database, adding metadata as comments at
> the beginning of the files.

> Looking up will indeed go lots faster that way, so I think that idea is 
> not bad at all.
> I think using a (MySQL) database on the website will be a big pro.

> I believe that non-matching version numbers should not be fatal. It
> sometimes happen that different versions of a board need different
> configuration files, true, but it's rather rare, so we don't want to
> store one configuration file per version in general, that would be
> overkill; we'll only do so when really needed.

> So I think we should try to match all 6 fields first, if it fails, try
> without the versions (so only 4 fields), and only if that fails too,
> declare that no matching configuration file was found.

True, should make it more usable.

> Random idea: we could add an architecture tag to configuration files.
> There's no point in installing files for x86 motherboards on an x86_64
> distribution for example. This would allow distributions to split the
> configuration files to multiple packages and only includes the ones
> they want.

Noted, we'll think about this one.

> Different people might upload a configuration file for the same
> motherboard, in the "unconfirmed" state or whatever we call it. Until
> someone reviews them, validates one of them and discards the other, we
> have two files for the same board. So yes, it can happen. There should
> never be several "confirmed" configuration files for a given board,
> though.

> Now, what is true of the website database may not be true of the local
> cache (files in a directory, if we do that.) We may decide to only
> export the confirmed files for the cache, for example, or only one of
> the possible configurations (maybe based on a mark given by the site
> visitors.) I have no strong opinion on this.

Why not make the user decide about this? Default option: only confirmed. But 
a posibility to download the "unconfirmed/experimental" ones also.
Ofcourse, we'll have to notify the user with  "These configs are not tested, 
bla bla bla".

Thanks for your input.

Ivo 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
