From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Wed, 11 Jan 2006 20:31:41 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20060111203140.GA15015@dnil.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

On Sun, Jan 08, 2006 at 03:31:59PM +0100, Daniel Nilsson wrote:
> Now this pretty much solved this issue for me, but I'm wondering if we
> should give Gigabyte a week or two to respond to my request to have
> them debug the root cause? If they don't want to do that I guess we
> could consider this patch to be required in order to use the sensor
> devices on this motherboard....

So I received another answer from Gigabyte, but not a very conclusive
one;

"Hi Daniel,

Thank you for the feedback and offer. We have forwarded your message
and request to our headquarters but have not heard any response from
them yet.

Thus, we are not sure if they plan to disable GPI7 SMI code excution
in the future BIOS release. Becuase it might affect other functions
when the codes are disabled.

We will keep you informed if we received a new BIOS release to work
around this issue. Otherwise, please check our web site for new
versions periodically.

Best regards,

GBT Tech Support"

Sounds like they want to close the ticket... I guess we could still
wait for a new more weeks before submitting the patch, but I'm not
sure that will pay off. Maybe Gigabyte is off investigating this? Who
knows...

Regards
-- 
Daniel Nilsson

