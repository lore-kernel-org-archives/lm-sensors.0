From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Nov 2009 20:19:03 +0000
Subject: Re: [lm-sensors] [PATCH v3 0/8] sensord: Cleanup of the sensors
Message-Id: <20091105211903.013dddb2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091103200144.GB4724@ubuntu>
In-Reply-To: <20091103200144.GB4724@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 5 Nov 2009 20:29:03 +0100, Andre Prendel wrote:
> On Thu, Nov 05, 2009 at 10:22:03AM +0100, Jean Delvare wrote:
> > Hi Andre,
> 
> Hi Jean,
> 
> > On Wed, 4 Nov 2009 20:17:42 +0100, Andre Prendel wrote:
> > > On Wed, Nov 04, 2009 at 10:11:12AM +0100, Jean Delvare wrote:
> > > > You're welcome. I've made some more minor comments, but in general I
> > > > think your patch series is ready to be merged now. Go ahead!
> > > 
> > > I've just merged the patches with the minor changes due to your
> > > comments.
> > 
> > Great, thanks. Nothing worth mentioning in CHANGES?
> 
> Damn, I forget this every time. Otherwise I think we don't need this
> refactoring in the CHANGES file. IHMO it is'nt interesting for the
> user, is it?

You don't need to say too much, indeed. But the log is also for us to a
certain extent. Mentioning that cleanups and refactoring happened is a
good hint if anything breaks. Useful when writing the freshmeat
announcements, too.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
