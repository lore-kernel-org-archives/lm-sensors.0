From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: subscribe gene.heskett@verizon.net
Message-Id: <20030802195922.16a3b373.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308012231.07647.gene.heskett@verizon.net>
In-Reply-To: <200308012231.07647.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> So where do users go to post problem reports?  I seem to have gotten 
> lost in a quagmire of updates between its (sensors) all working in 
> kernel-2.4.22-pre8 and the 2.7.0 family of i2c/lm_sensors, and 
> 2.4.22-pre10 and either 2.7.0 or 2.8.0 of i2c/lm_sensors.

The list is OK for reporting problems, you just don't have to register
to do so. Alternatively, you can use our ticket-based support:
http://www2.lm-sensors.nu/~lm78/support.html

> I just saw a bitkeeper pull go by on the usb list from greg-kh, but I 
> don't have bitkeeper.  From the list of fixes, it would fix my 
> problems.  i2c-nforce is one that I need but which won't build here, 
> and somehow, i2c-viapro seems to have disappeared from the kernel 
> stuffs, if it was ever in there.

I think you're messing up between what Greg KH does and what we do. We
develop i2c and lm_sensors as add-ons to the Linux 2.4 kernel. Grek KH
works on integrating our drivers into Linux 2.6. So unless you are using
Linux 2.6, you just don't need anything Greg can offer.

Now that this is clear, could you start again explaining to us which
kernel you are using, which version of i2c and lm_sensors you are using,
and what the problem is?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
