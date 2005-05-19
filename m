From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: lm-sensors and thinkpad
Message-Id: <20030612173906.10e51bf5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE88450.5050905@lateral.net>
In-Reply-To: <3EE88450.5050905@lateral.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I tried to install lm_sensors-2.7.0 and after running sensors-detect
> I got the advice to email you with the following details, so here
> goes:
> 
> Machine: IBM Thinkpad T22 type 2647.
> Kernel: 2.4.20
> 
>   BIOS vendor (ACPI): PTLTD
>   System vendor (DMI): IBM
>   BIOS version (DMI): 16ET20WW (1.00b)
> 
> Hope this helps!

Fred,

Thanks a lot for your report! I was wondering which of ACPI and DMI
detection methods was the best, that's why I placed this request in our
detection script, that appears if both method succeed but don't give the
same answer. It seems that on your system, the DMI method gives a more
interesting result than the ACPI one.

As you are the first and only person who reported such a case, this may
be to early to conclude, but we may decide to give preference to the DMI
method other ACPI if other people confirm.

Anyway, you'll have noticed that sensors-detect refused to run on your
laptop, because it's an IBM system. Older IBM systems are known to have
faulty eeproms that lm_sensors could corrupt (with bad, bad
consequences). We think newer systems should not suffer the problem, but
we chose to play it safe and simply block all IBM systems.

If you are wanting to try anyway, just let us known and we'll tell you
how to bypass the security mechanism. Of course, we won't be responsible
if anything bad happens then. If you succeed, you'll be a hero and we'll
add you name in the credits ;) Well, sounds much like Mission:
Impossible, isn't it. The good thing if you try and succeed is that we
could then let people having the same laptop as you run lm_sensors.

So, just let us know if you want to dive in.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
