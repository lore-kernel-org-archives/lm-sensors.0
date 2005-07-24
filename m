From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 24 Jul 2005 20:20:32 +0000
Subject: [lm-sensors] ASUS P5WD2 Premium - Winbond 83627EHG-A
Message-Id: <20050724202030.227f0ab5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42D27327.7050402@internode.on.net>
In-Reply-To: <42D27327.7050402@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Timothy,

> My sincere thanks to you (and greg) for your help getting this
> working, I'm absolutely elated. I've fired up my fravorite gkRellm,
> and its picked up all the sensors perfectly.

Glad to know it works :)

I'll go update our documentation to mention that the W83627EHF and
W83627EHG chips are compatible.

> I did notice it didnt pick up the  voltages (not that I'm all that
> interested in voltage),

The driver is only half coded. I did fan and temperature monitoring,
because I think that's what most people are interested in. I'd have done
more but had many other things to do and no hardware to test my code so
my progress was too slow.

> if I only understood the code a little better (and the spec provided
> by Winbond), I'd be happy to keep working on the driver to add
> anything else in. But I'm not sure I understand hex adressing that
> well, and I'd probably be a hinderance more than a help. Having said
> that, if theres anything I can do to help, just let me know. (sorry I
> dont have a spare P5WD2 to send you I'm afraid)

Well, I guess you can get in touch with Cadu, who is working on
extending this driver. If you can test his code when he is done, I guess
he will appreciate.

If someone is willing to send me a socket 939 motherboard with a
W83627EHF or W83627EHG on board, I will be happy to go on hacking the
driver myself.

-- 
Jean Delvare
