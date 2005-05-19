From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: lm-sensors support for ASUS chip ASB100 Bach
Message-Id: <20030413190106.GD17239@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <795E03B0F1E26C449762C0EDF5F5659140F50F@Exchange.16.172.in-addr.arpa>
In-Reply-To: <795E03B0F1E26C449762C0EDF5F5659140F50F@Exchange.16.172.in-addr.arpa>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello:

* Jean Delvare <khali@linux-fr.org> [2003-04-10 13:53:41 +0200]:

> The Asus ASB100 is seen as a modified AS99127, which itself is handled
> by our W83781D driver. So, the file to modify is definitely "w83781d.c".
> On the other hand, since the drivers are actually incorporated into the
> Linux 2.5 kernel tree, working on them these days may be tricky. But if
> we can make things work better, even on "temporary code", it won't be
> lost.

Correct.

* "Bernatzky Rudolf" <Rudolf.Bernatzky@plg.de> [...]:

> > Alternatively I could generate a list of chip features with functions
> > and address offsets and command code. With the latter alternative I am
> > unsure with regard to the legal aspects. What do you think?

I think (but I'm not certain) that most of the problems with 
Asus support are for actual AS99127.  As written, ASB100 works
well enough for me.  I've heard some Athlon owners found another
register that gives better CPU temps, but I haven't seen a patch
for it.

Rudolf, don't be afraid of the code!  Since you have the docs,
you're way ahead of the rest of us.  You can send patches to
sensors version 2.7.0 or from latest 2.5 kernel.  Either way,
I can test them and then take over from there.

> I'm no law specialist, for sure. From a technical point of view, it
> seems to me that it would be far easier if we could get access to the
> whole information. But I don't know if we (the LM Sensors dev team) are
> supposed to accept signing NDAs or not.

<offtopic>
Why would anyone be willing to assume liability just for the
privilege of supporting someone else's product, for free?
There's no way I would ever sign an NDA unless it's paid work -
and even then it depends on the terms.
</offtopic>

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
