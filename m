From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 03 Jul 2007 21:09:45 +0000
Subject: Re: [lm-sensors] concentrate efforts on libsensor-3.x or also add
Message-Id: <20070703230945.11464b1c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <468915CD.5020300@hhs.nl>
In-Reply-To: <468915CD.5020300@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 02 Jul 2007 17:12:13 +0200, Hans de Goede wrote:
> I'm wondering when are libsensors-3.x alpha / beta releases planned? I'm 
> tending towards not adding support for the abituguru3 and the f71882fg to 
> lm_sensors-2.10.x because 3.x will hopefully soon be available and I can spend 
> my time only once. OTOH, the 2.10.x line may continue to exist and be used for 
> a while so it might be a good idea to add support there too, what do you guys 
> think?

This is a very valid question. The problem is that there is no release
date planned for 3.x. Originally, Mark wanted to release it on July
2007, i.e. now... and as you can see it didn't happen. I changed the
milestone to September 2007 in trac, but the truth is, I simply don't
know if I'll be able to put enough time into libsensors by then to make
it really happen. There's still a lot to do, despite the fact that
things look good from the outside, and seem to work. I want us to
review the library interface entirely, killing what's not needed, and
reworking what needs to be. As we're going for a new major .so number,
we really need to start from a clean design, not quickly adjusted code
based on the old library.

I am not interested in making formal alpha releases. People can pick
from SVN anytime if they want to. I am not too interested in numbered
beta releases either. I'd rather generate nightly snapshots as we do for
the other branches, once we feel it's time to do so.

2.10.4 will be released very soon. And after that I think we'll have at
least 2.10.5 before the 2.x branch can go to sleep. And distributions
need time before they switch to a new branch of a product. So I don't
think you can spare the time needed to add support for your chips to
the 2.10.x branch, unless you don't want distribution users to use your
drivers before another 6 months, at best. Only after 3.x is released,
we can stop adding support for new chips in 2.x, methinks.

Not to say that you shouldn't ask your testers to try branch 3.x now as
well, just to make sure it works as intended - but that's not what
regular users will have in their distributions before a while.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
