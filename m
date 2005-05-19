From: bma@tynian.net (Brian Almeida)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: lm-sensors support for ASUS chip ASB100 Bach
Message-Id: <20030712165216.GJ10176@tynian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <795E03B0F1E26C449762C0EDF5F5659140F50F@Exchange.16.172.in-addr.arpa>
In-Reply-To: <795E03B0F1E26C449762C0EDF5F5659140F50F@Exchange.16.172.in-addr.arpa>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 13 Apr 2003, Mark M. Hoffman wrote:
> I think (but I'm not certain) that most of the problems with 
> Asus support are for actual AS99127.  As written, ASB100 works
> well enough for me.  I've heard some Athlon owners found another
> register that gives better CPU temps, but I haven't seen a patch
> for it.

Hi,

I wrote a small patch which reports the same values that xmbmon
does.  It breaks other AS99127 chips right now, but it works
on my A7V8X.  The reason for this is because the 0x17 register
holds the actual temp in Celcius, which doesn't work well
with the TEMP_FROM_REG macros (the >> 7 zeroes the value).
So I added a conditional which multiplies the raw value by 10
instead.  After that, the correct value is reported.
I chose temp3 to modify instead of temp2 because temp2 matches
the temp3 value that xmbmon reports (chipset).

Maybe someone else with more knowledge of lm-sensors than I can clean 
this up for insertion into upstream. Also note that the limit and 
hysteresis values are incorrect. A reference chart I found at
http://home.kabelfoon.nl/~bertrik/asb100/asb100.html 
listed 0x18 and 0x19 as possible locations for them, but 
a w83781d_read_value returns a 0 for those locations.

You can find the patch at http://tynian.net/asb100/

-- 
Brian Almeida     | http://tynian.net        | bma@tynian.net
Debian Developer  | http://www.debian.org    | bma@debian.org
