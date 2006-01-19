From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 Jan 2006 04:41:43 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket
Message-Id: <20060119044143.GD17365@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Steven Karatnyk <stevenkaratnyk at rogers.com> [2006-01-16 15:11:03 -0500]:
> > Any potential for error if the the wrong library is being read?

* Jean Delvare <khali at linux-fr.org> [2006-01-16 23:27:03 +0100]:
> You would miss the improvements brought by the newer version if this
> was happening to you. Additionally you might enounter missing symbol
> errors. It's quite frequent that people install lm_sensors CVS
> in /usr/local and still have lm_sensors from their distribution
> in /usr. Usually they will run the right (new) version of "sensors" (if
> their PATH is correct, that is) but that version of sensors may link
> dynamically with libsensors from /usr/lib - the old version.
> 
> Our installation process tries to detect the case and should warn about
> it, but it might not always work and not everyone pays attention to the
> warnings, unfortunately.

Steven, you can use the following command to see which libraries would be
used by sensors:

	$ ldd `which sensors`

E.g., mine says this:

	$ ldd `which sensors`
        	linux-gate.so.1 =>  (0xffffe000)
        	libsensors.so.3 => /usr/local/lib/libsensors.so.3 (0xb7f65000)
        	libc.so.6 => /lib/tls/libc.so.6 (0xb7e22000)
        	libm.so.6 => /lib/tls/libm.so.6 (0xb7dff000)
        	libsysfs.so.1 => /usr/lib/libsysfs.so.1 (0xb7df5000)
        	/lib/ld-linux.so.2 (0xb7f9f000)

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


