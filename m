From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 20 Oct 2009 11:48:48 +0000
Subject: Re: [lm-sensors] Gigabyte GA-P35-DS3P - VID Zero value
Message-Id: <20091020134848.2c3188bc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
In-Reply-To: <20091019164516.701032uxlen5ai2k@mail.simonandkate.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Adam,

On Tue, 20 Oct 2009 21:03:50 +1000, Adam Nielsen wrote:
> It's a shame there's no "passthrough" vrm version that disables the formula
> and shows the raw vid value, as that would probably be quite helpful.  Maybe
> it's worth adding a patch to do just that?

This is an interesting idea, however there is a technical problem:
different CPU models have a different number of VID pins. If you need
the pass-through mode, it means the kernel doesn't know about your CPU
model, so it doesn't know how many bits should be read from the chip
and exported.

Another problem is the voltage levels. Different VRM standards use
different voltage levels. Some chips support different modes through
configuration, and the right mode depends on the CPU family. In a
perfect world the BIOS would set it up properly, but experience as
shown this isn't always the case, and as a result some of our drivers
change the mode based on the CPU model. This can't be done if VID
decoding is done in user-space.

So I'm not saying pass-through VID values are a bad idea... but if you
want to implement this, it's not a one-hour hack. It will take some
thoughts and time.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
