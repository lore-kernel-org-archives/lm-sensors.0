From: cadu@nerdfeliz.com (Carlos Eduardo Medaglia Dyonisio)
Date: Mon, 25 Jul 2005 15:06:25 +0000
Subject: [lm-sensors] ASUS P5WD2 Premium - Winbond 83627EHG-A
Message-Id: <20050725100858.3af4e147.cadu@nerdfeliz.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42D27327.7050402@internode.on.net>
In-Reply-To: <42D27327.7050402@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 24 Jul 2005 20:20:30 +0200
Jean Delvare <khali@linux-fr.org> wrote:

Hi all!

> > I did notice it didnt pick up the  voltages (not that I'm all that
> > interested in voltage),
> 
> The driver is only half coded. I did fan and temperature monitoring,
> because I think that's what most people are interested in. I'd have done
> more but had many other things to do and no hardware to test my code so
> my progress was too slow.

Sorry. I was working on it (and it's easy to make), but in the last
weeks I was so busy... I'm so sorry.

> > if I only understood the code a little better (and the spec provided
> > by Winbond), I'd be happy to keep working on the driver to add
> > anything else in. But I'm not sure I understand hex adressing that
> > well, and I'd probably be a hinderance more than a help. Having said
> > that, if theres anything I can do to help, just let me know. (sorry I
> > dont have a spare P5WD2 to send you I'm afraid)
> 
> Well, I guess you can get in touch with Cadu, who is working on
> extending this driver. If you can test his code when he is done, I guess
> he will appreciate.
> 
> If someone is willing to send me a socket 939 motherboard with a
> W83627EHF or W83627EHG on board, I will be happy to go on hacking the
> driver myself.

In this week I will have time to work on it. I hope I will have a patch
this week with voltage support. Timothy, please stay in touch with me.
I'll be pleasure if you can help me to test the code (and maybe to hack
the code ;) )!

Thanks!
Cadu
