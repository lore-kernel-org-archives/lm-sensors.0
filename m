From: Matt Roberds <mattroberds@cox.net>
Date: Sat, 14 Feb 2009 04:44:19 +0000
Subject: Re: [lm-sensors] [PATCH 4/6] Read extra configuration files from
Message-Id: <Pine.LNX.4.64.0902132235080.2071@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090211175008.0f843712@hyperion.delvare>
In-Reply-To: <20090211175008.0f843712@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 13 Feb 2009, Jean Delvare wrote:
> On Thu, 12 Feb 2009 23:23:12 -0600 (CST), Matt Roberds wrote:
>> On Wed, 11 Feb 2009, Jean Delvare wrote:
>>> +		char path[16 + NAME_MAX];
>>
>> This says that the maximum length of the path to the config files is
>> 16 characters?  Seems kind of short.
>
> Not really. There is no strong delimiter between the directory name
> and the configuration file name, what is limited is the total length.

Ah, right.  As long as NAME_MAX is huge this might not be a big deal.

> Even including the full board manufacturer and model names in the
> configuration file name is hardly going to exceed 50 characters.

A well-known businessman once said something about 640 KB.  :)

> I don't know the exact semantics of PATH_MAX but I suspect it includes
> all the directory names _and_ the file name, so adding MAX_NAME to it
> doesn't make sense.

The GNU libc docs at
http://www.gnu.org/software/libtool/manual/libc/Limits-for-Files.html#Limits-for-Files
spell it out, citing POSIX.  Note that it can be different for different
filesystems; you can ask at runtime if you really want to know:
http://www.gnu.org/software/libtool/manual/libc/Pathconf.html#Pathconf
On the other hand, the man page for pathconf on my system says "Some
returned values may be huge; they are not suitable for allocating
memory."

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
