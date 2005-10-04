From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 04 Oct 2005 16:56:14 +0000
Subject: [lm-sensors] Patch for i2c-elektor driver
Message-Id: <7Eq3Me2i.1128437128.3505400.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
In-Reply-To: <eeae3ce2cd160ac835fcb05bb9a2d829@lizardlogic.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Stig,

On 2005-10-04, Stig Telfer wrote:
> Please excuse me if this is not the right place to send a patch.

This is the right place.

> I have updated the i2c-elektor driver to work on kernel 2.6.13.  The
> driver now compiles cleanly and works on my system.  However, I only
> have access to a UP2000 Alpha system to test the i2c-elektor driver.  I
> don't think anything else will be broken by this patch, but I don't
> have an Elektor ISA card to test to be certain.  Does anybody have one?
> Are they still in use?

No idea. I don't have such a card myself, and don't remember anyone
mentioning it for the past two years.

> The patch is available at:
>
> http://www.lizardlogic.co.uk/software/hwmon/elektor-alpha.patch

Could you please follow the usual patch submission procedure? I would
like to apply your patch but can't accept it in its current form. I
would like you to:

1* Sumbit the file itself rather than linking to it. Please also sign it,
by adding a line like:

Signed-off-by: Stig Telfer <email@address>

at the top of the patch.

See Documentation/SubmittingPatches in the Linux kernel source tree for
additional information.

2* Explain in detail why your patch is needed, and how it fixes the
problem you were having.

3* Not include code cleanups in a patch which fixes bugs. I accept code
cleanups, but as a separate patch, to be applied before or after the
bugfixing patch, at your option.

Thanks,
--
Jean Delvare
