From: curt@curtronics.com (Curt Blank)
Date: Wed, 21 Mar 2007 17:15:55 +0000
Subject: [lm-sensors] SUCCESS! Re: MSI K9N4 SLI-F sensors-detect says
Message-Id: <Pine.LNX.4.63.0703211210440.617@www.curtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4600D064.1020703@curtronics.com>
In-Reply-To: <4600D064.1020703@curtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks. It was more work then I expected. If I knew how much work it was 
before I started I probably would not have done it.

As for the kernel, due to using applications supplied on the distro I tend 
to like to stay with the kernel version supplied. I don't have the time to 
modify the applications if need be.

As for the voltages, yes I'm aware of the conf file, but my question has 
always been, how do I know which is what? I'd be guessing at best. When 
Jan gets the schematic he can tell me which input is what voltage but 
right now I don't have a clue.

-Curt

On Wed, 21 Mar 2007, David Hubbard wrote:

> Hi Curt,
> 
> On 3/20/07, Curt Blank <Curt.Blank at curtronics.com> wrote:
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
> >
> > -Curt
> 
> Good work. I am not surprised that the driver works in 2.6.16, since
> it works in 2.6.17. If your voltages are slightly off, you'll just
> need to edit /etc/sensors.conf and change the voltage formulas. (The
> voltages are determined by resistors on the motherboard, so it's a
> manufacturer and motherboard-specific decision how the voltages are
> actually measured.)
> 
> David
> 

