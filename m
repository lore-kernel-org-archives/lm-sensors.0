From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 21 Apr 2008 17:35:49 +0000
Subject: Re: [lm-sensors] lm_sensors + IBM xseries 336
Message-Id: <20080421193549.7e565908@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <874302b50804210937n5d003656teaa61cbec6d5a65e@mail.gmail.com>
In-Reply-To: <874302b50804210937n5d003656teaa61cbec6d5a65e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Pierce,

On Mon, 21 Apr 2008 17:37:17 +0100, Pierce Ward wrote:
> I recently setup a Red Hat 4 based system and wish to get lm_sensors
> support. Here is my current setup:
> 
> lm_sensors-2.8.7-2
> kernel-smp-2.6.9-5.EL
> IBM Xseries 336
> 
> Basically I checked the Devices section of the wiki to check if my
> board is compatible. My board is listed as supported: Intel 82801EB ->
> i2c-i801 (pastebin of lspci: http://rafb.net/p/0x7zyL96.html ).

This is only the SMBus controller. It doesn't include sensors.

> However when I run sensors-detect, I get an error about my vendor
> being IBM and that their systems aren't supported (as of my lm_sensors
> 2.8.7 anyway).
> 
> Before I go modifying the sensors-detect script I was wondering if
> this is safe to do on this system? The error message from
> sensors-detect mentions the thinkpad laptop, however I would assume
> that an xseries server would be better supported.
> 
> Unfortunately I won't be able to update lm_sensors on this box, so I'm
> fairly limited in what I can do.

Better download the latest version of the script here:
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
You can run it without installing it. It doesn't have the check for IBM
systems, since it was updated to behave more safely. And a recent
version has more chances to know about your hardware.

But I wouldn't hold my breath... As far as I know these IBM xseries
servers do not have hardware monitoring chips.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
