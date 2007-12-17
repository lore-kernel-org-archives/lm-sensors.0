From: Gary Funck <gary@intrepid.com>
Date: Mon, 17 Dec 2007 00:47:35 +0000
Subject: Re: [lm-sensors] w83627hf: invalid limits?
Message-Id: <20071217004735.GB27938@intrepid.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071216231848.GA11241@intrepid.com>
In-Reply-To: <20071216231848.GA11241@intrepid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 12/16/07 15:18:48, Gary Funck wrote:
> 
> As you can see in some cases min is less than max, and in
> other cases the indicated limit values are just plain wrong.
> Any idea what is going on here, or how diagnose and fix the
> problem?

Follow-up: I tweaked sensors.conf and uncommented the
limit settings.  Everything okay now, except the clock
battery probably needs to be replaced. :)

What's the recommended method for monitoring the various
sensors and/or sending an e-mail when a limit alarm has
been hit?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
