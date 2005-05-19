From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: CONFIG_xxxx inconsistency
Message-Id: <3BE867FC.733F177E@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20011028233121.A2816@werewolf.able.es>
In-Reply-To: <20011028233121.A2816@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

actually kernel 2.4.13 includes a big i2c update, the first since January.

"J . A . Magallon" wrote:
> 
> On 20011031 Mark D. Studebaker wrote:
> >Now I'm wondering if we changed things in the wrong direction.
> >Rather than going from "old" to "new" should we have gone
> >from "new" to "old".
> >
> >Since the kernel has "old" CONFIG_xxx things,
> >won't us changing things lead to problems with compiles outside
> >of the kernel (which check for definitions of CONFIG_xxx)
> >and also unnecessary patches?
> >
> >Seems like it would be safer to go back to the "old" and
> >make sure the few places that used "new" were switched to "old".
> >
> >what do you all think?
> >
> 
> I have seen that cvs code for i2c has not changed since time ago.
> What about submitting an update to Linus/Alan with the remaining changes
> (version info..) and the new config names ? Even you can call it
> 2.6.2.
> 
> --
> J.A. Magallon                           #  Let the source be with you...
> mailto:jamagallon@able.es
> Mandrake Linux release 8.2 (Cooker) for i586
> Linux werewolf 2.4.13-ac5-beo #1 SMP Tue Oct 30 00:10:00 CET 2001 i686
