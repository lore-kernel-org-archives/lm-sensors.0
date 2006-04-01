From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 01 Apr 2006 12:48:26 +0000
Subject: [lm-sensors] 2.6.16-rc5: unreasonable temperature reported by
Message-Id: <20060401144826.239779e9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44144A01.2050207@t-online.de>
In-Reply-To: <44144A01.2050207@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Harald,

> > I was about to say "No idea about this one", as it has very few
> > registers and no noticeable patterns, but that "19 34" at 0x5d reminds
> > me of the Fintek signature in my F71805F Super-I/O chip. Can you please
> > search your motherboard for a Fintek chip, presumably small?
> 
> I found a small chip close to the socket for an additional fan.
> 16 pins. AFAICS it says F75387SG, but it was very hard to read
> even with a looking glass. Esp. the "S" looks suspicious.
> 
> Using "fintek F75387SG" I found this on Google:
> 
> http://www.fintek.com.tw/files/productfiles/F75387_025P%20datasheet.pdf
> 
> BTW, my PC is an Aopen MZ915-M .

Good catch. This is, indeed, the chip that sensors-detect spotted at
address 0x2d. I just modified this script so that it now knows about
more Fintek chips. Please give it a try:
http://www2.lm-sensors.nu/%7Elm78/cvs/lm_sensors2/prog/detect/sensors-detect

It should properly identify your F75387SG/RG chip at 0x2d now.

I still don't know what is the other Fintek chip at 0x2f. Its it
doesn't match any ID I could find in the datasheets, but it's similar
enough to the F75121R and F75122R/RG ID that I'd bet for some VID
and/or GPIO chip. My contact at Fintek told me it was a "power
control", I hope to have additional information soon. Maybe you can
take a look at your motherboard again in the meantime.

So, the good news is that we now know what hardware monitoring chip you
have. This explains why the W83627THF chip was not reporting the values
you were expecting.

The bad news is that we have no driver for this chip at the moment.
I've added it to our "New drivers" page, together with a few other
Fintek chips. You'll have to wait for a driver to be written, or write
it yourself. Any amount of support (work, money, hardware...) you can
offer is likely to speed up the process.

-- 
Jean Delvare

