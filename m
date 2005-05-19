From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: False IBM Laptop detection - PIIX4 (440BX) - IBM 300PL 6892-N2U
Message-Id: <20030208213038.0a536e92.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200302071048.27227.shawn.starr@datawire.net>
In-Reply-To: <200302071048.27227.shawn.starr@datawire.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have an IBM 300PL 6892-N2U just picked it up yesterday but
> lm_sensors 2.7.0 refuses to load anything!
> 
> I am using a Tower desktop not a laptop unless this is a defunked
> bios?
> 
> Let me know what info you need from me.

Thanks for the report. We are working on a large rewrite of the i2c
layer (well, Ky?sti M?lkki is) so this is not the time for me to mess up
with IBM detection code. What's more, we are still missing some
information to do it correctly.

So, my advice is: if you don't need 2.7.0 and if 2.6.5 was working for
you, stick to this version.

We'll let you know (I hope I won't forget) if we need some help from
you. Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
