From: Helmut Grohne <helmut@subdivi.de>
Date: Wed, 12 Mar 2008 16:09:17 +0000
Subject: Re: [lm-sensors] serious w83627ehf problem stopping cpu fan
Message-Id: <20080312160838.GA2128@alf.mars>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080312011430.GA20751@alf.mars>
In-Reply-To: <20080312011430.GA20751@alf.mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

This is a summary of the irc discussion on #linux-sensors with Jean
Delvare and Rudolf Ruik Marek.

First and most important: Unloading the thermal module makes the /sys
interface of w83627ehf behave normally, so the problem boils down to
the module interfering with each other.

Secondly my dsdt is buggy. I do not know whether the bugs are visible.
Errors like this one look like they may have an effect:

dsdt.dsl   786:                 Method (GHTF, 0, NotSerialized)
Warning  1086 -                            ^ Not all control paths return a value (GHTF)

Helmut

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
