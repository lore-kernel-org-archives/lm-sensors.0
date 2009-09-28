From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 Sep 2009 19:01:35 +0000
Subject: Re: [lm-sensors] PATCH: add sections for the new FTS chips to
Message-Id: <20090928210135.1d118af9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1C27BF3FB8EE3A4D8F901C22ADE1DE07CE9D65F6E0@ABGEX72E.FSC.NET>
In-Reply-To: <1C27BF3FB8EE3A4D8F901C22ADE1DE07CE9D65F6E0@ABGEX72E.FSC.NET>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 28 Sep 2009 20:58:45 +0200, Andre Prendel wrote:
> On Mon, Sep 28, 2009 at 09:43:58AM +0200, Jean Delvare wrote:
> > 
> > > and I've commited your patch for default config file a few minutes ago. See
> > > 
> > >   http://www.lm-sensors.org/changeset/5775/lm-sensors/trunk
> > 
> > Ignore statements in the default config file sounds wrong. What was the
> > point of implementing inputs on the monitoring chip if they really are
> > never used?
> 
> Hm, that's right. So should we remove the the ignore statements? Say yes and I
> will do it :)

Yes, I think we should.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
