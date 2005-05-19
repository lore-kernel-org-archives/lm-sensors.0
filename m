From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: 2.8.1
Message-Id: <20031026195248.50a9edb1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F6484BA.24E78516@paradyne.com>
In-Reply-To: <3F6484BA.24E78516@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I just uploaded new i2c patches for the Linux 2.4.22 kernel based on
> > the freshly released 2.8.1 i2c.
> 
> Uploaded where?

http://www.ensicaen.ismra.fr/~delvare/devel/i2c/

Sorry, I though you had it in your bookmarks. What do I say, bookmarks.
As your starting page, yeah! ;)

> Care to send it to the list (and cc me, as I'm not keeping up on my
> sensors traffic due to Real Life stuff right now...)?

I usually avoid sending 250kB patches on mailing list, unless I am
explicitely invited to do so. I guess that interested people will go to
the download page, won't they?

Well, you must be right, I probably will have a larger audiance if I
push the patch to the people rather than letting them come to it. But
I'm now that kind of guy I guess.

> > This patchset will be the base of the patch I'll post to the LKML
> > for inclusion.
> 
> It needs to be a set of incremental patches, that do not break the API
> for any current drivers.  Hm, it's also a bit late in the 2.4.23-pre
> series to expect to get this in, but we can work on that.

Take a look at the above-mentioned page, the patch is splitted over
logical units. I guess that's how you expect things to be.

I know it's a bit late for .23, especially since the patch is rather
large. However, it was already a bit late for .22 last time. I don't
really care, but our users do. This is much trouble for them having to
patch their kernel to prevent it from crashing as soon as they use
i2c-related drivers (bttv...). So that would be great if we could make
an exception this time. After all, I2C isn't a critical subsystem, and
my previous patch has been successfully tested by many users on various
systems. And our patch allow i2c drivers to get rid of MOD_*_USE_COUNT
calls, so I guess the kernel folks will like it. It also i2c-related
driver authors who will now be able to have unified drivers for Linux
2.4 and 2.6. Hopefully these good reasons will be enough to convince
everyone that this patch should make it through 2.4.23.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
