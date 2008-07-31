From: Souley Madougou <souley.madougou@clustervision.com>
Date: Thu, 31 Jul 2008 10:48:49 +0000
Subject: [lm-sensors] Probable memory leak issue
Message-Id: <48919891.9080507@clustervision.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear developers,

I suspect that there is a memory leak issue in your code. In
sensors_parse_chip_name() you are allocating memory in the following line:
  res->prefix = strndup(name, dash - name);

In some circonstances, this memory is not freed in the sensors_cleanup()
function.

Best regards,
Souley Madougou.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
