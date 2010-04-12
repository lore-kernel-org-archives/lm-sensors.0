From: dienet <dienet@poczta.fm>
Date: Mon, 12 Apr 2010 19:52:34 +0000
Subject: Re: [lm-sensors] Coretemp goes up since 2.6.31.4
Message-Id: <op.va2etwrvwcw97g@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100409111733.7bb2b5fa@hyperion.delvare>
In-Reply-To: <20100409111733.7bb2b5fa@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 12 Apr 2010 21:11:52 +0200, Jean Delvare <khali@linux-fr.org>  
wrote:

> Again, coretemp is never reporting a real temperature. It is reporting
> a margin to a critical, arbitrary limit, which we don't know for sure.
> Even if we knew it for sure, the sensor is only accurate when it isn't
> too far from the limit. Your CPUs are running cool, way below the
> limit, so outside of the sensor's good accuracy range. Neither 2.6.31
> nor 2.6.33 is giving you a real temperature.

Ah OK now I understand. But let me assume this: if fan is cool more often  
then on 2.6.31, it means that there is something going on on 2.6.33 -  
something wrong. Am I right?

-- 
pozdr0
dienet

"Old C programmers never die. They're just cast into void."

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
