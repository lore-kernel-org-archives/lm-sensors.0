From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 27 Aug 2006 12:17:55 +0000
Subject: [lm-sensors] wiki pages - update
Message-Id: <20060827141755.10505959.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F09CBA.60301@sh.cvut.cz>
In-Reply-To: <44F09CBA.60301@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ric,

> I am DOA for now which is okay since I need to spend some quality time
> with the dremel and a SuperMicro SC750 case anyway. 

Where "DOA" and "dremel" mean...?

> THE biggest problem is that there is not any registration function. 
> Wikis are for collaborative efforts but apparently Trac does not have a
> simple registration function. All I saw was that the admin has to run
> an admin script to assign permisssions. I certainly hope that is robust
> enough to be automated, :).

We disabled that feature of trac on purpose, because it made it very
easy for spammers to create fake accounts and ruin our site. I agree it
pretty much voids the point of having a wiki, and we need to find a
solution to this problem.

> I cannot do anything until I can be registered with at least the link
> changing function.
> 
> I stopped at the FAQ link(s). As more than likely the first place any
> user will look for info, if they look at all, ;),

I wish you were true...

> it needs to be available and,

It looks available enough to me, do you see a problem there?

> I suggest, editable. That presents a
> Copyright problem.
> Copyright (C) 1998 - 2005
> Frodo Looijaard,
> Philip Edelbrock,
> Mark D. Studebaker
> and
> Jean Delvare
> 
> Since that *might* be considered as expired,

Copyrights expired after one year? In what country do you leave?

> authors' permissions s/b
> all that is needed to adjust it.  I saw no 'license' for it; merely the
> copyright statement. There is no mention of license anywhere on the FAQ
> page. 
>
> Is that doc supposed to fall under the GPL as an official part of the
> lm_sensors project?

The FAQ used to be (and actually still is) part the the lm_sensors tree
itself, so I'd say yes.

> 
> The '' Licensed under GPL '' blurb is missing from the lm_sensors home
> page so maybe that sentence s/b added so we all know that code _and_
> documents are GPL'd, unless of course somebody wants to license
> documents under the GFDL,
> http://www.gnu.org/licenses/licenses.html#FDL, or similar. ;)

Good point, we mention that our software is "OSI Certified open source
software", but we don't mention GPL. We should.

> AS for the FAQ, I suggest a temporary fix by making the Contents list
> correct and linked to the current FAQ page, as such:
> [code]
> Table of Contents 
> http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/lm_sensors-FAQ.html?format=raw
> 
> [FAQ/Chapter1 Chapter 1: Introduction and Overview]
> http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/lm_sensors-FAQ.html?format=raw#Top
> 
> [FAQ/Chapter2 Chapter 2: Sensor and Bus Basics]
> http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/lm_sensors-FAQ.html?format=raw#toc_Basics
> 
> [FAQ/Chapter3 Chapter 3: Installation and Management]
> http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/lm_sensors-FAQ.html?format=raw#toc_Installation
> 
> [FAQ/Chapter3 Chapter 4: Problems]
> http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/lm_sensors-FAQ.html?format=raw#toc_Problems
> 
> [FAQ/Chapter4 Chapter 5: How to Ask for Help]
> http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/lm_sensors-FAQ.html?format=raw#toc_Help
> 
> [FAQ/Chapter5 Chapter 6: How to Contribute] 
> http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/lm_sensors-FAQ.html?format=raw#toc_Contribute
> 
> [FAQ/Appendix: Revision history of this document]
> http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/lm_sensors-FAQ.html?format=raw#Document-Revisions
> [/code]
> 
> That's pretty easy to do/change on the page and should work until such
> time that Registration is available and working securely.

Before doing that, we must take a decision about what the FAQ source
will be. Currently the FAQ source is a texi document, which is
converted to plain text and HTML and distributed with lm_sensors
itself. Rudolf Marek merged it into the wiki, so now we have two
versions. I will let him explain what are his plans for the future. We
certainly don't want to maintain two sources for the FAQ.

-- 
Jean Delvare

