From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: sensors-detect
Message-Id: <20030610192542.766e220d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

I contact you because you seem to be (one of the) packager(s) of
lm_sensors for Red Hat. We came across an issue you seem to have solved
in your package version 2.6.5-2. I'm actually refering to this:

* Fri Nov 29 2002 Phil Knirsch <pknirsch@redhat.com> 2.6.5-2
- Added patch to fix utf8 problem with sensors-detect.

Though we all agree there was a problem, and the patch solves it,
there's a question I'd like to ask: what makes you think the issue (for
reminder, a misuse of pack("C", $value);) is related to UTF?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
