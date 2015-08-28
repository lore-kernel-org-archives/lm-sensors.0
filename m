From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 28 Aug 2015 07:29:15 +0000
Subject: Re: [lm-sensors] sensord
Message-Id: <20150828092915.09ac722e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAMy23P45NeFZaToAJSN7yAPqp+HgzoqTU6-MNeRDnC++MD1uRw@mail.gmail.com>
In-Reply-To: <CAMy23P45NeFZaToAJSN7yAPqp+HgzoqTU6-MNeRDnC++MD1uRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

On Thu, 27 Aug 2015 18:06:21 -0400, Paul Hilt wrote:
> I find lm-sensors pretty useful and the sensors utility works like a charm.
> I wanted to get a little bit more pro-active and decided to install sensord.
> 
> I am used to use sensors -f to show all temperatures in Fahrenheit,
> but sensord is reporting them in Celsius by default in /var/log/syslog
> Is there an easy way for me the enduser to change the log messages to be in
> Fahrenheit?

This is not currently implemented.

> And what is the best way to do so?

You would have to add support yourself. That shouldn't be too hard if
you know a bit of C, as you can simply check how this is implemented in
"sensors" and do pretty much the same.

I have created a tracking ticket for this task:
http://www.lm-sensors.org/ticket/2394

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
