From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 17 Apr 2011 20:59:04 +0000
Subject: Re: [lm-sensors] wrong voltages on D525MWV
Message-Id: <20110417225904.4b273f8d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1QApIq-0002zf-00.serafim_home-mail-ru@f134.mail.ru>
In-Reply-To: <E1QApIq-0002zf-00.serafim_home-mail-ru@f134.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Please keep the list Cc'd.

On Sun, 17 Apr 2011 23:54:21 +0400, Серафим Сухенький wrote:
> Sat, 16 Apr 2011 08:59:27 +0200 письмо от Jean Delvare <khali@linux-fr.org>:
> > Failing that, if you are able to gather several samples of each of 12V,
> > 5V and 5Vstby in the BIOS, we can guess the scaling factors from the
> > sample differences, and from that, find the pin mapping.
> 
> 
> If I'd like to guess scalings myself, then I have to write down voltages from bios, then write down voltages from lm-sensors,
> then make voltages change and repeat few times? When I have several different samples I can guess. Am I right?
> 
> How can I make voltages change? Don't they differ when I meashure them from bios and from booted OS?

+5V and +12V aren't voltages you can control. But almost all the time
the values displayed by the BIOS oscillate between two values, due to
PSU imperfection, measurement noise, load variations, etc. So it's
enough to stay in the BIOS for a minute. Sometimes you have to
leave/enter the screen to get new readings, but in most cases it's
updated in real-time.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
