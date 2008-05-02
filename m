From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 02 May 2008 14:29:21 +0000
Subject: Re: [lm-sensors] sensors.conf for the Supermicro X7DBE
Message-Id: <20080502162921.2566a1c2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481195AE.3070104@dolbeau.org>
In-Reply-To: <481195AE.3070104@dolbeau.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2 May 2008 09:57:17 -0400, Daniel Lucio wrote:
> Hi,
> 
> the last line in this config file is repeated twice.
> 
> ignore fan12

Good catch. Romain, I guess the first one is supposed to be "ignore
fan11"?

Also, there's this note:
# 1) as of linux 2.4.21, temp6 is read by lm-sensors but doesn't actually
#    seem to exist in the chip (?), so an error is displayed...

Given that the w83793 driver doesn't exist for Linux 2.4, I guess you
really mean "as of linux 2.6.21"? That's a bit surprising though, as
this driver didn't change in kernel 2.6.21 as far as I can see.

My experience with the W83793 chip on SuperMicro motherboards, is that
a BIOS update can make temp6 appear (or disappear, I guess.) The w83793
driver does only create sysfs files for enable temperature channels, so
when temp6 is disabled, the temp6* sysfs files are missing. Old
versions of "sensors" didn't expect this, it was fixed in lm-sensors
2.10.2.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
