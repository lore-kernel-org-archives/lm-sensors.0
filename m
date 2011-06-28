From: "Artem S. Tashkinov" <t.artem@lycos.com>
Date: Tue, 28 Jun 2011 12:45:45 +0000
Subject: Re: [lm-sensors] [3.0 regression?] coretemp driver output has
Message-Id: <812143220.617670.1309265145958.JavaMail.mail@webmail11>
List-Id: <lm-sensors.vger.kernel.org>
References: <1679233363.543867.1308943464300.JavaMail.mail@webmail20>
In-Reply-To: <1679233363.543867.1308943464300.JavaMail.mail@webmail20>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Jun 28, 2011, Jean Delvare <khali@linux-fr.org> wrote: 

> I would be more interested by the output of:
> $ sensors -u -c /dev/null
> 
> And if it still doesn't show Core 1 and Core 2, please try again under
> strace:
> 
> $ strace sensors -u -c /dev/null 2> /tmp/sensors.trace

Somehow I had a wrong configuration file which was seemingly ignored under previous kernels. As soon as I removed this file, sensors output has become correct.

I'm terribly sorry for calling a false alert.

Best wishes,

Artem

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
