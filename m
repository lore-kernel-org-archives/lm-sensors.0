From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: lmsensor support for laptop
Message-Id: <426F51C1.2020106@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050427083553.GA28167@aix.meng.auth.gr>
In-Reply-To: <20050427083553.GA28167@aix.meng.auth.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hello,
> 
> I have a (recent) laptop whose motherboard chipset is
> an intel 855GME, this chipset seems not mentionned
> in the lmsensors web pages, 

Hi, lapstops generally do not have temp monitors compatible with common
chips we support. If it is IBM do not try to play with lm_sensors at all.

If you want to get some temp try ACPI instead:

acpi -V

command, assuming you loaded all modules like thermal-zone etc.

You can install lm-sensors package and run sensors-detect. For more
information please tak a look to documentation on web page or in
lmsensors package. If you need more help even when you read the docs
write again please.

regards

Rudolf
