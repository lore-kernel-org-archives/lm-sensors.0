From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: 2.8.5 release plan
Message-Id: <20040301231808.6a9b8c79.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4040B978.80806@verizon.net>
In-Reply-To: <4040B978.80806@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Khali and I agree that we will release 2.8.5 shortly after kernel
> 2.6.4 comes out, whether or not 2.6.4 contains the sysfs renaming
> patch. If it does, Khali will patch libsensors to match the kernel.

There is a change in the plan. In order to help the changes we want to
make to the sysfs interface, releasing 2.8.5 now, which will cover both
Linux 2.6.3 and 2.6.4, seems to be a good idea. This truly leaves the
CVS available for -mm series compatibility. We can do that because we
know that there won't be i2c-related changes made to 2.6.4-rcX.

If anyone has changes pending, let us know. All I have for now is the
super IO detection code, but the current version is working, so there's
no big deal here.

Releasing by the middle of the week (say Friday at latest) is suggested.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
