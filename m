From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 04 Mar 2009 18:00:35 +0000
Subject: Re: [lm-sensors] Family 10h
Message-Id: <20090304190035.11181c64@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <2e92ef460903021416h6ae51fc5qbb8bdd19565beafa@mail.gmail.com>
In-Reply-To: <2e92ef460903021416h6ae51fc5qbb8bdd19565beafa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2 Mar 2009 14:16:29 -0800, Joseph Roberts wrote:
> >From what  I've read on Phoronix there have been patches / work for
> Family 10h proccessors since early 2008, and according to this
> http://www.phoronix.com/scan.php?page=news_item&px=NzA2NA support for
> the 45nm CPUs (I own a PhenomII 940) was supposed to be included in
> 3.1.0, that doesn't appear to be the case though.

Hardware support is a kernel thing, lm-sensors 3.1.0 has almost nothing
to do with it.

> Just curious why it's taking so long for these to be supported? Is
> this project relatively undermanned? lack of resources?

Lack of a maintainer for the hwmon subsystem of the Linux kernel.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
