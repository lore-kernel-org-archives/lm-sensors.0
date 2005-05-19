From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: as99127f additional temps
Message-Id: <20040110134945.6e58ea97.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

From what I see in the w83781d driver, it is assumed that the as99127f
extra temperatures are 9 bit signed values with LSB = 0.25 degree C (as
opposed to LSB = 0.5 degree C in other winbond chips and lm75 itself).

What reason do we have for such an assumption?

I think we are wrong here, for the following reasons:

1* Asus chips are known to be copied from Winbond ones. I don't see any
reason they would change the LSB value. What's more, MMH's asb100 driver
uses standard lm75 conventions.

2* For all boards using the as99127f, a conversion is needed for temp2
and temp3 (which is not that frequent AFAIK), and the default is:
    compute temp2 @*2.0, @/2.0
    compute temp3 @*2.0, @/2.0
Which brings us back to a 0.5 LSB. I know that Asus are the recognized
international champions of senseless temperature conversions (as I have
experienced on my TX97-E) but let's not charge them with something they
probably haven't done.

So I propose that we use standard lm75 conversions for the as99127f
subclients. This will simplify the code much. Comments, objections?

BTW, MMH, would it make sense to move the as99127f support from w83781d
to asb100? I haven't looked at the code in deep myself yet, just
wondering if you have an opinion.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
