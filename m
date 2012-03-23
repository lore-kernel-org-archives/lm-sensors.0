From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 23 Mar 2012 09:05:42 +0000
Subject: Re: [lm-sensors] IT8728 shows wrong CPU temperature
Message-Id: <20120323100542.5113c7b5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT106-W616EA106142C05B93F28D5D3460@phx.gbl>
In-Reply-To: <SNT106-W616EA106142C05B93F28D5D3460@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Tomas, please don't top-post.

On Fri, 23 Mar 2012 10:00:09 +0100, Tomas Johansson wrote:
> Because, these are idle values:
> 
> BIOS:
> SYS 34 C
> CPU 32 C

Most likely the above are NOT idle values. The BIOS is not idle - at
least never as idle as Linux can be with CPU frequency and voltage
scaling and low C states.

> lm-sensors:
> temp1:        +34.0 C  (low  = +127.0 C, high = +127.0 C)  sensor = thermistor
> temp2:        +31.0 C  (low  = +127.0 C, high = +127.0 C)  sensor = thermistor
> temp3:        +25.0 C  (low  = +127.0 C, high = +127.0 C)  sensor = thermistor
> 
> 
> And when i for example compile firefox temp3 will rise to around 45-50 C, while temp2 stays at 31 C.

This is correct reasoning though. temp3 is CPU temp. But you're
comparing Linux idle with BIOS not idle, no surprise the values don't
match.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
