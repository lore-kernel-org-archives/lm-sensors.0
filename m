From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: Problem with "sensors -s"
Message-Id: <20030324094111.54cfce57.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E7EA3D2.60309@astro.physics.upenn.edu>
In-Reply-To: <3E7EA3D2.60309@astro.physics.upenn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


(please reply to the list, not to me only)

> I run sensors -s (as root!) and get this message:
> 
> ----------------------snip-------------------------
> it87-isa-0290: Can't access /proc file for writing;
> Run as root?
> ----------------------snip-------------------------
> 
> The i2c-proc IS inserted.
>
> I am using lm_sensors-2.7.0. I am using a 2.4.20 kernel patched with 
> i2c-2.7.0 support.

Could you make sure you have only *one* libsensors on your system and
that it matches the version of sensors you are using?
 
> But I seem to be limited not being able to do sensors -s.
> 
> What should I do? Please help!

If the above doesn't work, please send the output of the following
command:

ls -lR /proc/sys/dev/sensors/

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
