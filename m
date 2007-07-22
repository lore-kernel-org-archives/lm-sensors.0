From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Jul 2007 15:54:35 +0000
Subject: Re: [lm-sensors] [PATCH RESEND] hwmon/dme1737: fix temp fault
Message-Id: <20070722175435.3083022d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0707201416v7077bd89i2691c7faf1ce9bcd@mail.gmail.com>
In-Reply-To: <191fb4ca0707201416v7077bd89i2691c7faf1ce9bcd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 20 Jul 2007 14:16:47 -0700, Juerg Haefliger wrote:
> Fix temp?_fault attribute. The temp was incorrectly compared against
> 0x0800 rather than 0x8000. Only the upper 8 bits are compared as the
> datasheet doesn't specify what happens to the lower bits in case of a
> diode fault.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
