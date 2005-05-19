From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:04 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <20040705200511.09573ed8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I vote option #1 for 2.4.
> Option #2 would force sensors users to upgrade to latest i2c.
> Option #3 isn't worth the trouble, unless that's what we do for 2.6,
> then maybe.

Ah, interesting remark about #2, I had missed that point. That's
especially important since we would like to bring more compatibility
back.

> I vote option #1 for 2.6, unless we get objections, then we do #3.
> I don't see much in common with the code in i2c-sensor (#2).

i2c-sensor contains the code common to sensor chips. I see no better
place for the new function. I agree that having a separate module (#3)
is theoretically nicer, but all in all what's the point in having two
drivers which will be loaded together like 90% of the time?

> Also, by returning 0, we require each module to pick its own
> default: if(! vrm = which_vrm()) vrm = DEFAULT_VRM;
> this is what we want, right, since different drivers may have
> different ideas about what is the best default?

This is how things are now, so doing so preserve compatibility. We had a
theoretical default VRM but some drivers (asb100) don't follow it, and I
wouldn't blame MMH for that (the ASB100 is a recent chip not used with
VRM 8.x CPUs, so it would be silly to default to that).

However things are different now. The default will be for chips we don't
know about, at all. This means they are likely to be recent and to use
more and more recent versions of VRM. We could want to have a default
and keep it up-to-date with the latest known common VRM version.

Another thing to consider is that this case is just not supposed to
happen, so the thing to do would be to make sure people will report to
us, so that we can update our detection code. One way to do so would be
*not* to report any value, ie VRM = 0 -> nominal Vcore = 0 whatever the
VID values (+ message in the logs). This latest method looks cleaner
than an arbitrary VRM which is likely not to be correct anyway.

-- 
Jean Delvare
http://khali.linux-fr.org/
