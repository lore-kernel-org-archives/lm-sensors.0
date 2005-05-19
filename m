From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: Problems with w83781d module
Message-Id: <20031115115802.51712ca1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <2B6C784DD3723745978C27C72801F7F8AC80F8@cba0e2k04.cba0.centerbeam.com>
In-Reply-To: <2B6C784DD3723745978C27C72801F7F8AC80F8@cba0e2k04.cba0.centerbeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I tried all of the methods below and still no success.  I have
> attached a file containing the results from dmesg.

Looks like a problem with the bus driver, not the client driver. With
the force_w83791d option, the w83781d driver shouldn't possibly refuse
to load, unless the bus itself is broken.

Could you try loading a driver for one of the other chips you have on
that bus (you have so many, it's just amazing)? For example, try
adm1026, adm9240, adm1021 and/or lm75. If all of them fail to work, this
means that the bus driver isn't working as intended.

> I appreciate the help.

You're welcome. We appreciate the feedback :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
