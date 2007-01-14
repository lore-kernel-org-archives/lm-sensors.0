From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 14 Jan 2007 16:45:43 +0000
Subject: [lm-sensors] Call for 2.10.2
Message-Id: <20070114174543.a3c94517.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061221224611.3c2746af.khali@linux-fr.org>
In-Reply-To: <20061221224611.3c2746af.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

On Tue, 9 Jan 2007 09:09:10 +0100, Jean Delvare wrote:
> > January 7th, 2007: Freeze of the repository
> > January 8th to 13th: Tests
> > January 14th: Release of lm_sensors 2.10.2
> 
> OK, let's freeze the repository now, and devote the rest of the week to
> testing. Only bug fixes and documentation updates should now be
> committed to the repository until we release.

I'm done with testing on my systems, and I've committed the fixes for
all the bugs I found. If nobody hit a blocker problem, I'd say we're
ready to release.

Philip, can you please take care of the release? Note that the
libsensors version must be bumped to 3.1.2.

Thanks,
-- 
Jean Delvare

