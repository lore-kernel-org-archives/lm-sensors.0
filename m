From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: sensors-detect
Message-Id: <3F19D838.604@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030610192542.766e220d.khali@linux-fr.org>
In-Reply-To: <20030610192542.766e220d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

agreed - that's why we have a separate column in the new drivers page for
whether the chip is detected. you can put 'CVS' or a release number in that column too.

Jean Delvare wrote:
> I've been adding support to sensor-detect for some chips we don't have a
> driver for yet (LM82, LM86, LM90) and I plan to add some more in the
> next few days. I think it's generally a good idea to detect many chips
> even if we don't have drivers for them - and even if we know we won't
> ever write one for some reason. In the first case, this let us know when
> a given driver should be written through user repports. In the second
> case, it may prevent misdetection of the chip as one we support.
> 
