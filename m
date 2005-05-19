From: mda@discerning.com (Mark D. Anderson)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: lm_sensors-2.9.0 inconsistent with linux-ipmi-2.4.29-v34-base.diff
Message-Id: <1113197490.2916.231562416@webmail.messagingengine.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It seems that ipmi-2.4.29-v34-base-.diff added an extra argument
to ipmi_request:

@@ -960,6 +1362,7 @@
                 struct ipmi_addr *addr,
                 long             msgid,
                 struct ipmi_msg  *msg,
+                void             *user_msg_data,
                 int              priority)
 {

and this causes an error in lm_sensors-2.9.0:

kernel/busses/i2c-ipmi.c: In function `ipmi_i2c_send_message':
kernel/busses/i2c-ipmi.c:100: too few arguments to function
`ipmi_request_Rsmp_af6f8fc5'
kernel/busses/i2c-ipmi.c: In function `ipmi_register_bmc':
kernel/busses/i2c-ipmi.c:183: warning: `return' with a value, in
function returning void

I assume the fix is to simply pass in a 5th argument of 0:

-        ipmi_request(i2c_ipmi_user, &address, (long) id, msg, 0);
+        ipmi_request(i2c_ipmi_user, &address, (long) id, msg, 0, 0);


-mda
