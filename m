From: pasik@iki.fi (Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?=)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [RFT] Preliminary w83627ehf hardware monitoring driver
Message-Id: <20050228075012.GN25818@edu.joroinen.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050226191142.6288b2ef.khali@linux-fr.org> <20050227131027.GM25818@edu.joroinen.fi> <20050227184837.2563a454.khali@linux-fr.org>
In-Reply-To: <20050227184837.2563a454.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>

On Sun, Feb 27, 2005 at 06:48:37PM +0100, Jean Delvare wrote:
> Hi Pasi,
> 
> > Do you know about driver for W83627THF watchdog? I'm using Supermicro
> > P8SCI motherboard, and I haven't found working driver for it..
> 
> Have you tried w83627hf_wdt? I took a quick look at the W83627HF and
> W83627THF datasheets and watchdog timer seems to work identically. Since
> the driver doesn't seem to identify the chip (it probably should, BTW),
> I'd expect it to work.
> 

Yes, I have tried it. It doesn't work. 

The machine reboots always after the watchdog timeout set in the BIOS. I've
tried with the example watchdog daemon from the watchdog.txt, and with the
Debian "watchdog" package.

When I enable the debug messages and logging in the Debian watchdog package,
I can see that the watchdog daemon gets stuck while trying to update the
/dev/watchdog.. so the driver hangs..

-- Pasi K?rkk?inen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
