From: fhj52rags@yahoo.com (Ric)
Date: Mon, 28 Aug 2006 10:27:44 +0000
Subject: [lm-sensors] wiki pages - update
Message-Id: <20060828102744.90326.qmail@web37403.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F09CBA.60301@sh.cvut.cz>
In-Reply-To: <44F09CBA.60301@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

Thanks for the feedback.

--- Jean Delvare <khali at linux-fr.org> wrote:

> Hi Ric,
> 
> > I am DOA for now which is okay since I need to spend some quality
> time
> > with the dremel and a SuperMicro SC750 case anyway. 
> 
> Where "DOA" and "dremel" mean...?

DOA = dead on arrival; meaning I got there but not much I could do.
Dremel is a brand name for a high speed rotary tool used with
attachments for cutting, grinding, drilling, engraving, ... just about
anything the mind can conceive.  Dremel is sold in Europe but there is
another brand name that I read is more popular.
The ( old but new to me ) Supermicro SC750A+ case is well built but not
designed for high efficiency and low-noise air cooling.  My Dremel and
I made some adjustments. :)


> > THE biggest problem is that there is not any registration function.
> 
> > Wikis are for collaborative efforts but apparently Trac does not
> have a
> > simple registration function. All I saw was that the admin has to
> run
> > an admin script to assign permisssions. I certainly hope that is
> robust
> > enough to be automated, :).
> 
> We disabled that feature of trac on purpose, because it made it very
> easy for spammers to create fake accounts and ruin our site. I agree
> it
> pretty much voids the point of having a wiki, and we need to find a
> solution to this problem.

I am sorry that happened but agree that it is very important to have a
workable solution ASAP.
Somebody(webmaster/admin) might ask the Warewulf webmaster if they are
having any trouble with spam or anything else.  The Warewulf OpenSource
project uses Trac and has a Register widget:
http://www.warewulf-cluster.org/cgi-bin/trac.cgi/register
...it works. 
Or ask Trac folks ... I just happened to know that Warewulf uses Trac
so maybe they have a solution.

As you probably know, most sites have now gone to email verification
and also use the "Enter the Code and if you guess correctly you win a
properly completed registration ticket" widget to stop the automated
registrations.  It must work since so many sites and forums use it.  
Warewulf uses neither.


> > I cannot do anything until I can be registered with at least the
> link
> > changing function.
> > 
> > I stopped at the FAQ link(s). As more than likely the first place
> any
> > user will look for info, if they look at all, ;),
> 
> I wish you were true...

I know what you mean. 
A little fix here and there will make it better. ...


> > it needs to be available and,
> 
> It looks available enough to me, do you see a problem there?

What I meant by available, was available on _that_ page and not another
link to go to some other page or website.
But besides that, yes, problem: It is static, not Wiki.
To make it a better user document, the _user_ has to understand it and
contibute to it.

Also, FAQ = Frequently Asked Questions. When used for documentation, it
is no more than a list of items that ask a short, simple question and
have a short, simple answer attached.  The key word there is "simple"
...


> > I suggest, editable. That presents a
> > Copyright problem.
> > Copyright (C) 1998 - 2005
> > Frodo Looijaard,
> > Philip Edelbrock,
> > Mark D. Studebaker
> > and
> > Jean Delvare
> > 
> > Since that *might* be considered as expired,
> 
> Copyrights expired after one year? In what country do you leave?

USA where we have copyrights, trademarks, digital rights, intellectual
rights, encryption export restrictions,  ..., and patents on some of
the silliest things one has never seen or heard of before. And lots of
lawyers who challenge all of those things every day. :)

Copyrights have to be renewed is all I meant.  If the authors chose not
to renew, then the copyright problem is not a problem.


> > authors' permissions s/b
> > all that is needed to adjust it.  I saw no 'license' for it; merely
> the
> > copyright statement. There is no mention of license anywhere on the
> FAQ
> > page. 
> >
> > Is that doc supposed to fall under the GPL as an official part of
> the
> > lm_sensors project?
> 
> The FAQ used to be (and actually still is) part the the lm_sensors
> tree itself, so I'd say yes.

Well, good. :)


> > The '' Licensed under GPL '' blurb is missing from the lm_sensors
> home
> > page so maybe that sentence s/b added so we all know that code
> _and_
> > documents are GPL'd, unless of course somebody wants to license
> > documents under the GFDL,
> > http://www.gnu.org/licenses/licenses.html#FDL, or similar. ;)
> 
> Good point, we mention that our software is "OSI Certified open
> source software", but we don't mention GPL. We should.

Glad you agree.


> > AS for the FAQ, I suggest a temporary fix by making the Contents
> list
> > correct and linked to the current FAQ page, as such:
> > [code]
> > Table of Contents 
> >
> [snip]
>
http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/lm_sensors-FAQ.html?format=raw#Document-Revisions
> > [/code]
> > 
> > That's pretty easy to do/change on the page and should work until
> such
> > time that Registration is available and working securely.
> 
> Before doing that, we must take a decision about what the FAQ source
> will be. Currently the FAQ source is a texi document, which is
> converted to plain text and HTML and distributed with lm_sensors
> itself. Rudolf Marek merged it into the wiki, so now we have two
> versions. I will let him explain what are his plans for the future.
> We certainly don't want to maintain two sources for the FAQ.
> 
> -- 
> Jean Delvare

Well, ( you and the other authors ) please consider that the current
"FAQ" should be called "Documentation" or "Manual" and a new "FAQ"
created for the WIKI that is just really, really, simple questions and
answers. ( the most pesky ones that drive you and the other dev's crazy
because they have been answered so many times and have such simple
answers )

...

Regards, Ric


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

