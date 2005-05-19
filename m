From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: AW: lm-sensors support for ASUS chip ASB100 Bach
Message-Id: <20030520154855.1eaa53fc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <795E03B0F1E26C449762C0EDF5F5659140F50F@Exchange.16.172.in-addr.arpa>
In-Reply-To: <795E03B0F1E26C449762C0EDF5F5659140F50F@Exchange.16.172.in-addr.arpa>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I finally did some cosmetics to the "sensors.conf" file - blanking
> unused sensors and correcting the temp2 values. The LM-Sensor Software
> seems to work fine now. I did not modify the W83781D driver, only the
> "sensors.conf" file which I attached for your information. I also
> appended a lot of spec information to this file about chip registers
> and their settings. If somebody needs more details, feel free to
> contact me. I thank you for your help. Regards

I took a look and am a bit lost. I hardly can understand what is purely
documentary and what actually needs to be fixed. It seems that most of
the changes you made don't belong to the config file but to a
documentation file about the ASB100 chipset instead.

What I propose is that you send us some clean diffs. What you say seems
to be valuable (as far as I can say, I'm not a core developer for this
project), so I don't want it to be lost. Could you please submit:

1* A clean diff against etc/sensors.conf.eg 2.7.0 or CVS.
2* A clean diff against doc/chips/w83781d 2.7.0 or CVS.

Sensors.conf.eg should only contain the actual config changes, while the
doc file should contain any valuable piece of information you gathered
about the chipset. Both developer and user information about this given
chipset belong to this doc file.

If you don't know how to generate a diff, just edit the files and send
them, I'll take care of diff'ing them. What's important is that you must
change the less things possible to make all changes obvious. Don't
remove parts because you don't feel concerned, as you did the at first,
it makes my job only more difficult.

In particular, I couldn't understand what you mean with in7-in12
"available but not displayed by software". What do you expect us to do?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
