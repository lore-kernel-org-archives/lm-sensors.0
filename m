From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: remove 2.2 support?
Message-Id: <3E221303.5000801@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E0E709B.5000900@paradyne.com>
In-Reply-To: <3E0E709B.5000900@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks Ky?sti
for the 2.4 cleanup.

We have a vote from Ky?sti for branching.
Albert suggested the same thing to me in an email.
Pavel suggested abandoning CVS and doing everything in Linus' tree.

I'm really reluctant to branch but it may be the only realistic way to do it
unless somebody volunteers to do patches manually (and perpetually).

I guess we would do the 2.4 cleanup on the sensors side,
then release 2.8.0, then branch?

Comments/opinions please...


Ky?sti M?lkki wrote:
> On Fri, 10 Jan 2003, Mark Studebaker wrote:
> 
> 
>>Due to the recent discussions re: kernel 2.5.54, and
>>the lack of any critical problems with 2.7.0,
>>I declare the two weeks over in record time :)
>>
>>If you intend to do any of the 2.4 cleanup you may wish
>>to let people know.
> 
> 
> Okay. I have i2c tree under inspection, removing any < 2.4 #ifdefs.
> I understand you gave a green light for these commits?
> 
> Once done with that, I would like to branch in CVS for 2.5
> development, and trace back changes from Linus's tree.
> 
> Also, i2c headers could use a cleanup there.
> 
