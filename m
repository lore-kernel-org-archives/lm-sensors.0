From: =?UTF-8?Q?David_Santamar=C3=ADa_Rogado?= <howl.nsp@gmail.com>
Date: Wed, 27 Apr 2011 20:10:54 +0000
Subject: [lm-sensors] Gigabyte MA785GM-US2H motherboard configuration
Message-Id: <BANLkTimA9Uj9DbC+cG8hrpDXZL+6jTGW9w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The configuration for Gigabyte MA785GM-US2H
http://www.lm-sensors.org/wiki/Configurations/Gigabyte/MA785GM-US2H is
wrong, at least for rev 1.0 of the mobo. in7 is not +12V, is an
strange voltage that varies with the frequency of the cores. Is
possible to determinate approximately it's value knowing the highest
freq of all the cores in the system. If there are doubts, with that
config and an Athlon II 250 the voltage show by in7 with the
multiplier is about 24 V.

I can provide the config the works with my MA785GM-US2H rev 1.0. The
only thing I doesn't know sure are the fans because I have only tested
cpu fan. Anyway it's based on a UD2H cfg found on the internet, being
identical motherboards only differing in dolby theatre support over
spdif.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
