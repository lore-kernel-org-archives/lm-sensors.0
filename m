From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 23 May 2006 09:11:00 +0000
Subject: [lm-sensors] Question about correct sensor
Message-Id: <4472D1A4.8000503@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4472C4FA.18461.1D8FF3D3@christoph.galuschka.tikom.at>
In-Reply-To: <4472C4FA.18461.1D8FF3D3@christoph.galuschka.tikom.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> thanks for the fast reply.
> 
> I allready did read the manual, as I have running versions of 
> LM_Sensors on various machines.
> I have patched the kernel according to the INSTALL file. The i2c-i801 
> is included in the compilation.
> When running sensors-detect I get:
> Can't access /proc/modules! at /usr/sbin/sensors-detect line 1831.

Hmm this seems as an too old version is used? Are you using 2.10.0 version of
lm-sensors?

If not here is a hack. Just download the 2.10.0 from the website,
exytact archive and go to prog/detect/ run the sensors-detect
program from there.

Then you may load the modules it suggest and generally used the older version
from a distro if it wont have issues.


Regards
Rudolf

