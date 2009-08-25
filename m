From: clubsoda@hushmail.com
Date: Tue, 25 Aug 2009 16:19:47 +0000
Subject: Re: [lm-sensors] w83781d - Unable to set fan1_div
Message-Id: <20090825161947.22F29B8043@smtp.hushmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090813210941.8E3F9B0048@smtp.hushmail.com>
In-Reply-To: <20090813210941.8E3F9B0048@smtp.hushmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Answers own query... :)


The problem turned out to be that whilst the as99127f-0-2d chip 
requires the w83781d kernel module, any settings like "set fan1_div 
8" in the w83781d section of /etc/sensors3.conf seem to be ignored 
because the as99127f has its own dedicated chip section.


Also worth mentioning that sensors are broken for this motherboard 
with the latest Karmic Koala kernels [2.6.31-6-generic and 2.6.31-2-
rt].  Errors from dmesg:-

 ACPI: I/O resource 0000:00:1f.3 [0xe800-0xe80f] conflicts with 
ACPI region SM00 [0xe800-0xe806]
 ACPI: Device needs an ACPI driver
 i801_smbus: probe of 0000:00:1f.3 failed with error -16

The workaround is to add the boot parameter 
acpi_enforce_resources=lax.
Hope this helps someone.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
