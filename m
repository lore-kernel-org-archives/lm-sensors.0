From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 16:43:41 +0000
Subject: [lm-sensors] Support for Linux 2.6 only drivers
Message-Id: <CvlKYmt2.1129559521.2291660.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <507CF24DDCB8114C82ABCC09CBC1E9EE75C1D3@transtech-2000.transtech.local>
In-Reply-To: <507CF24DDCB8114C82ABCC09CBC1E9EE75C1D3@transtech-2000.transtech.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Steve,

On 2005-10-17, Steve Evans wrote:
> I will be needing user-space support, so an i2c-id.h allocation will be
> required. What's the procedure there besides "You will also need to ask
> us to have an ID reserved"?

This part is inaccurate, most of the time you don't actually need a
driver ID (at least for now). At any rate, the driver ID is not related
to userspace in any way. I'll fix the documentation.

> Unfortunately the detection is a little poor. I wish vendor/device IDs
> had been a compulsory part of the i2c spec!

Oh yeah, I wished that too.

> Given that the devices are very similar I think it would be best to
> conditionally include (or rather exclude) support for the AD7416 and
> AD7418 so that anybody needing support for these devices will at least
> have a good starting point.

Conditional on what? Configuration option?

> Should I send a copy of the driver to the <sensors at stimpy dot
> netroedge.com> alias for comments before proceeding?

Don't know where you found this address, but it is deprecated. I thought
I had ripped off any reference to it in our documentation. Simply post
to this mailing list, and we'll try to review your code as time permits.

Thanks,
--
Jean Delvare
