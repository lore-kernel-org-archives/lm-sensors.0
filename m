From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: question about the fanXpwm
Message-Id: <AjdwSOfQ.1106813928.2419620.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501270322.51522.ireo@o2.pl>
In-Reply-To: <200501270322.51522.ireo@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

> i use debian unstable with 2.6.8 kernel with latest lm_sensors package on
> gigabyte GA-8IPE 1000 PRO2 motherboard. I know that this MB has the feature
> of software fan speed control, because of gigabyte give such type of
> program which run under windows.

Fan speed control is actually a hardware thing.

> after scanning with sensors-detect everything is ok /only temp 2 and 3 are
> reversed/.

Simple matter of labelling. Open /etc/sensors.conf, search for the it87
section, edit the label temp2 and label3 lines.

> it runs on ISA bus. the fan speed control is only thing undetected.
> it is any chance to correct this sitaution? i'll be very glad if You can
> help me.

Support for fan speed control was just added to the it87 driver in the
linux 2.6.10-rc2 kernel. All you will need is a new kernel at least that
recent. Note that support being new, it wasn't widely tested and should
be considered experimental.

--
Jean Delvare
