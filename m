From: jcromie@divsol.com (Jim Cromie)
Date: Tue, 02 Aug 2005 01:18:10 +0000
Subject: [lm-sensors] [patchset 22/23] pc87360 convert thermistor dev-attrs
Message-Id: <42EEAD99.6010105@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


convert thermistor dev-attrs from macro-initialization to array 
initialization,
and call device_create_file() in loop on array

$ diffstat 19-therm-arrys-loop
 pc87360.c |   74 
+++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 42 insertions(+), 32 deletions(-)

Signed-off-by:  Jim Cromie <jcromie@divsol.com>


