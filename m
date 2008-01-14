From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 14 Jan 2008 17:04:57 +0000
Subject: Re: [lm-sensors] lm85 in Intel S3000AH case
Message-Id: <20080114180457.69e99177@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <00d601c8556a$69d1ca70$0204a8c0@IT>
In-Reply-To: <00d601c8556a$69d1ca70$0204a8c0@IT>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

On Sun, 13 Jan 2008 00:28:08 +0200, Andrew Voznytsa wrote:
> Just installed lm-sensors (2.10.4 and 3.0.0) on S3000AH-based system (Linux
> version 2.6.23-gentoo-r3 (root@farm) (gcc version 4.1.2 (Gentoo 4.1.2 p1.0
> .2)), x86_64) - works fine except lm-sensors does not show fans 5 and 6. Is
> it fixable? (I'd leave my chassis fan connected to 5th socket and do not
> reconnect it to 2-4)

The LM85 and compatible chips only have 4 fan inputs. If your board has
more than 4 fan headers, either some of them can't be monitored, or you
have second chip on your board to handle them. Best is to take a look
at what the BIOS displays. If the BIOS displays all 6 fans, there must
be another sensor chip on your board; if it displays only 4, it means
that the remaining 2 can't be monitored.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
