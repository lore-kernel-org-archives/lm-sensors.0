From: curt@curtronics.com (Curt Blank)
Date: Wed, 21 Mar 2007 17:36:48 +0000
Subject: [lm-sensors] SUCCESS! Re: MSI K9N4 SLI-F sensors-detect says
Message-Id: <Pine.LNX.4.63.0703211220100.13243@www.curtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4600D064.1020703@curtronics.com>
In-Reply-To: <4600D064.1020703@curtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jan,

Thanks for the information. I wasn't sure about the semaphores and I 
noticed they were no longer used in the 2.6.21 code at all so I thought 
just to be safe I'd switch them to mutexes. I wanted to match the code as 
close as possible to minimize any problems with doing the port and I'm not 
concerned about size.

As for the Device ID, I saw the masking, but I could not get it to work 
with just the 0xa020. I kept getting this:

Mar 21 00:39:14 bnfsrvr kernel: w83627ehf: unsupported chip ID: 0xffff
Mar 21 00:39:14 bnfsrvr kernel: w83627ehf: unsupported chip ID: 0xa023

Then when I added the 0xa023 definition and changed the mask to 0xFFF3 it 
worked.

Ah-ha-ha. I think I see the error in my ways. All I needed to do was 
change the mask to 0xFFE0. I'll give that a try. Always like to do things 
the same. It was late, I was getting tired and starting to wonder if I'd 
ever get it to work. Being refreshed and with your help it was now easy to 
spot this.

And, when you get the schematic for this MB, I would greatly appreciate it 
if you could tell me what input is what voltage. I will do it myself if 
it's possible for me to get a copy of the schematic. I'd also lik to see 
if the Northbridge fan is connected to the w83627dhg. Then I'd know for 
sure if I should be seeing its RPM.

-Curt

On Wed, 21 Mar 2007, Jean Delvare wrote:

> Hi Curt,
> 
> On Wed, 21 Mar 2007 01:27:48 -0500, Curt Blank wrote:
> > Ok, I answered my own question, yes I can backport the w83627ehf driver 
> > from 2.6.21 to 2.6.16.
> > 
> > If anyone is interested I put the patches here:
> > 
> > http://www.curtronics.com/patches/
> > 
> > Not bad for one nights work.
> > 
> > Below is the living proof. The chip ID reported by the W83627DHG on this 
> > MB was different then what the 2.6.21 w83627ehf code looked for so now 
> > it looks for both. There are 4 fans connected to this MB but only 3 are 
> > showing up, the 4th is a MSI installed fan on the Northbridge chip. 
> > Maybe I can't see that one, I don't know at this point. I have to 
> > validate the voltages also, they don't look quite right.
> 
> Two comments about this patch:
> 
> 1* You didn't have to convert the semaphores to mutexes. This is a
> kernel-wide change that happened at one point in time, and is not
> related with the W83627DHG support at all. Without that change, your
> patch will be smaller.
> 
> 2* You do not need to change the device ID. If you look at the code,
> you'll see that we do explicitely mask out the lower bits, because they
> are _known_ to change depending on the exact chip revision. So the
> original code should work just fine for you too.
> 
> -- 
> Jean Delvare
> 

