From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: Tyan S2720 Information
Message-Id: <3D84B6F2.9FB3AF8D@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <EAEEKDDCGGEDNOGFKCEGOENGCFAA.hmueller@megware.de>
In-Reply-To: <EAEEKDDCGGEDNOGFKCEGOENGCFAA.hmueller@megware.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

if the xeon responds to i2cdetect at 0x18 then using the adm1021 driver
as documented in doc/chips/SUMMARY with modprobe adm1021
force_adm1021=0,0x18
shoud give you good results. adm1021 will report 2 temps, one will be
invalid
and the other is the real temp.
Send us the results and the output of i2cdump 0 0x18 (assuming i2c is
bus 0).
