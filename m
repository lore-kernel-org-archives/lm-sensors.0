From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Ticket #: 758, ITE IT8712F-A not detected, and not
Message-Id: <3C37271B.69CF436D@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0112191715470.14694-100000@flow.fuw.edu.pl>
In-Reply-To: <Pine.LNX.4.33.0112191715470.14694-100000@flow.fuw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

#1 I fixed by increasing it87 confidence to 8 in CVS.
#2 You are correct, at the least a warning message should be issued.
   Too difficult for my perl skills but if you would like to contribute
   a patch that would be great.
mds

Jakub Narebski wrote:
> 
> On Fri, 4 Jan 2002, Mark Studebaker wrote:
> 
> > If you send me the isadump output, then I can check,
> > but since the it87 has some mfr ID registers that the LM78 doesn't have,
> > we can be more confident that it's an IT87 if both are recognized,
> > and we should recommend it over the LM78.
> 
> Thats O.K.
> 
> > Isn't that what you wanted? I thought that's what you were complaining about.
> 
> There are two fairly orthogonal aspects:
> 
> 1. If LM78 cannot be recognized as IT87, and IT87 is misrecognized as LM87
> then of course IT87 should have higher confidence.
> 
> 2. If two chips have the same confidence, none should be preffered and the
> choice should be left to user (look at your motherboard).
> 
> --
> Jakub Nar?bski
>     Poland
