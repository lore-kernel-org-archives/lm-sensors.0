From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 May 2007 08:24:10 +0000
Subject: Re: [lm-sensors] w83627ehf module floods log file
Message-Id: <20070525102410.1aca1699@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701032236.24178@goldspace.net>
In-Reply-To: <200701032236.24178@goldspace.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 3 Jan 2007 22:36:24 +0300, Nameserver.ru wrote:
> I have noticed the w83627ehf module (with patch to support DHG) floods
> /var/log/messages this way:
> 
> ...
> Jan  3 21:54:40 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> Jan  3 21:54:43 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> Jan  3 21:54:46 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> Jan  3 21:54:49 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> Jan  3 21:59:28 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> Jan  3 21:59:31 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> Jan  3 21:59:34 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> Jan  3 21:59:37 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> Jan  3 21:59:40 anli w83627ehf 9191-0290: Increasing fan 4 clock divider from 4 to 8
> ...
> 
> You see, every 3 seconds the module generates new message. Is it possible to
> suppress this logging?

For the records: this was a real bug, which is fixed now (fixed in
2.6.21).

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
