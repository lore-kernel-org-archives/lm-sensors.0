From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: 2.7.0 testings
Message-Id: <20021204174959.052aa794.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021127213903.5b84866d.khali@linux-fr.org>
In-Reply-To: <20021127213903.5b84866d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Wow, I got a fix in 15 minutes from Vojtech!
> Try it now...
> I'm not actually doing a depmod against 2.2, 
> but I'm compiling against 2.2 and using nm -u to check for
> missing symbols, it looks ok...

It's OK for 2.2.20, 2.2.22 and 2.2.23. As I won't do any test on 2.4.20
for now (no acpi nor cpufreq patch being available yet), a release is OK
for me.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
