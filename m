From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Tue, 21 Oct 2008 16:59:30 +0000
Subject: [lm-sensors] [PATCH 0/3] hwmon: (abituguru3) Whitespace cleanups,
Message-Id: <1224608373-27352-1-git-send-email-alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This batch of trivial patches have been properly tested. Please apply.

The first patch removes some superfluous whitespace, and in one place adds
necessary whitespace. These fixes are all cosmetic, and harmless.

The second patch adds the full DMI product string for the AW9D-MAX, enabling
DMI product string matching and a fallback to the legacy probe function on
this board.

The final patch implements partial DMI product string matches, as discussed,
which will hopefully work around possible future bugs. This final patch
relies on the second patch, as it shortens the original (full) DMI product
name. It can be safely dropped if deemed inappropriate.

Jean, if you'd sign off on these patches and queue them up, I'd appreciate it.

 drivers/hwmon/abituguru3.c |   46 ++++++++++++++++++++++++++-----------------
 1 files changed, 28 insertions(+), 18 deletions(-)

--
Cheers,
Alistair.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
