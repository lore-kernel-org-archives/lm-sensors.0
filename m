From: randhol+vim@pvv.org (Preben Randhol)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: A7V8X-X and lm sensors
Message-Id: <20030919155609.GA28605@pvv.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030918153623.GA3679@pvv.org>
In-Reply-To: <20030918153623.GA3679@pvv.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare <khali@linux-fr.org> wrote on 19/09/2003 (16:53) :
> 
> > Ah good, because I can fit my data with an exp function (have some
> > more
> > measurments now).
> > 
> >   13.71*(^(0.029116*@))
> > 
> > and back should be
> > 
> >   ((`@)-(`(13.71)))/0.029116
> 
> I suspect that (`(@/13.71))/0.029116 will be faster (untested).

Probably but it gives rounding errors. Tested in gnumeric.

> The (very short) relevant threads are here:
> http://archives.andrew.net.au/lm-sensors/msg02813.html
> http://archives.andrew.net.au/lm-sensors/msg02850.html
> You'll find Gary's address in the first post.

Thanks I'll contact him.

> Please CC: the list if your discussion is of public interest (and I
> believe it will be).

Will keep you updated.

-- 
Preben Randhol ------------- http://www.pvv.org/~randhol/vim --
                 "Vim : simply the best text editor out there."
