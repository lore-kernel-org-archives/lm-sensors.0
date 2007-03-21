From: curt@curtronics.com (Curt Blank)
Date: Wed, 21 Mar 2007 17:52:14 +0000
Subject: [lm-sensors] SUCCESS! Re: MSI K9N4 SLI-F sensors-detect says
Message-Id: <Pine.LNX.4.63.0703211249070.8298@www.curtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4600D064.1020703@curtronics.com>
In-Reply-To: <4600D064.1020703@curtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Wed, 21 Mar 2007, Curt Blank wrote:

> 
> 
> On Wed, 21 Mar 2007, David Hubbard wrote:
> 
> > Hi Curt,
> > 
> > On 3/21/07, Curt Blank <curt at curtronics.com> wrote:
> > > Hi Jan,
> > >
> > > Thanks for the information. I wasn't sure about the semaphores and I
> > > noticed they were no longer used in the 2.6.21 code at all so I thought
> > > just to be safe I'd switch them to mutexes. I wanted to match the code as
> > > close as possible to minimize any problems with doing the port and I'm not
> > > concerned about size.
> > >
> > > As for the Device ID, I saw the masking, but I could not get it to work
> > > with just the 0xa020. I kept getting this:
> > >
> > > Mar 21 00:39:14 bnfsrvr kernel: w83627ehf: unsupported chip ID: 0xffff
> > > Mar 21 00:39:14 bnfsrvr kernel: w83627ehf: unsupported chip ID: 0xa023
> > >
> > > Then when I added the 0xa023 definition and changed the mask to 0xFFF3 it
> > > worked.
> > >
> > > Ah-ha-ha. I think I see the error in my ways. All I needed to do was
> > > change the mask to 0xFFE0. I'll give that a try. Always like to do things
> > > the same. It was late, I was getting tired and starting to wonder if I'd
> > > ever get it to work. Being refreshed and with your help it was now easy to
> > > spot this.
> > >
> > > And, when you get the schematic for this MB, I would greatly appreciate it
> > > if you could tell me what input is what voltage. I will do it myself if
> > > it's possible for me to get a copy of the schematic. I'd also lik to see
> > > if the Northbridge fan is connected to the w83627dhg. Then I'd know for
> > > sure if I should be seeing its RPM.
> > >
> > > -Curt
> > 
> > You'll want to put your replies at the bottom of the email. If you
> > were getting unknown device ID, we should probably add another device
> > ID to the driver (0xa020 ?). I'll take a look at it when I get home
> > tonight.
> > 
> > David
> > 
> > 
> 
> Hi David, 
> 
> Ok, will do. pine puts me at the top so I just type.
> 
> No I think the Device ID issue is due to the mask needing to be 0xFFE0 as 
> Jan pointed out. I'm going to change that and try it.
> 
> -Curt
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

Hi again David,

Test complete. By changing the mask to 0xFFE0 the W83627DHG is recognized 
by the w83627ehf driver using 0xa020 and works. You don't need to add 
another ID to look for.

-Curt



