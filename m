From: jordan.crouse@amd.com (Jordan Crouse)
Date: Fri, 17 Feb 2006 16:29:22 +0000
Subject: [lm-sensors] Add LM82 support
Message-Id: <20060217162922.GP20157@cosmic.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060216175930.GE20157@cosmic.amd.com>
 <LYRIS-4270-26349-2006.02.17-07.32.29--jordan.crouse#amd.com@whitestar.amd.com>
In-Reply-To: <LYRIS-4270-26349-2006.02.17-07.32.29--jordan.crouse#amd.com@whitestar.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Warne <nick@linicks.net>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com, Jean Delvare <khali@linux-fr.org>

On 17/02/06 13:09 +0000, Nick Warne wrote:
> '
> >                 if (kind <= 0) { /* identification failed */
> > @@ -296,10 +318,15 @@ static int lm83_detect(struct i2c_adapte
> >         if (kind = lm83) {
> >                 name = "lm83";
> >         }
> > +       else if (kind = lm82) {
> > +               name = "lm82";
> > +       }
> 
> Is that a '=' typo in the 'else if' there?

Yep - thats what that would be.  That must be my typo of the week, since
I just had it in another driver I'm writing.  I'll post a fixup here
very shortly with all the comments.

Jordan 

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>


