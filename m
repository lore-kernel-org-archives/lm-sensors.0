From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Wed, 15 Sep 2010 15:52:06 +0000
Subject: Re: [lm-sensors] [patch 00/36] New w83795 driver
Message-Id: <20100915155206.GE20558@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100915154005.448afabb@hyperion.delvare>
In-Reply-To: <20100915154005.448afabb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 15 Sep 2010, Jean Delvare wrote:
> This is a new driver for the Winbond/Nuvoton W83795G/ADG hardware
> monitoring chips. The original code was contributed by Wei Song, a
> former employee of Nuvoton. I've fixed and improved a lot of things
> on top of his work.

You've gotten yourself a tester: I have one of those in my main desktop
(SuperMicro C7X58 v1.1).  I just have to backport the driver to 2.6.32.y
to test it there.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
