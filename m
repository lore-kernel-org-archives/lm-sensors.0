From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: dmi_scan: exporting dmi_broken
Message-Id: <1077701949.403c6d3de9698@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040119090235.GB22028@neu.nirvana>
In-Reply-To: <20040119090235.GB22028@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > What would an acceptable name be? The bugzilla reporter suggested
> > prepending "i2c-" to the two files.
> 
> Sounds good to me.

Blah. I should have read the rest of the thread before replying. Mark's
approch sounds much better (I really should have thought of it too,
shame on me).

So, we have to make some changes to mkpatch so that it:
1* Doesn't include our dmi_scan.
2* Patches the kernel one.

1 is trivial, and 2 should not be too hard.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
