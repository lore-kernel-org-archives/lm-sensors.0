From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 15:55:46 +0000
Subject: Re: [lm-sensors] [patch 00/36] New w83795 driver
Message-Id: <20100915175546.7949010d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100915154005.448afabb@hyperion.delvare>
In-Reply-To: <20100915154005.448afabb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henrique,

On Wed, 15 Sep 2010 12:52:06 -0300, Henrique de Moraes Holschuh wrote:
> On Wed, 15 Sep 2010, Jean Delvare wrote:
> > This is a new driver for the Winbond/Nuvoton W83795G/ADG hardware
> > monitoring chips. The original code was contributed by Wei Song, a
> > former employee of Nuvoton. I've fixed and improved a lot of things
> > on top of his work.
> 
> You've gotten yourself a tester: I have one of those in my main desktop
> (SuperMicro C7X58 v1.1).  I just have to backport the driver to 2.6.32.y
> to test it there.

You don't even have to, as I did it for you already:
http://khali.linux-fr.org/devel/misc/w83795/

If you find any problem with the driver, please let me know!

(Note: monitoring should work OK now, but I didn't have the time to
work on fan speed control yet, so I expect bugs in this area.)

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
