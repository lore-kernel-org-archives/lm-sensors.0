From: stevenkaratnyk@rogers.com (Steven Karatnyk)
Date: Fri, 06 Jan 2006 19:16:26 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <43BEC20A.3040601@rogers.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jim Cromie wrote:
> if you can build a kernel, and can apply a patch,
> then you can get the ones ready for 2.6.16 here.
> http://khali.linux-fr.org/devel/i2c/linux-2.6/
>
> ......
>
> the series file in there lists the patches in the order you need to 
> apply them.
> to a 2.6.15 tree
> Theyre slated for inclusion in 16, and some of them are *thf patches.
> You *could* try just the *thf patches, you should know by compiling
> whether you need others.
>
> theres also 2 tars, might save you some hassle.

That's what I'm seeking. Thanks.


> BTW - youd do well to drop the *misfortunate* posture.
> I cant speak for that chip, but Winbond is supporting their product,
> one or more of them is on-list here, and they appear to 
> play-nice-with-others.

a) If you are unfamiliar with the story behind that chip, as conveyed 
from the information found on the drivers page, then you have completely 
missed the context of my use of misfortune "posturing".   If you review 
those sources you will find that it is stated as being a "rare chip, not 
listed on Winbond's site, we have no datasheet for it, this explains why 
we don't support it".   Of course the second thread continues to reveal 
how experimental patches were developed.  However, those patches are now 
quite dated in terms of kernels to which they are to be applied.  There 
is no indication of any further change on the situation -- either on the 
driver page or in the changes file.  As an end-user trying to determine 
the status of the w83687thf (and one who spent some time poking around 
lm_sensors website and google),  I was disappointed to find no further 
developments.   Assimilating that information with the fact that I 
(unsuccessfully) tried applying the existing, but dated, patches on my 
own prior to bugging anyone on the list about it, I have no problem 
standing by my earlier statement that "I have the misfortune of having 
the Winbond W83687THF Super I/O IC on my Soltek motherboard 
(SL-B9D-FGR)".  Is that context clear enough?


b) You appear to have made the faulty assumption that my usage of 
"misfortune" was a slight against Winbond.  It was not, and should in no 
way be construed as such.


c) As an end-user not intimately involved in the lm_sensors project, I 
was unaware that Winbond is actively supporting their product(s).  From 
my observations (as outlined in point (a)), the w83687thf remains 
unsupported.  Indeed, there remains only a brief press release about 
this chip on Winbond's website.  You could probably find the pdf from 
their downloads section, but I, nor likely you or anyone else, has the 
time to play guess the magic xxxx number  
(http://www.winbond.com/c-winbondhtm/partner/PDFresult.asp?Pname=xxxx).


d) Lastly, despite the fact that your advice was mis-directed, it 
remains a bit perplexing to me -- Is the relationship between lm_sensors 
and Winbond so tenuous that end users must avoid writing anything that 
might appear in a negative light about the vendor?  Is Winbond going to 
get offended by the slightest knock, pick up their ball and go home?  
Personally, if I have anything deservingly negative to say about a 
company, don't count on me tip-toeing around the issue or holding back 
on the matter.  However, in this case, I reiterate that dissatisfaction 
with Winbond was never a point of issue in my posting to the list.

>
> Remember what used to happen to the sissys and whiners on the school
> playground ?   We may be more grown up now, but human nature is what 
> it is.
>
At first I wasn't sure if it was directed at me, as it makes no sense 
(other then perhaps being a follow on to your "posturing" commentary). I 
considered that perhaps it was a signature included in all of your 
posts.  Yet, glancing at a few of your prior posts on the list quickly 
extinguished that notion and reaffirmed that it was indeed directed at 
me.    My reply is this:

While I thank you for the useful information you provided early in your 
reply, I have no idea what point you are trying to make here.  As I have 
already addressed in detail your prior misdirected commentary, I will 
only add that this last comment bears little value to any 
conversation.   It strikes me that you have become too deeply involved 
with the project.  Take a step back and try to envision where uninvolved 
end users are coming from.  If I had over looked clear and concise 
information sources, then an admonishment from you would have been in 
order.  However, that was not the case, and your "advice" only spills 
over as arrogant badgering.

Thanks for your time.  Steve.







