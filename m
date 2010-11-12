From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Nov 2010 18:03:20 +0000
Subject: Re: [lm-sensors] IT8721F fan control?
Message-Id: <20101112190320.100d9706@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101106002259.GA1871@hellug.gr>
In-Reply-To: <20101106002259.GA1871@hellug.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexandros,

On Fri, 12 Nov 2010 16:09:50 +0100, Jean Delvare wrote:
> Looking at the it87 driver code, it is pretty clear that I messed up
> the manual fan speed control support for the IT8721F. Sorry about that.
> It requires much larger changes compared to other chips, than I first
> thought.
> 
> Working on it, stay tuned...

Can you please test the standalone driver at:
  http://khali.linux-fr.org/devel/misc/it87/

It has fixed manual fan speed control for the IT8721F. Hopefully it
works now...

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
