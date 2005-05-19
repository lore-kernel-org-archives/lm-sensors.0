From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: database
Message-Id: <3DB33E6C.331D058F@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <89950000.1034392779@krabat.ahsoftware>
In-Reply-To: <89950000.1034392779@krabat.ahsoftware>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you're on the right track.
Didn't realize submissions didn't work yet :)

You can take defaults from the current etc/sensors.conf.eg.
Sorry I don't quite understand your gl518sm question.

The file doc/developers/proc may also give you some good info.

I would change "inputs" to "voltage inputs".
Also, fans and temps can have compute lines, not just voltages.

mds


Alexander Holler wrote:
> 
> Hi Mark,
> 
> --On Donnerstag, Oktober 17, 2002 09:43:42 -0400 Mark Studebaker
> <mds@paradyne.com> wrote:
> 
> > way cool. what a great start.
> > I think it's ready for a link on our home page.
> 
> Uh, but it isn't working.
> 
> > A couple of suggestions for the database page -
> > - a link back to our home page would be good
> > - A link for comments/suggestions/bugs would be good. Do we want them to
> > submit   bugs on berlios, or email Alexander, or email sensors?
> 
> I would prefer mail. But I have already enough mail. ;)
> 
> > - Some descriptions / disclaimers would be good. These are submitted by
> > users, not   verified or tested by us, etc, etc, etc
> > - some field in the database of who submitted the entry, how to contact,
> > etc.
> 
> ok, but up to now, nobody can submit anything. ;)
> 
> What I need to know is, if the system behind would work. E.g. on chip
> gl518sm there is a vdd and vin1, can I use label in0 "+5V" on that chip?
> 
> Regards,
> 
> Alexander
