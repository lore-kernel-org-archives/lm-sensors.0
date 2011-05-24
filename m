From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 May 2011 16:26:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Add comments describing
Message-Id: <20110524162658.GA13687@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306184738-4933-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1306184738-4933-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Tue, May 24, 2011 at 07:41:41AM -0400, Jean Delvare wrote:
> Hi Guenter,
> 
> On Mon, 23 May 2011 14:05:38 -0700, Guenter Roeck wrote:
> > The coretemp driver provides a single set of device attributes for each physical
> > core of a HT CPU to avoid duplicate sensors. This functionality was introduced
> > with commit d883b9f0977269d519469da72faec6a7f72cb489.
> > 
> > Commit e40cc4bdfd4b89813f072f72bd9c7055814d3f0f extends this functionality to
> > register the HT sibling of a CPU which is taken offline, to ensure that
> > sensor attributes are provided if at least one HT sibling of a core is online.
> > 
> > Add comments into the code describing the functionality in some more detail.
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > Cc: Durgadoss R <durgadoss.r@intel.com>
> > ---
> > I am not completely happy with the added comments nor with the description
> > above, so please feel free to chime in if you have an idea for a better
> > description.
> 
> The comment above looks OK to me. For the in-code comments, I have a
> few suggestions, see below.
> 

Turns out Linus already merged this version of the patch. I'll create an update patch 
for the changes and submit it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
