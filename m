From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 28 Apr 2012 15:00:05 +0000
Subject: Re: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus
Message-Id: <20120428150005.GA24091@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
In-Reply-To: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Apr 28, 2012 at 02:43:53AM -0400, P.B. V wrote:
[ ... ]
> 
> Also, I attempted to change the sensor type for CPUTIN using the
> nct6775 module with no effect. All that changed was -60 went to -62.5
> when changed to 'thermistor'.
> 
From what I have seen, temperature values around -60 on the NCT677X means
that nothing is connected to the respective pin, so it is not surprising
that the value does not change much if you change the sensor type.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
