From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Sep 2009 16:09:26 +0000
Subject: Re: [lm-sensors] Mandriva 2010.0b1, lm-sensors 3.1.1,
Message-Id: <20090905180926.63d28e95@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200909051753.34432.philippe.roubach@free.fr>
In-Reply-To: <200909051753.34432.philippe.roubach@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Salut Philippe,

On Sat, 5 Sep 2009 17:53:34 +0200, ROUBACH Philippe wrote:
> see my bug report about the problem
> 
> https://qa.mandriva.com/show_bug.cgi?idS459

Check the kernel logs when you attempt to load the it87 driver. Most
likely your problem is the one explained here:

http://hansdegoede.livejournal.com/7932.html

Your board being an Asus one, loading the asus_atk0110 driver instead
of the it87 driver might help.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
