From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Dec 2008 11:00:50 +0000
Subject: Re: [lm-sensors] sensors-detect: testers wanted!
Message-Id: <20081205120050.2724e0d6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081203182216.5be504cf@hyperion.delvare>
In-Reply-To: <20081203182216.5be504cf@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matt,

On Wed, 3 Dec 2008 17:29:50 -0600 (CST), Matt Roberds wrote:
> On Wed, 3 Dec 2008, Jean Delvare wrote:
> > For Asus (and Tyan) we would keep probing the SMBus even in the
> > presence of an enabled Super I/O.
> 
> This is probably helpful, as long as these boards are also known not to
> blow up too badly when you do probes that have to write to the hardware.

I can't remember such problems with Asus nor Tyan boards so far.

This is done now. And now that I think of it, we can probably add
SuperMicro to the list, they too tend to add hardware monitoring chips
even when the Super-I/O embeds sensors.

> I would suggest that you keep the heuristic in sensors-detect pretty
> broad; going by manufacturer and possibly by top-level CPU type (AMD,
> Intel, or other) is probably as fine as you want to go in
> sensors-detect.  Otherwise you end up having to maintain all kinds of
> special-case stuff in sensors-detect, instead of actually working on the
> hardware drivers etc.

I totally agree. I have gone the vendor-white-listing way because I
think it will work fine without too much extra work, but if it doesn't
then we're back to the more simple and safer heuristic, even if this
means more work for some users.

> > (...)
> > An alternative would be to simply split IPMI interface probing to its
> > own section, as these are fundamentally different from legacy ISA
> > chips.
> 
> I think this might be useful.  That might let you spend a sentence or
> two explaining IPMI and why you might want to probe it or not before
> asking the user for a choice.

This is done now. Please note though that I am by far no IPMI expert,
so my wording may not be the best. If anyone has suggestions on how to
improve it, please speak up and make proposals.

> > I didn't want to explain everything in detail in the script, again to
> > not frighten the user with long explanations, when most users should be
> > able to just hit "Return" and be done with it.
> 
> This is a useful goal.  But also, most users are only going to run
> sensors-detect once or a small number of times while they are getting
> things set up, and then they don't have to deal with it again for quite
> a while.  IMHO it's OK to be a little more wordy in this case; I think
> it tends to help people make better choices the first time through,
> which means they are more likely to end up with a working configuration.

You're certainly right. I didn't have the time to write more
documentation though, and I probably won't have the time in an
immediate future. I've spend many many hours on sensors-detect in the
past 10 days, while there are many other issues which need my attention.

Maybe I'll just wait for users to complain about the unclear parts,
then I know exactly what needs documenting.

Meanwhile, patches to sensors-detect.8 are obviously welcome.

> > I'm not sure how to add more information without making sensors-detect
> > painful to use in the main case.
>
> Links to the man page might be a good idea.  ("See the MICROCHANNEL
> heading on the sensors-detect man page.")

I was more thinking about a general hint right when you start
sensors-detect: "See the manual page for extra information before you
give a non-default answer to any question." If we are going to add a
custom link before every question then we might as well include the
help in sensors-detect directly.

> Maybe URLs, if you are prepared to fight URL rot.

No, I do not want to refer to URLs. Administrators running
sensors-detect in a text-only environment won't enjoy it, and I don't
want to maintain a web page with extra documentation. This isn't always
the case, but in this specific case it is clear to me that we want the
documentation to be available on the user's system directly.

Can you please fetch sensors-detect again from SVN and give it a try? I
think I have addressed most of your points now, so it should work fine
on your system.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
