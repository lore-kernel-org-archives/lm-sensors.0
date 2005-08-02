From: jcromie@divsol.com (Jim Cromie)
Date: Tue, 02 Aug 2005 00:00:34 +0000
Subject: [lm-sensors] [patchset 0/23] pc87360 convert fan-sensor dev-attr
Message-Id: <42EE9B43.9020406@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


convert fan-sensor dev-attr get-set macros to functions.

[jimc@harpo pset]$ diffstat 09-fan-demacro
 pc87360.c |   77 
+++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 39 insertions(+), 38 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>

