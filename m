From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Feb 2010 08:42:29 +0000
Subject: Re: [lm-sensors] LPC47M192-NC Fans
Message-Id: <20100212094229.3a80df9b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sean,

Please keep the list in the loop.

On Thu, 11 Feb 2010 19:25:49 -0500, Sean Fidler wrote:
> The driver unloaded and loaded again without issue.
> /proc/ioports output:
> (...)
> 0600-067f : smsc47m1
>   0604-0604 : smsc47m1
>   0633-0636 : smsc47m1
>   0656-065c : smsc47m1

OK, looks very good.

> I have a question regarding sensors.conf, I updated the file with the text
> from the configuration you posted, however, when I run sensors I see the
> same information as before (i.e. sensors.conf not being used). If I run
> sensors -c /etc/sensors.conf then the output is as expected. Just wanted to
> confirm that this is correct functionality.

Maybe you have /etc/sensors3.conf too? It takes precedence
over /etc/sensors.conf for lm-sensors 3.x. If you are using lm-sensors
3.x then you want to edit /etc/sensors3.conf, not /etc/sensors.conf.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
