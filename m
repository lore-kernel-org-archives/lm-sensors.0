From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: as99127f additional temps
Message-Id: <1074073186.40050e625beb6@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040110134945.6e58ea97.khali@linux-fr.org>
In-Reply-To: <20040110134945.6e58ea97.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > So I propose that we use standard lm75 conversions for the
> > as99127f subclients. This will simplify the code much. Comments,
> > objections?
> 
> I thought you had an as99127f to test?

I do have one, yes. But I don't see how it can help me. Am I missing
something?

> I don't have one.  AFAIR there are multiple different kinds out
> there.

Yes, there are two known revisions, which have noticeable differences 
(much like w83781d and w83782d have), although we do have a single chip
type for them in the w83781d driver.

It's possible that both revisions differ on this point, if this is what
you had in mind. But since all revisions need a conversion formula in
sensors.conf at the time being, I don't see how it could be worst. And
we don't have more reasons to think they differ than to think they are
similar, do we?

> I felt free to change/fix the conversions when going from as99127f
> to independent asb100 driver because it required an updated
> sensors.conf for the user anyway.  as99127f is a different story -
> are you sure you want to break everyone's existing config?

The as99127f support is broken from the start anyway, due to the lack of
data sheet and support from Asus. What's more, the w83781d driver in
2.6 has broken temperatures anyway, so a little more change in there
wouldn't really hurt IMHO. And all the users have to do is update their
sensors.conf file. It's not that hard.

So, to answer your question: no, I don't mind breaking existing configs
if it makes the code cleaner.

Anyway, my initial question remains open, i.e. why was it done that way
in the first place?

> > BTW, MMH, would it make sense to move the as99127f support from
> > w83781d to asb100? I haven't looked at the code in deep myself yet,
> > just wondering if you have an opinion.
> 
> A step backward, I think.  If each driver supported just one chip
> then that would allow the driver to stabilize and just accumulate
> bugfixes until it's "done".

I don't fully agree on that. Sometimes having more than one chip
supported by a driver makes sense. Think of the adm1025 driver or the
lm90 driver. Each support two chips and the differences between these
is so insignificant that having a separate driver for each would be
just silly.

But of course when it comes to the point of unmaitainability the w83781d
driver has reached, you're right.

So basically my question was: can the as99127f be considered similar
enough to an asb100 to bundle both in a single driver? And your answer
is no. I don't have any problem with that, it was just a question.

> Someone submitted a patch once to put as99127f into its own driver.
> I'm sorry I wasn't able to review it at the time.  Well, it's in the
> archives...

Would be a good thing IMHO, although I doubt I'll have to take care of
this. And I admit I am not very motivated by the idea of working with
no data sheet either.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
