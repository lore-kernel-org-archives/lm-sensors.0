From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: porting adm9240 driver to kernel 2.6
Message-Id: <20040303232113.660c4463.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0403031717460.17938@chewie.solar.local>
In-Reply-To: <Pine.LNX.4.58.0403031717460.17938@chewie.solar.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've been looking over the lm-sensors site(s) the past few weeks, and
> it appears the adm9240 driver hasn't been ported (yet).

Correct.

> So, I've started porting the driver, and should have something up
> for download this evening (CET).

Great :)

> It's working quite well, only issue remaining (that I can see) is that
> prog/sensors/chips.c has some kind of hard-coded mappings for adm9240
> sysfs values (2.5V, 1.5V, etc.), and I'm using the standard sysfs
> values in0, in_min0, etc. I hope I did the right thing ;)

You don't have to care about how things were named in the 2.4 kernel
version of the driver. What you must pay attention to is the
sysfs-interface document. The links with the old names will be done in
libsensors once your 2.6 driver is reviewed and accepted.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
