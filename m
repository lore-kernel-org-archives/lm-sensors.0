From: se.witt@gmx.net (Sebastian Witt)
Date: Fri, 17 Jun 2005 15:06:13 +0000
Subject: [lm-sensors] [PATCH]: Add automatic PWM mode to it87.c
Message-Id: <42B85D84.1010803@hasw.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <429CEBC2.80609@hasw.net>
In-Reply-To: <429CEBC2.80609@hasw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've found out that I made a mistake: I used the IT8712_V07 datasheet and
not the datasheet for the IT8705F. That's because my last board has
a IT8712F and my current board has now a IT8705F...seen it while
trying to get the VID reading.

However the automatic fan control registers/values are on both chipsets the
same, I haven't seen a difference in the datasheets. So automatic
fan control should work on both chipsets. The check for revision/version
should be fixed.

Regards,
Sebastian
