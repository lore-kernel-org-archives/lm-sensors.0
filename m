From: Romain Dolbeau <romain@dolbeau.org>
Date: Thu, 23 Oct 2014 13:35:16 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (i5500_temp) Don't bind to disabled sensors
Message-Id: <CADuzgboAiFuTrtMUpVvnAKrfEPTULsEePcf3vb+dC5iAkGKUMg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141022111321.22ab7122@endymion.delvare>
In-Reply-To: <20141022111321.22ab7122@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

2014-10-23 15:26 GMT+02:00 Jean Delvare <jdelvare@suse.de>:
> Mind you, I tried that already, but it didn't help :(
[...]
> Maybe Romain will have more luck than me.

Nope, those registers are pretty much identical on
both systems for me, AFAICT with lspci -xxxx.

Cordially,

-- 
Romain Dolbeau

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
