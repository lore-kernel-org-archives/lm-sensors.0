From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 17 Mar 2011 10:02:33 +0000
Subject: Re: [lm-sensors] New fintek f718xx driver now available, please test
Message-Id: <20110317110233.490a1f18@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D77DAB5.6080601@redhat.com>
In-Reply-To: <4D77DAB5.6080601@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 10 Mar 2011 08:45:51 +0100, Hans de Goede wrote:
> I accidentally swapped the number of temperatures for the
> f71808e versus all other models. Attached is a fixed version,
> please use this instead of my previous version.

And I have fixed sensors-detect to properly identify all Fintek
Super-I/O devices and recommend the right driver for them:
  http://khali.linux-fr.org/devel/misc/sensors-detect

Testers welcome!

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
