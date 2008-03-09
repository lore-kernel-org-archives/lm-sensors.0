From: Joakim Larsson <joakim@bildrulle.nu>
Date: Sun, 09 Mar 2008 19:08:47 +0000
Subject: Re: [lm-sensors] lm78 detected as W83627DHG on MSI board
Message-Id: <1205089727.11650.12.camel@montecristo>
List-Id: <lm-sensors.vger.kernel.org>
References: <1204653201.6143.18.camel@montecristo>
In-Reply-To: <1204653201.6143.18.camel@montecristo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

thanks for the respons!

On Sun, 2008-03-09 at 13:55 +0100, Jean Delvare wrote:
> For those of us not familiar with Ubuntu distribution names, can you
> please tell us what version of the linux kernel and what version of
> sensors-detect all these distributions are running? That's all we
> really care about.

Ubuntu Feisty has kernel 2.6.20 now at Ubuntu patch level 16
Ubuntu Dapper has kernel 2.6.15 now at Ubuntu patch level 51

I downloaded the latest sensors-detect script from lm-sensors.org

<snip>

> > So I suspect that the latest sensors-detect script is doing something
> > wrong.
> 
> I don't think so. sensors-detect tells that you have a W83627DHG and I
> believe it is true. However,
> http://www.lm-sensors.org/wiki/Devices
> says that support for this chip was only added in kernel 2.6.21, while
> you're apparently running 2.6.20. This explains why the w83627ehf
> driver says "no device found".

Got it, I'll try to backport the 2.6.20 code as a module and see if it
loads.

// joakim


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
