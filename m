From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Sep 2009 07:46:03 +0000
Subject: Re: [lm-sensors] Creating alarm for fans
Message-Id: <20090906094603.7da21e3d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9823A2.2010907@xtronics.com>
In-Reply-To: <4A9823A2.2010907@xtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 05 Sep 2009 17:13:01 -0500, Karl Schmidt wrote:
> Jean Delvare wrote:
> 
> > 
> > You forgot to rmmod dme1737 beforehand, which makes the output
> > uninteresting.
> 
> once again attached

As you can see it never suggests loading the lm85 driver. So I don't
know where this line came from in your /etc/modules file. A legacy from
a previous installation maybe?

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
