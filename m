From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Dec 2009 16:11:48 +0000
Subject: Re: [lm-sensors] sensors-detect: probing i2c sensors racy?
Message-Id: <20091209171148.5a8ea5a8@hyperion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/i4xkNnc9Yq3njEjHGmuqq0u"
List-Id: <lm-sensors.vger.kernel.org>
References: <20091209153225.GA3947@alittletooquiet.net>
In-Reply-To: <20091209153225.GA3947@alittletooquiet.net>
To: lm-sensors@vger.kernel.org

--MP_/i4xkNnc9Yq3njEjHGmuqq0u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Forest,

On Wed, 9 Dec 2009 10:32:25 -0500, Forest Bond wrote:
> I am seeing a situation where sensors-detect fails to find sensors in a single
> run due to an apparent race condition.  It looks like it loads the i2c-* modules
> and then tries to open /dev/i2c-0 for probing, but it fails to open
> successfully.  My sense is that the device is not fully initialize and ready for
> opening immediately following the modprobe calls, but sensors-detect does not
> wait for initialization to complete.  I'm not sure what should be happening.  It
> seems sensible that modprobe would not return until the device is initialized.
> 
> Running sensors-detect again correctly probes the hardware because the i2c bus
> is fully initialized at that point.

You must be typing very fast to be able to trigger this ;) Or udev is
very slow populating /dev on your machine.

> I don't know anything about i2c, so I hope the language I'm using to describe
> this situation is reasonable.

It is perfect.

> I've attached the output from sensors-detect for the first (failed) run and the
> second (successful) run.
> 
> Thoughts?

The version of the sensors-detect you're using is getting old. Please
give a try to the latest one:
http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

If you can still reproduce the problem, then please give a try to the
attached patch and report.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

--MP_/i4xkNnc9Yq3njEjHGmuqq0u
Content-Type: text/x-patch; name=sensors-detect-wait-for-i2c-dev-nodes.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename=sensors-detect-wait-for-i2c-dev-nodes.patch

Index: sensors-detect
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- sensors-detect	(r=C3=A9vision 5808)
+++ sensors-detect	(copie de travail)
@@ -5812,6 +5812,12 @@
 		$by_default =3D 1 if dmi_match('board_vendor', 'asustek', 'tyan',
 					     'supermicro');
=20
+		# udev may take some time to create the device node
+		if (!(-x "/sbin/udevadm" && system("/sbin/udevadm settle") =3D=3D 0)
+		 && !(-x "/sbin/udevsettle" && system("/sbin/udevsettle") =3D=3D 0)) {
+			sleep(1);
+		}
+
 		for (my $dev_nr =3D 0; $dev_nr < @i2c_adapters; $dev_nr++) {
 			next unless exists $i2c_adapters[$dev_nr];
 			scan_i2c_adapter($dev_nr, $by_default);

--MP_/i4xkNnc9Yq3njEjHGmuqq0u
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/i4xkNnc9Yq3njEjHGmuqq0u--
