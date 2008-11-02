From: shaul Karl <shaulkarl@yahoo.com>
Date: Sun, 02 Nov 2008 15:17:58 +0000
Subject: [lm-sensors] tempx_max_hyst > tempx_max?
Message-Id: <157004.2853.qm@web58501.mail.re3.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

etc/sensors3.conf of lm-sensors-3 (1:3.0.2-1+b2) in Debian states that

    # Think of tempx_max as 'alarm set' and tempx_max_hyst as 'alarm clear'
    # thresholds. In most cases the 'max' value should be higher than
    # the 'max_hyst' value by several degrees.

  In what cases would you set the 'max' value equal to the 'max_hyst'
value? Is it pointless for the 'max_hyst' value to be higher than the
'max' value? 
  I would say that the last statement about tempx_max_hyst > tempx_max
is confusing.



      

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
