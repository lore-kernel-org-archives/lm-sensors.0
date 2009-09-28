From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 Sep 2009 07:43:58 +0000
Subject: Re: [lm-sensors] PATCH: add sections for the new FTS chips to
Message-Id: <20090928094358.0ea262c6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1C27BF3FB8EE3A4D8F901C22ADE1DE07CE9D65F6E0@ABGEX72E.FSC.NET>
In-Reply-To: <1C27BF3FB8EE3A4D8F901C22ADE1DE07CE9D65F6E0@ABGEX72E.FSC.NET>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 27 Sep 2009 18:48:34 +0200, Andre Prendel wrote:
> On Wed, Sep 16, 2009 at 10:18:53AM +0200, Cestonaro, Thilo wrote:
> > Hey,
> 
> Hey Thilo,
> 
> > here is a patch which adds new sections to the sensors.conf.default.
> > The fts.conf can be used as a custom configuration in the wiki.
> 
> Sorry for the delay. We had some problems with lm-sensors.org infrastructure.
> 
> The motherboard specific configurations one can find now under
> 
>   http://www.lm-sensors.org/wiki/Configurations/FujitsuTechnologySolutions

Thanks Andre :)

> and I've commited your patch for default config file a few minutes ago. See
> 
>   http://www.lm-sensors.org/changeset/5775/lm-sensors/trunk

Ignore statements in the default config file sounds wrong. What was the
point of implementing inputs on the monitoring chip if they really are
never used?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
