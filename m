From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Sat, 14 Jun 2008 21:24:53 +0000
Subject: Re: [lm-sensors] [Bug?] W83697: Broken readings for fan speed 10%
Message-Id: <20080614232453.4f27708f@neptune.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080531220339.05dc83fd@neptune.home>
In-Reply-To: <20080531220339.05dc83fd@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 02 June 2008 Jean Delvare <khali@linux-fr.org> wrote:
> One patch you may want to apply it this one:
>   http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023189.html
> It will let you switch the W83697HG chip from automatic fan speed
> control to manual control and back - might be useful to investigate
> the issue you have.

For automatic fan speed control (not limited to this chip), how much
can automatic control be configured?

Some configuration options I do think about:
- temperature thresholds
  (e.g. to choose balance between cool and silent)
- link between temperature input and controlled fan

Are such features provided by the chips (chips of direct interest to me
are IT8712F, nforce420, [W83697HG])

Depending on what chips are capable of, how much of it does lm_sensors
implement and how is it expected to be used?

Bruno

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
