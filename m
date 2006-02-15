From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 15 Feb 2006 22:38:21 +0000
Subject: [lm-sensors] HT-1000 smbus
Message-Id: <20060215233821.5628e8ac.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43F105D6.7000500@cdi.cz>
In-Reply-To: <43F105D6.7000500@cdi.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Martin,

> Patch is attached. Is it enough to post it here to be considered ?

Well the fix is quite simple so yes I'll consider it. However there are
a few things I'd like to see added before I accept the patch.

Firstly, please include a Signed-off-by line (see
Documentation/SubmittingPatches for details.)

Secondly, some minimalistic Kconfig and documentation updates would be
needed to mention the HT-1000.

Also, I do agree that the warning about SMBHSTCFG triggers in many
cases where it shouldn't and doing what it suggests then breaks things
more than it helps. We might discard the warning as long as the
documentation is clear about the module parameter which "fixes" the
problem for people who have it (a couple boards only as far as I know -
and I consider it a BIOS bug.) However, this should be made a different
patch as this isn't related to the HT-1000.

Thanks,
-- 
Jean Delvare

