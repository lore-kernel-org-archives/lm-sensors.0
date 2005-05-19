From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Ticket #1376
Message-Id: <20030827121458.5710f7a0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030817003245.GA12961@hurg.org>
In-Reply-To: <20030817003245.GA12961@hurg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> From sensors_detect, it looks like he *does* have an ADM1021
> compatible device.  But because two drivers detected the chip,
> an incorrect modules.conf config was generated that told adm1021
> to IGNORE the address that was detected.

You're right. And that's a bug in sensors-detect. I've been changing the
detection methods for this family (and the not-so-different LM83 and
LM90 families) recently. Johannes, could you please give a try to the
CVS version of sensors-detect? You'll find it here:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect
Maybe the bug is already fixed. If not, I'll fix it.

> As for the "Can't access" error, it looks like the driver isn't
> exporting a variable that libsensors is expecting.
> 
> The variable is:
>     {CTL_DEV, 2, 101, 4b2}
> 
> Where 0x4b2 is 1202 decimal and in the w83627hf.c or w83781d.c driver
> is W83781D_SYSCTL_TEMP3 and is only listed in
> w83782d_isa_dir_table_template and not in w83697hf_dir_table_template
> 
> There are two potential fixes:
> 
> 1. In /etc/sensors.conf, in the w83697hf section, add:
> 
>      ignore temp3
> 
> 2. Fix libsensors so that for the w83697hf it doesn't try and print
> temp3.

Aha. Nice catching. Could it be that some other times we had similar
problems, that was the real problem (and not /proc write accesses
issues)?

MDS, I guess that your recent CVS commit to the library is meant to fix
that? (I mean, not the temp3 problem, but the fact that the error
message was rather helpless).

Solution #2 is of course cleaner, but requires more work. Who can take
care of that? I just can't these days.

Also, from Johannes' sensors-detect log, it appears that the w83781d and
w83627hf are returned with the same confidence value (8). So I guess
that which one is recommended is almost random? It's no good. IIRC, the
w83627hf is better in this specific case, so we should lower the
confidence value for the w83781d driver.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
