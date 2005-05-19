From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:33 +0000
Subject: suggested -V flag for sensors
Message-Id: <3CF294CD.5050607@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020525104152.0a2701df.khali@linux-fr.org>
In-Reply-To: <20020525104152.0a2701df.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

People send us a lot of 'sensors' output and without the algo/adap info
it would be a lot harder to diagnose things, or we would have to
ask them to use -V, so I'd rather not take that info out by default.
If you want to submit a -A patch (including a man page update) I'll 
apply it.
thanks
mds

Jean Delvare wrote:
> Hello.
> 
> I added a -V flag to the sensors program. It stands for "verbose". My
> idea is that most people don't care about adapter name and algorithm
> used, so I disabled them being displayed by default, and they are back
> with -V.
> 
> Patch attached, please tell me what you do think about it.
> (against 2.6.3, works with current CVS)
> 
> You may think that adapter and algorithm should really be displayed by
> default. In this case, we still can have a flag that hides them (-A
> comes to mind).
> 
> Any feedback appreciated, thanks.
> 


