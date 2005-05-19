From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: lm_sensors: output for all sensors?
Message-Id: <Pine.LNX.4.58.0406171203580.20062@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406161539.50952.haimat@lame.at>
In-Reply-To: <200406161539.50952.haimat@lame.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello

> attached.
Thanks

I finally found some time to reply to you.

Do you have Asus A7V board? If not please which ?

I think you can try:

modprobe i2c-isa
modprobe via686a
then try

sensors

If you see something just follow the configuration in /etc/sensors.conf
(don't forget to run sensors -s) and you aree done.

If you still have nothing related to sensors, please check dmesg or syslog
to see if there is something like the driver is complaining about not
initialized address. You can try this:

modprobe via686a force_addr=0x290

I hope this helps.

Regards

Rudolf
