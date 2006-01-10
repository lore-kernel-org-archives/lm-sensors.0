From: cpollock@earthlink.net (Chris)
Date: Tue, 10 Jan 2006 02:45:55 +0000
Subject: [lm-sensors] suppressing alarm output in the syslog
Message-Id: <200601092046.05368.cpollock@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I had this fixed before I changed motherboards and started trying to get the 
readings right.  My /etc/rc.d/init.d/lm_sensors file has this:

# Start daemons.
        gprintf "Starting sensord: "
        daemon sensord -i 1m -l 0m
        echo
	touch /var/lock/subsys/lm_sensors
        ;;
  stop)

Shouldn't this suppress any output to the syslog?  Looking at an old backup 
of my lm_sensors script from last month it has it the same way.

- -- 
Chris
Registered Linux User 283774 http://counter.li.org
20:25:25 up 2:11, 3 users, load average: 3.08, 2.47, 1.52
Mandriva Linux 10.1 Official, kernel 2.6.8.1-12mdk

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDwx/t43Kn2pjmcFwRAvX0AJ46rMc2+31OtDQsRirgvcBd1oCEIACeIyTH
a9Mfdtn8lRIbRAYhWyA+gJ8=Kty2
-----END PGP SIGNATURE-----

