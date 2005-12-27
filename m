From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Tue, 27 Dec 2005 10:52:30 +0000
Subject: [lm-sensors] project status and future
Message-Id: <1135680750.4471.62.camel@gimli>
List-Id: <lm-sensors.vger.kernel.org>
References: <43AF1E4A.90902@sh.cvut.cz>
In-Reply-To: <43AF1E4A.90902@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

On Sun, 2005-12-25 at 23:33 +0100, Rudolf Marek wrote:
> And the future plans that are PITA for now:
> 
> 1) new support system, - (it died previously and never has been finished)
> 2) new userspace library - new config file system and all stuff around.
> 3) wiki like pages, so other people can contribute to sensors know-how -> it should "concentrate" our wisdom
>    and wisdom from mailing list.
> Pi) configuration file repository - this can hide in wiki as first step.
> 4) patches that were not included in mainline simply because Jean did not have time to handle them :(
> 5) and many others ...(multiplexed bus handling, driver cleanup, decode-dimms update... etc etc)
> (hope I did not forget something)

I want to suggest a tool that covers several of these items. But first a
few words on the background:

I'm working on the MadWifi project [1], a Linux driver for Atheros-based
WLAN cards. Our project used to be hosted on sf.net, but aside from the
CVS and the mailing lists we didn't make use of the other tools they
provide (such as the bug/wishlist/patch trackers), due to a decision of
the original maintainer. Everything was managed via the mailing lists,
which made it very hard to keep track on the current state of an issue,
for example. Submitted patches and good bug reports got virtually lost,
things like that. Long story short: the situation was a mess.

At that time we decided to make use of Trac [2], a tool for managing
small projects. It integrates a powerful Wiki engine (based on
MoinMoin), an issue tracker, a web-based frontend to the (Subversion)
code repository and "milestone" management. It's not feature-overloaded,
making it easy to use for administrators as well as users.

The only possible down-side of Trac: it requires making use of
Subversion rather than CVS. For us that was no problem, since we already
planned to do this switch anyway, but it might be a hurdle for other
projects. 

We're working with Trac for about two months now, and it's a great tool.
It helped us to free up resources, keeping better oversight on
outstanding issues / patches / requests and making it easier to maintain
the documentation. We don't want to miss it anymore, and it was worth
all the related hazzle of moving to a new server and a new scm.


Some words on how we handle some of the above mentioned items in our
project:

All our documentation is kept in the Wiki. This includes a "best of
mailing list posts" as part of the FAQs, user-contributed recipes,
configuration examples, and so on. Where appropriate we can attach files
to a wiki page (it's easier to click on a download link rather than
copy'n'paste provided examples to a local file).
Most of the wiki is opened for contribution from users. This is used to
extend the available documentation, getting rid of typos/errors in the
documentation and so on. We have good experiences with this so far, no
serious case of abuse.

Similar to lm-sensors we provide mailing lists for support requests as
well as an IRC channel for support and socialising. Interesting
information gets "ported" over to the wiki, most of the time as addition
to the FAQ. 

Bug reports, feature requests and contributed patches are kept as
tickets. Tickets can be manually or automatically assigned to one of
those with an user account (which we give away for developers and
continuing supporters). Each ticket can be assigned to one of the
defined milestones, and from the milestone view it's possible to tell
what amount of work is left until a milestone is reached.
The tickets allows to easily tell who is working on an issue, what the
current state of the issue is and what happened to a submitted patch. 


Bottom line: I think Trac is a valuable tool, and might be a good choice
for the lm-sensors project as well.

[1] http://madwifi.org
[2] http://www.edgewall.com/trac/

Bye, Mike


