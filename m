From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: Tyan Tiger i7501(S2723) and Tyan Thunder i7500 problems (no
Message-Id: <20030222100708.7b3ee392.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Jon,

> I have a cluster of computers used for computational physics.  I'd
> like to monitor the CPU temperature to know if the AC room is
> functioning so our computers don't die.  Seemed simple enough, but I'm
> having lots of problems.
> 
> I'm a pretty experienced linux user, and have used lm_sensors in the
> past with no problem on other computers.
> (...)
> 6) I  edit the modules.conf like detect says, edit rc.local as says,
> and run the modprobes and sensors -s.  If I use the included sensors
> program, no sensors are found!  I happen to have an older sensors
> program lying around in /usr/bin from Redhat8.0 install, and it
> worked! Well, mostly (see sensors.TXT).  It says it's version 2.6.3.

Please make sure you don't have *two* libsensors on your system. If you
have two sensors programs, it could mean that you also have two libs
installed and we know it has caused problems to many other users. So,
first remove any old lib and sensors program.

The second thing to try is to use i2c and lm_sensors 2.6.5 instead of
2.7.0. This last version has had many changes and knowing wether the
previous one works for you is helpful to us.

As far as i2c-velleman is concerned, I fear there's nothing we can do.
Just don't try to load it unless you know there is such bus on your
motherboard.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
