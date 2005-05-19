From: tk@westend.com (Thomas Kaehn)
Date: Thu, 19 May 2005 06:23:33 +0000
Subject: lm_sensors Ticket 899
Message-Id: <20020524102729.GA4269@westend.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,


> never heard of the GF. The HF has sensors and the F doesn't.
> It could also be uninitialized or on the Via's I2C bus.
> If isadump 0x295 0x296 returns something besides FF's you can
> send it to us or try using force_w83627hf=9191,0290.
today I checked out the lastest CVS source and the chip was detected
successfully. Thanks for your reply!

Ciao,
Thomas
--=20
Thomas K?hn          WESTEND GmbH - Aachen und Dueren     Tel 0241/701333-0
tk@westend.com     Internet & Security for Professionals    Fax 0241/911879
	  WESTEND ist CISCO Systems Partner - Authorized Reseller
