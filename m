From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Sep 2009 21:04:41 +0000
Subject: Re: [lm-sensors] Creating alarm for fans
Message-Id: <20090905230441.30d95685@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9823A2.2010907@xtronics.com>
In-Reply-To: <4A9823A2.2010907@xtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 05 Sep 2009 14:16:15 -0500, Karl Schmidt wrote:
> Jean Delvare wrote:
> >> This is a Tyan S2865
> 
> 
> I figured you would want a new listing of this:
> 
> 
> > #i2cdump 1 0x2e
> > No size specified (using byte-data access)
> > Error: Could not open file `/dev/i2c-1' or `/dev/i2c/1': No such file or directory
> 
> 
> 
> oops?? Not what I expected.

You forgot: modprobe i2c-dev.

> When this is all over - I will document it up and have a sensors3.conf file to share. Is there a web 
> site for sharing these? (I will also send a copy to Tyan).

We have a section in the wiki:
http://www.lm-sensors.org/wiki/Configurations

If you post your config on the list, we can add it there. Or if you
intend to contribute more, we can even create a wiki account for you.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
