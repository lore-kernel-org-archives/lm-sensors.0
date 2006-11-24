From: r.marek@assembler.cz (Rudolf Marek)
Date: Fri, 24 Nov 2006 12:31:00 +0000
Subject: [lm-sensors] [PATCH] driver for SMSC SCH311x
Message-Id: <4566E604.8070008@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200607241255.42688.Marcin.Dawidowicz@kontron.pl>
In-Reply-To: <200607241255.42688.Marcin.Dawidowicz@kontron.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Alan,

Sorry for the delay.

Alan Pettitt wrote:
> I have installed your patch for the SCH311x on a Kontron 6012 processor
> board using Redhat linux 2.6.18. After doing a modprobe I now get:
> 
> sch311x-isa-0a70
> Adapter: ISA adapter
> 
> 
> but no further information. Is there something I am missing ?

Yes you are missing userspace support (the generic support is not yet ready). 
Maybe Marcin will have something? I'm ccing him.

You may access the chip through sysfs interface /sys/class/hwmon*/device/...

Rudolf

