From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: PCF8591 support for 2.6 kernel series (new patch)
Message-Id: <20040314161302.7a5f0a42.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040314121954.GB25614@pc.aurel32.private>
In-Reply-To: <20040314121954.GB25614@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I removed the aout_enable sysfs file, the analog output is now always
> enabled. I also changed the ain_conf sysfs file to a module parameter.
> That's mean there is now only one sysfs file that doesn't follow the
> sysfs-interface document, aout.

If we follow the scheme retained for the other files, it would have to
be named "out1_output" (sounds redundant, but in1_input is too).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
