From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: lm_sensors2/prog/detect dmidecode.c
Message-Id: <20020807203623.14c6ea71.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020806233957.3581835f.khali@linux-fr.org>
In-Reply-To: <20020806233957.3581835f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> are you talking about dmidecode.c only or kernel things too?

dmidecode.c only.

Two more things make me think we need to merge all changes with care.

* If I read the list carefully, the lm_sensors version is based on the
files found at http://www.domsch.com/linux/patches/dmi/. I suppose that
the base is dmidecode-1.1.c with one of the three patches applied.
Unfortunately, none of these patches leads to the "official" version
available from Alan's files (but -take3 is the closest, of course).

* Arjan van de Ven (Red Hat) fixed a bug in December 2001, which, it
seems, never made it back to Alan. Arjan's version is available at
http://people.redhat.com/arjanv/.

I suggest we apply my patch first (and call the result version 1.3)
since I already sent it to Alan and he seems to agree. Then, I'll submit
a new patch with both Arjan's fix and lm_sensors improvements and we
have version 1.4, we everything so far included. We'd consider Alan's
files repository the official place for the file, and I'd ask Matt
Domsch and Arjan to either delete or update their files.

After some testing is done (comparing old and new results on a number of
systems should be sufficient), we correct the last bugs[1], bump version
to 1.5 and commit all changes to lm_sensors. This is the plan.

(Then and only then, I'll add a call to dmidecode in sensors-detect to
make it ibm-bogus-hardware-resistant.)

If nobody objects, I'll start working ASAP. Else, feel free to express
yourself.

[1] Yeah, I know, there is no such thing as "the last bug". Think of it
as "the last bug we could find after a reasonable number of tests".

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
