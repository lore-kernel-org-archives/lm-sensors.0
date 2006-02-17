From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 17 Feb 2006 18:42:46 +0000
Subject: [lm-sensors] Add LM82 support
Message-Id: <20060217194246.1955d576.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060216175930.GE20157@cosmic.amd.com>
	<LYRIS-4270-26349-2006.02.17-07.32.29--jordan.crouse#amd.com@whitestar.amd.com>
	<20060217162922.GP20157@cosmic.amd.com>
In-Reply-To: <20060217162922.GP20157@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Nick Warne <nick@linicks.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com

Hi Jordan,

> On 17/02/06 13:09 +0000, Nick Warne wrote:
> > > +       else if (kind = lm82) {
> > > +               name = "lm82";
> > > +       }
> > 
> > Is that a '=' typo in the 'else if' there?
> 
> Yep - thats what that would be.  That must be my typo of the week, since
> I just had it in another driver I'm writing.

Given that gcc clearly warns on this kind of typo, how could it go
unnoticed?

-- 
Jean Delvare

