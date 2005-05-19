From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: sysfs names
Message-Id: <20040215195843.3307302e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Would it be correct to post a summary together with a link to this
> > thread? That way, people who want to know more can read the whole
> > story in a convenient form.
> 
> I doubt that would be ok.  We need to let the world know why we are
> changing a public interface during a "stable" kernel series. 
> Remember, there are other users of the sysfs sensor interface other
> than lmsensors.

I only know of gkrellm doing that. Remember that accessing the sysfs
files directly is strongly discouraged at the moment. And the change I
propose would, in fact, make it safer (although still not recommended).

Whatever changes we do, people using libsensors are not affected (else
than user need to upgrade their kernel and lm_sensors in sync). This is
why I am proposing the change even during a stable series.

> So I think a summary of what we want to change, and why to lkml is
> still necessary.  If enough people object, we might be stuck with what
> we currently have...

I don't see much reason why people would object, except for the
principle that nothing must change in stable releases. The facts are,
our sysfs interface is just stabilizing now. There are a few existing
drivers not following our own recommendations (lm83 at least), and
to-be-ported driver that won't fit in it, so it'll need to be extended
anyway.

We already have to handle two different interfaces in libsensors and
user-space tools. This would be a real pain to have a third one as Linux
2.7 will start living. This is the reason why I want the interface to be
cleanly redefined before the 2.6/2.7 fork occurs.

I'll prepare a long and detailed post for the LKML, and hope it will be
convincing.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
