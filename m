From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Aug 2007 21:25:57 +0000
Subject: Re: [lm-sensors] Please clean up procedures here (also against
Message-Id: <20070815232557.270c2da6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46C34CBE.20612.105BF55@localhost>
In-Reply-To: <46C34CBE.20612.105BF55@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Boyd,

On Wed, 15 Aug 2007 18:58:06 +0200, Boyd Noorda wrote:
> > This is how open software development works.
> 
> ?? I don't think it's normal netiquette to publish someone's E-mail 
> address on a web site, without the person in question knowing, in any 
> circles. OK, it happens, but by people not knowing about these things. 
> I don't expect that here ...

If you "didn't know" that writing your e-mail address to a public
website could result in it being known to the world, then I'm sorry
but you're not very smart. If you had taken a look at a few random
tickets on our site, you'd have noticed immediately that the e-mail
address of the reporters was publicly visible. And we're not the only
ticket system doing that, for example bugzilla.kernel.org publish
e-mail addresses of reported as well.

> > You posted on our public website (and right now, to our publicly
> > archived mailing list), you published your e-mail address to the public
> > on your own. If you didn't want it to be known to the public, then you
> > should have refrained from adding it to the support ticket when you
> > created it, sorry. 
> 
> There is something very wrong with procedures here, I'll explain:
> 
> - I had a simple user question and followed the 'Contact and Support'
>   link.
> - At this page (now called 'Feedback and Support') I simply followed
>   directions under 'Support Ticket'.

I've changed the link from 'Contact and Support' to 'Feedback and
Support' for consistency.

>   There it says: "Note: In order to get rid of spammers, we had to
>   block anonymous creation and edition of support tickets. We created a
>   fake account you have to use instead. First log in with name "ticket"
>   and password "need help" (in one word), then you can create a new
>   ticket and later edit it. Put to CC: your mail please!"
> - So nothing there which warns me I'll be publishing my E-mail address,
>   quite the contrary: you seem aware of the risk of spammers. The
>   urgent request: "Put to CC: your mail please!" (in bold) is not
>   explained(!), but seems logical: I'll get a copy myself and you know
>   to which address to answer.

The note about spam refers to our wiki being spammed, not the
reporters. The sentence is rather clear about that, if you take the
time to read it.

We ask people creating tickets to add their address to Cc so that they
get a notification when there's a reply to the ticket. It can take some time
before anyone has the time (and interest) to reply to a ticket, and it
is very frustrating when you spend time to solve a problem, ask the
reporter for additional information and never get any answer because
the reporter doesn't know you need his/her input.

I've improved the text at the bottom of this wiki page a bit, hopefully
it will prevent rants like yours in the future, but I'm not holding my
breath: people tend to jump directly to what they need without reading
the help text.

> - I got an answer by E-mail (thanks :) which even contains the line
>   "* cc: boyd2006@sociamedia.nl (removed)"

When we reply to a ticket, we move the reporter's address from the "Cc"
field to the "Reported By" field, as this makes more sense.

> - At this point my message is already up on a wiki page, with my
>   address!

It was already before, at the moment you created the ticket. In other
words, you did it, not me.

> - By replying to your answer, I automatically post to your mailing list
>   and to a public archive, again publishing my E-mail address.
>   And again there is no way to know that. There simply is a 'reply to:'
>   address (lm-sensors@lm-sensors.org) in the header.
> - Only when I would be very suspicious (why? no reason up to now) I
>   would examine the address lm-sensors@lm-sensors.org via a web search,
>   to find out it's a mailing list address. And I 'could have read' a
>   blurb on mailing lists on the 'Feedback and Support' page and maybe
>   could have noticed from memory (...) this could be the address I'm
>   automatically replying to. Quite a long shot, isn't it?
>   And I did not read that, I did not want to subscribe, I just had a
>   question, so moved on to the 'Support Ticket' blurb on the page.

Again you're not very smart if you do not at least suspect that
"lm-sensors@lm-sensors.org" is a mailing list address. Nevertheless, I
completely agree that this Reply-To header was confusing, and we will
remove it.

> Besides this, I'm also very surprised to find you publish all addresses 
> of posters in the public mailing list archive too. Subscribers don't 
> need these addresses, they already see them in the mail.
> And what's more: the version of Mailman you're using, makes it very 
> simple to remove (machine) readable addresses from the web archive 
> (feature added by 'public demand') ...

It seems that you really don't get how open-source development works.
Being able to contact people is a key feature. There are lots of people
finding information in the list archive and contacting the relevant
persons. This is very useful, and this is the reason why almost all
mailing lists include the posters' addresses. See for example
http://marc.info/, it archives literally hundreds of mailing lists and
includes e-mail addresses. Same for http://gmane.org/.

> Now I'm quite prepared for these things happening as you can see from 
> my disposable address. (Most people are not, just having one address 
> with their provider). Still I'd like to restrict the harvesting of my 
> addresses to not preventable cases, like infected PC's :)
> 
> I also hope to convince you to take action for other reasons:
> Fighting spam with 'software filtering' (I guess you do that 
> extensively, since mailing lists are even open to non subscribers) is 
> very 'old school' these days. As you will know there are days when over 
> 90% of E-mail traffic are spam and viruses. This means the 
> infrastructure and servers need 10 times the capacity they would need 
> to just handle normal E-mail, and you need overhead to run heavy 
> filtering software.
> Any idea what this means for energy use and climate change? In the US 
> already 1.2% of all electricity is used by internet servers (and their 
> cooling) only!
>
> So fighting spam and viruses should be done by prevention as much as 
> possible (like using images of E-mail addresses with mailto scripts and 
> refusing most spam and virusses 'at the front door'). It works and 
> saves money too. Many years back our P166 server (30-41 watt) with 
> loads of web sites, mailing lists and E-mail addresses was already 
> choking during spam waves. Since we implemented preventive actions, 
> it's running over 95% idle again most of the time. No need to upgrade, 
> w're even 'downgrading' to a more energy efficient server :)  

This is very true, and also totally unrelated with the problem at hand.
You're talking as if I was responsible for the world-wide spam problem.
I'm not. The guys sending the spam, are. The guys writing software that
makes it easy to send spam, are. The guys who refuse to make the e-mail
system more robust to spam, are (how comes that any PC in the world is
allowed to send e-mail?) The guys who refuse to vote laws to punish
spammers, are. If you feel concerned, please go after all these people,
not me.

I'm a bit fed up with people who get support from us for free and who
dare to complain that things are not the way they like. If more people
complain about this ticket system, we'll just close it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
