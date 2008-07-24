From: "Frank Phillips" <frankalso@gmail.com>
Date: Thu, 24 Jul 2008 20:08:15 +0000
Subject: Re: [lm-sensors] temperature monitor
Message-Id: <78171f0a0807241308h160e6b1cu7ab1eb0ca608999d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <487CCD71.8000909@GMail.COM>
In-Reply-To: <487CCD71.8000909@GMail.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Here's the summary of the sensors that 'sensor-detect' detected:
>
>   Detects correctly:
>  * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9)
>
> However,  it indicated
>
>   Intel AMB FB-DIMM thermal sensor...                         Success!
>   (driver `to-be-written')
>
> Does this imply I'm out of luck?
>
> -- Ken

The driver i5k_amb was added to kernel 2.6.24. Looks like no one has
sent a patch for lm_sensors to use it.

Did it not detect coretemp? Rudolf, is this processor not covered by
your Penryn patch? Ken, please send your /proc/cpuinfo output.

Thanks,
Frank

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
