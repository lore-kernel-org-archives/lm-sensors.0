From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 16 Jan 2006 22:27:03 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <20060116232703.17a0a8d5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steven,

> Looking in /usr/lib I notice only one library: libsensors.a (which is 
> from Sept 12th/05 ... marking it as being from v2.9.1)
> 
> Looking in /usr/local/lib reveals 4 files (all of which dated Jan 9th/06):
> libsensors.a
> libsensors.so ... which is a link to libsensors.so.3
> libsensors.so.3 .... which is a link to libsensors.so.3.0.9
> libsensors.so.3.0.9
> 
> Should I just copy the libsensors.a and libsensors.so.3.0.9 into /usr/lib ?

No! Don't touch anything. Static libraries (.a files) shouldn't cause
any trouble, they are not even used by "sensors". So you have a single
dynamic library (libsensors.so.3.0.9 under /usr/local/lib) and that's
alright that way. If it ain't broken, don't fix it! :)

> Any potential for error if the the wrong library is being read?

You would miss the improvements brought by the newer version if this
was happening to you. Additionally you might enounter missing symbol
errors. It's quite frequent that people install lm_sensors CVS
in /usr/local and still have lm_sensors from their distribution
in /usr. Usually they will run the right (new) version of "sensors" (if
their PATH is correct, that is) but that version of sensors may link
dynamically with libsensors from /usr/lib - the old version.

Our installation process tries to detect the case and should warn about
it, but it might not always work and not everyone pays attention to the
warnings, unfortunately.

-- 
Jean Delvare

