From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 01 Mar 2007 08:54:04 +0000
Subject: [lm-sensors] Sensors-detect with DMI detection
Message-Id: <20070301095404.d64544ef.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
In-Reply-To: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Thu, 01 Mar 2007 09:13:36 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > It might be non-trivial to determine which fields contain relevant
> > information and which do not. If the fields are empty it's clear they
> > aren't relevant, but sometimes vendors put random crap in the fields
> > instead, such as "None" or "System Manufacturer" or "To Be Filled By
> > O.E.M.". Anyway, as Hans suggested, we don't really need to find out
> > which fields are most relevant. We can use all four fields as the key
> > to identify the motherboard, if parts of the key aren't meaningful it
> > doesn't really matter.
> 
> Exactly, except when the whole key isn't relevant, iow all 4 Fields 
> contain crap / are to generic to uniquely identify a motherboard.

True, this kind of board exists :(

> That is why we need a queue on the website for new motherboard dmi-info 
> + lm-sensors-config submissions, and that queue needs to be checked 
> manually, we cannot expect well meaning end-users to make the decission 
> of the DMI info is unique enough. And on top of that a rating system 
> where people can say, good config works for me too, or crappy config 
> doesn't work.

Another approach is to let the submissions go through but in an
"unconfirmed" state. If two unconfirmed sumbissions have the same DMI
signature but list different drivers, we demote them to state "bogus"
or something similar.

Anyway, I don't really care about the exact implementation, it's up to
your students. Now that they are aware that the DMI data might not be
100% reliable, I'm certain they'll come up with a solution.

-- 
Jean Delvare

