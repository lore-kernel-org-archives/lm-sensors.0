From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 15 Feb 2007 16:33:08 +0000
Subject: [lm-sensors] Abit AT8 (non-32X) / Winbond 83627EHF
Message-Id: <20070215173308.40f47454.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D0A4B2.6030002@vt.edu>
In-Reply-To: <45D0A4B2.6030002@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Thu, 15 Feb 2007 08:04:15 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > On Wed, 14 Feb 2007 14:43:09 -0500, Rick Wright wrote:
> >> Thanks for the support  Hans de Goede responded to me off list 
> (...)
> >> On the other hand, the problem that lm_sensors still has is that it was 
> >> the sensors-detect script that originally reported that I had a 
> >> w83627ehf chip and ultimately led me down this path.  Hans suggested 
> >> this is not a correct identification job and that sensors-detect should 
> >> be fixed.
> > 
> > Hans is probably wrong. The Super-I/O chip detection is very reliable
> > and I would ve very surprised if you do not have a Winbond W83627EHF.
> > As a matter of fact, this hi-res picture of your motherboard:
> >   http://www.techpowerup.com/reviews/Abit/AT8/images/board_fullsize.jpg
> > clearly shows a W83627EHF in the top-left-hand corner.
> > 
> > But indeed there's also a uGuru chip on the board. Bad luck.
> > 
> 
> Ah, so this board has 2 sensors chips. Rick, can you see if the 
> W83627EHF voltage are any good (IOW match the ones given by openguru)?
> 
> 
> Jean, about the bad luck part, the uguru revision 3 actually is a pretty 
> nice chip (except for the lack of specs)

My definition of a bad chip.

>                                          as Rick writes I've written a 
> userspace reading utility for it and it works fine for all people who 
> have tested it (about 7 or so). I've also written a new kernel driver 
> for this new revision (it uses an entirely different "protocol") which 
> I've posted for review some time ago. If when can get some movement on 
> that review then users with a newer uguru will no longer have bad luck, 
> but instead a support chip.

I have many other driver and i2c-core reviews in the works at the
moment so it's unlikely that I will have a spare cycle anytime soon.
Someone else will have to do it.

My "bad luck" still applies. If Abit were using standard chips instead
of their own proprietary undocumented stuff, Rick would have full
hardware monitoring support for his board already. But of course if the
design of these new uGuru chips is better than the original ones,
that's still good news.

-- 
Jean Delvare

