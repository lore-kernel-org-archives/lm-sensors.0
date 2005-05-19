From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <47ki71hgj24v9136k5b6k2b841bddvfr87@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,
On Wed, 4 May 2005 15:16:11 -0400, Yani Ioannou <yani.ioannou@gmail.com> wrote:

>I was tempted to do this but it set off alarms in my better coding
>judgement (abusing a pointer to store an int). It is certainly
>'cleaner' than defining the awkward static ints, but aside from the
>language abuse would doing something like this cause any portability
>issues? And yes, what about those poor kittens? ;-)
Yes, I want to know too :)

>Well I'm an almost reasonable person ;-). Yes this code was mainly for
>comment so it definitely needs cleaning up, although any pointers on
>how/where are welcome.

I have queries, is there a reason why sysfs doesn't return multiple 
values?  So instead of asking for a filename with encoded array index, 
one gets a list of values?  One line per value, it works, easy to use 
as 'flat' datafiles.  And it removes index from filename.  the many 
to many (eg. temp channel -> fan speed control channel) can be resolved 
same as database normalisation.

Secondly is there a design document I've missed for this?  What does 
dynamic sysfs look like to user?  sub-directory per device/block or 
in the same directory level namespace?  I damaged the patches somewhere, 
one didn't apply so couldn't 'see' it yet.

--Grant.
