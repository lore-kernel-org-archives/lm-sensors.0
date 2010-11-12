From: Alexandros Diamantidis <adia@hellug.gr>
Date: Fri, 12 Nov 2010 20:01:25 +0000
Subject: Re: [lm-sensors] IT8721F fan control?
Message-Id: <20101112200125.GA1858@hellug.gr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101106002259.GA1871@hellug.gr>
In-Reply-To: <20101106002259.GA1871@hellug.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Luca Tettamanti [2010-11-12 14:13]:
> The problem with the native driver is that it uses resources that are
> claimed by ACPI, which might be unsafe.

Hmm... How unsafe would it be? A crash once a year I wouldn't
mind much, frequent random memory corruption would be worse ;-)

* Jean Delvare [2010-11-12 19:03]:
> Can you please test the standalone driver at:
>   http://khali.linux-fr.org/devel/misc/it87/
> 
> It has fixed manual fan speed control for the IT8721F. Hopefully it
> works now...

Just tried the new version with no obvious change. pwmconfig still
doesn't seem to do anything. Also tried echo 1 > pwm[123]_enable;
echo 0 > pwm[123], which should have stopped the fans, right?

Thanks again!

Alexandros

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
