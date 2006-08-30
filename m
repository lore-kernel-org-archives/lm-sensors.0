From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 30 Aug 2006 11:45:15 +0000
Subject: [lm-sensors] [RFC] Improved sensors-detect output
Message-Id: <20060830134515.c872f7ad.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060829133558.19eb6bb6.khali@linux-fr.org>
In-Reply-To: <20060829133558.19eb6bb6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

Moving back to the list, I doubt you replied off-list on purpose?

> > I am trying to make sensors-detect more user friendly. I made a first
> > pass this morning, which is already committed to SVN, with the
> > following changes:
> >
> > * Kill the annoying blank space in front of half of the messages.
> >   
> The indents on the intro text might be worth keeping - once youve read them,
> a (tab) indent makes it visually easier to skip.

I don't want people to skip it! It might change over time. People
probably don't run sensors-detect every day, so when they do, I expect
them to read everything we write.

At any rate, a one-space indentation wouldn't be enough if we really
intended to make one paragraph look differently from the other ones.

> > Probing for `Analog Devices ADM1033'...                     Failed!
> > Probing for `Analog Devices ADM1034'...                     Failed!
>
> consider  s/ Failed / None Found /  ?
> 
> its prudent to avoid a loaded word like Fail, when another is more accurate.
> its only a failure when the chip is really there, but not seen.

Agreed. I thought exactly the same. For some reason it wasn't obvious
when the word wasn't split from the rest of the text, but now that it
is clearly separated, I had the same reaction you had.

I am considering "No" as a replacement, it's short and neutral. I'm not
completely happy with "not found" because actually a chip has been
found, it's just not the exact model we were trying to identify. Behind
this lies the problem that our probing method is obsolescent, we are
trying every possible model one after the other without taking benefit
of previous register reads. It was OK when sensors-detect knew only a
handful of different chips, but no more. Changing this is beyond the
scope of my current patch though.

Thanks for the feedback, Jim :)

-- 
Jean Delvare

