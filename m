From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Mon, 09 Jul 2007 15:57:08 +0000
Subject: Re: [lm-sensors] Help wanted: individual alarm files
Message-Id: <20070709175708.c2ac46e0.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070701220005.1dda9d8f@hyperion.delvare>
In-Reply-To: <20070701220005.1dda9d8f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 1 Jul 2007 22:00:05 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Need to be converted:
> adm1021.c

I'll take care of it. I have already converted it to dynamic sysfs calls. The next patch will add alarm
files.

Regards,
Krzysztof

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
