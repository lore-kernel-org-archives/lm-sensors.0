From: Phillip Susi <psusi@cfl.rr.com>
Date: Wed, 23 Feb 2011 02:05:45 +0000
Subject: Re: [lm-sensors] [PATCH v4 00/10] hwmon: (w83627ehf) Add support
Message-Id: <4D646B79.4070109@cfl.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297712143-7431-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1297712143-7431-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/22/2011 01:31 PM, Ian Dobson wrote:
> You can add a tested by ian dobson (i.dobson@planet-ian.com) for a
> nct6776f on a Asus p8p67 pro

Same board here.  Driver seems to work well, though I'm still trying to 
figure out why pwm1 seems to affect 2 of the 3 case fans I have in 
addition to the cpu fan.  If I set pwm1 to zero, fan1 stops as expected, 
but so does does fan3 according to the inputs.  I visually can see 
though, that front and rear fans have stopped, but the top fan is still 
going.  All of the case fans are 3 pin.  Fans 2 and 3 still show 
movement according to the inputs when pwm1 is off, but I can only see 
one of the 4 fans moving.

> I had a look at the tacho signal from the CPU fan with my oscilloscope
> and sometimes I see a small dropout during high part of the signal. The
> signal doesn't drop to 0, just about 30-50%. Do you know the switching
> point for tacho signal? In the documentation they talk about a TTL
> signal so low is below 20% and high is over 50% and the fan is
> outputting as signal in the "undefined area" every so often.

That sounds like a bad fan.  I'll have to borrow a scope from work and 
check mine.  Will let you know the results when I do.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
