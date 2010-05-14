From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Fri, 14 May 2010 03:20:01 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 V3] hwmon: (coretemp) Detect the
Message-Id: <20100514032000.GB17786@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100507095459.GA12190@owl>
 <20100510033525.GC9181@owl>
 <20100511080112.GB19762@owl>
In-Reply-To: <20100511080112.GB19762@owl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Huaxu Wan <huaxu.wan@linux.intel.com>
Cc: huaxu.wan@intel.com, Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, 11 May 2010, Huaxu Wan wrote:
> +                       printk(KERN_INFO DRVNAME ": CPU (model=0x%x)"
> +                               " has no thermal sensor!\n", c->x86_model);

IMHO, it is better to drop that "!" since it is now a simple status message,
otherwise it still looks like there is something wrong with the CPU not
having a thermal sensor.

Minor thing, really, so feel free to ignore this comment.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
