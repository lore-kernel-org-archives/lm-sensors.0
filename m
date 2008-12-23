From: Matt Roberds <mattroberds@cox.net>
Date: Tue, 23 Dec 2008 18:38:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add a driver for the ADT7475
Message-Id: <Pine.LNX.4.64.0812231232540.20885@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080610194818.GA21150@cosmic.amd.com>
In-Reply-To: <20080610194818.GA21150@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 23 Dec 2008, Daimonos Tereutes wrote:
> I'm using the patch for ADT7475 since the begining on an ASUS M2N32 WS
> Professional without problem.

It looks like you might be using a modified version of this
sensors3.conf :
http://www.lm-sensors.org/wiki/Configurations/Asus/M2N-SLI%20Deluxe

On your board, it seems like it8716 in2 (+3.3 V) works, and it8716 temp3
is chassis temp.  Also, the assignment of fans (CPU/chassis/power
supply) to chip inputs is a little different.  If you have verified that
the labels are correct, can you post your sensors3.conf here on the
list?  This will help it get to the wiki as a reference for others.

Thanks!

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
