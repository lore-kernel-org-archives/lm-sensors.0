From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Fri, 01 Feb 2008 02:52:47 +0000
Subject: Re: [lm-sensors] failed to load it87 module on IT8712F
Message-Id: <20080201025247.GG20687@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <002001c8641e$71d8f6e0$180411ac@EDVW14>
In-Reply-To: <002001c8641e$71d8f6e0$180411ac@EDVW14>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Peter:

* Peter Eser <Peter.Eser@heuft.com> [2008-01-31 16:32:10 +0100]:
>    Hello,
> 
>    I have a Aeeon PCM8120 board with VIA CX700M.
>    On the VIA homepage its equipped with VT1211.
>    But on board I find a (additional?) IT8712F and
>    sensors detect finds only this one and says: (but not activated).
>    modprobe vt1211 and it87 both say no such device.
> 
>    Bus module i2c-viapro has no problem.
>    All is standard kernel 2.6.24.
> 
>    The sad thing is I have the it87 module running under
>    kernel 2.2 (because the board is a replacement for an older
>    one running on this old kernel, by the way this kernel is
>    running fine on the new board). Can modprobe it87 with i2c-isa
>    on the old kernel and get fan,temperatures,voltages.
> 
>    Any help would be great,

Are there any interesting messages in the kernel log when running
2.6.24?  If so, please send them.  Also, please send a copy of your
kernel config.

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
