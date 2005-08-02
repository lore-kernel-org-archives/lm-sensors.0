From: jcromie@divsol.com (Jim Cromie)
Date: Tue, 02 Aug 2005 01:15:42 +0000
Subject: [lm-sensors] [patchset 20/23] pc87360 convert temp dev-attrs from
Message-Id: <42EEACFA.60805@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


convert temp dev-attrs from macro-initialization to array initialization,
and call device_create_file() in loop on array

$ diffstat 18-temp-arrys-loop
 pc87360.c |   70 
++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 37 insertions(+), 33 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>

