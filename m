From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Additional info for ticket #1148
Message-Id: <20030612112820.330991c4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1054890869.11041.3.camel@nazgul>
In-Reply-To: <1054890869.11041.3.camel@nazgul>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Nope, it turned out I just needed to change the force_subclients
> option a little, instead of:
> 
> force_subclients=0,0x2c,0x4a,0x4b
> 
> I had to use:
> 
> force_subclients=1,0x2c,0x4a,0x4b
> 
> I have a feeling that the 1 is because my tvtuner card is showing up
> as/proc/bus/i2c-0 so my sensors are being bumped to 1?, but I'm not
> sure if that's what the number in the option means or not, all working
> well now though (for the first time in 6 months since I got the board
> ;) -Dan

Yes, you're right.

What about Mark's suggestion?
> The address of the first chip to be recognized (the 627HF in your
> case) should be the 2nd argument to force_subclients.
> It probably isn't; fix it and it should work.

Where did you find the addresses you're trying to force? Recopied from
the ticket? I think you have to find the addresses by yourself using
"i2cdetect 1".

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
