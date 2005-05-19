From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:54 +0000
Subject: I2C 2.1 support for High Speed I2C, 3.4 Mb/s
Message-Id: <426AE933.5030604@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <71555548814716479478431542AA5F8A0276739C@dlee2k04.ent.ti.com>
In-Reply-To: <71555548814716479478431542AA5F8A0276739C@dlee2k04.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I don't think anybody's ever asked us about it, much less worked on it.
Looks like HS mode was defined in I2C V2.0 in 1998.

Would you be working on a bit-banging driver or is here an I2C bus master
out there supporting HS mode?

If you are going to write a driver please keep in touch and let us know
how it's going and what API extensions you propose.

If a bit-banger big desision is to mod and/or start from i2c-algo-bit or i2c-algo-biths.
algo-bit is 33% duty cycle, biths is 50% duty cycle and in theory can
go faster. However i2c spec says HS mode is 33% duty cycle. Go figure.
See TODO for more info.

mds



Woodruff, Richard wrote:
> Hello,
> 
> I just started grep'ing around to see if HS I2C support is implemented
> and have not found anything.
> 
> Has any one used this with Linux before?  The Spec would indicate that a
> slow/fast preamble of sorts is used followed by fast data transfers.
> 
> We will likely add a driver if none exists, but knowing its been done
> before is always comforting. 
> 
> Regards/Thanks,
> Richard W.
> 

