From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Mar 2010 08:21:33 +0000
Subject: Re: [lm-sensors] where to download the drivers?
Message-Id: <20100330102133.2ee97fba@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <8ec04b4f1003292023k33bffbb1te182f8bebf2f63a@mail.gmail.com>
In-Reply-To: <8ec04b4f1003292023k33bffbb1te182f8bebf2f63a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Xiaofei,

On Mon, 29 Mar 2010 23:23:48 -0400, Xiaofei Kemp wrote:
> I installed the lm-sensors in my centOS nodes, but there are drivers
> missing, I can not find the address to down load the driver's
> packages, such as coretemp. Could you please let me know where I can
> get them?

The drivers are in the kernel, we no longer provide them as part of the
lm-sensors package.

A few drivers are additionally available as standalone files. I've
gathered a number of them at:
http://khali.linux-fr.org/devel/misc/
You'll find the coretemp driver there, in particular. Please note that
we do not make any guarantee on these standalone drivers, they are not
tracking the latest upstream drivers and are only sync'd manually from
times to times. There is also no guarantee that they will work on
arbitrarily older kernels. They are generally meant to work for the
kernel that was used for the original backport and that's about it.

I've just sync'd the coretemp driver, so if that's all you need, you
can pick it and give it a try.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
