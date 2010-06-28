From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 28 Jun 2010 00:30:55 +0000
Subject: [lm-sensors] Another lm-sensors sysfs / power attribute related
Message-Id: <20100628003055.GA7647@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It seems that the following power related attributes are not supported 
by any drivers.


power[1-*]_input_highest
power[1-*]_input_lowest
power[1-*]_reset_history
power[1-*]_accuracy

Would it make sense to remove or deprecate those attributes, especially since
at least the first three are probably better suited for userland code ?

Also, the sensors command displays the input_highest/input_lowest attributes
as min/max, which is a bit confusing since for all other sensors min/max
means limits, not historic values. If the API is kept, it might be useful
to change the sensors output to something like "hist min" / "hist max".

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
